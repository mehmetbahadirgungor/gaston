import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gaston/utils/constants/api_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();

  LatLng? destination;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  late Location location;
  final TextEditingController _addressController = TextEditingController();

  void getCurrentLocation() async {
    location = Location();

    location.getLocation().then((locationData) {
      setState(() {
        currentLocation = locationData;
      });
    });

    location.onLocationChanged.listen((newLocation) async {
      setState(() {
        currentLocation = newLocation;
      });
      getPolyPoints();
    });

    location.getLocation().then((locationData) async {
      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(locationData.latitude!, locationData.longitude!),
        ),
      ));
    });
  }

  void getPolyPoints() async {
    if (currentLocation == null || destination == null) return;

    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleApiKey,
        request: PolylineRequest(
            origin: PointLatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            destination:
                PointLatLng(destination!.latitude, destination!.longitude),
            mode: TravelMode.driving));

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});
    }
  }

  Future<void> getCoordinatesFromAddress(String address) async {
    final url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$googleApiKey";
    try {
      final response = await http.get(Uri.parse(url));
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          destination = LatLng(location['lat'], location['lng']);
        });
        getPolyPoints();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text("Unable to find location: ${data['status']}"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text("An error occurred: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps Destination"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      hintText: "Enter destination address",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    getCoordinatesFromAddress(_addressController.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: currentLocation == null
                ? const Center(
                    child: Text("Loading..."),
                  )
                : GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation!.latitude!, currentLocation!.longitude!),
                      zoom: 13,
                    ),
                    polylines: {
                      Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylineCoordinates,
                        color: Colors.red,
                        width: 5,
                      ),
                    },
                    markers: {
                      Marker(
                        markerId: const MarkerId("currentLocation"),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(
                          currentLocation!.latitude!,
                          currentLocation!.longitude!,
                        ),
                      ),
                      if (destination != null)
                        Marker(
                          markerId: const MarkerId("destination"),
                          icon: BitmapDescriptor.defaultMarker,
                          position: destination!,
                        ),
                    },
                    onMapCreated: (mapController) {
                      _controller.complete(mapController);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
