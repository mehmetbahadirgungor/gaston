import 'dart:async';
import 'package:gaston/features/shop/controllers/product/order_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gaston/utils/constants/api_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final orderController = Get.put(OrderController());

  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destination = LatLng(41.091884, 29.094327);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  late Location location;

  // Getting the current location of the phone
  void getCurrentLocation() async {
    location = Location();

    // When the location is obtained, update the map center
    location.getLocation().then((locationData) {
      setState(() {
        currentLocation = locationData;
      });
    });

    // Update the map when the location changes
    location.onLocationChanged.listen((newLocation) async {
      setState(() {
        currentLocation = newLocation;
      });
      // Update the polyline
      getPolyPoints();
    });

    location.getLocation().then((locationData) async {
      // Adjust the map camera position based on the current location
      GoogleMapController googleMapController = await _controller.future;
      googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: 13.5,
          target: LatLng(locationData.latitude!, locationData.longitude!),
        ),
      ));
    });
  }

  // Drawing a polyline between the phone's current location and the destination
  void getPolyPoints() async {
    if (currentLocation == null) return;

    PolylinePoints polylinePoints = PolylinePoints();

    // If there is a current location, create a new route
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleApiKey, // Place your own API key here
        request: PolylineRequest(
            origin: PointLatLng(
                currentLocation!.latitude!, currentLocation!.longitude!),
            destination:
                PointLatLng(destination.latitude, destination.longitude),
            mode: TravelMode.driving));

    // Update the polyline only with the valid points
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear(); // Clear the old polyline
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {}); // Update the UI
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation(); // Get the location at the start
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
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
                const Marker(
                  markerId: MarkerId("destination"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: destination,
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
