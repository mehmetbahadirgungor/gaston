import 'dart:async';
import 'package:gaston/features/shop/controllers/product/order_controller.dart';
import 'package:gaston/features/shop/models/order_model.dart';
import 'package:gaston/geocoding_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gaston/utils/constants/api_constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  final OrderModel order;
  const MapPage({super.key, required this.order});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Timer _timer;

  final Completer<GoogleMapController> _controller = Completer();

  static late LatLng destination;
  static late LatLng currentLocation2;

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  // Getting the current location of the phone
  void getCurrentLocation() async {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        destination = GeocodingRepository.locationToGeocode(widget.order.address!.geocode);
        currentLocation2 = GeocodingRepository.locationToGeocode(widget.order.staffGeocode!);
        getPolyPoints();
      });
    });

    // Adjust the map camera position based on the current location
    GoogleMapController googleMapController = await _controller.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        zoom: 13.5,
        target: LatLng(currentLocation2.latitude, currentLocation2.longitude),
      ),
      ));
  }

  // Drawing a polyline between the phone's current location and the destination
  void getPolyPoints() async {

    PolylinePoints polylinePoints = PolylinePoints();

    // If there is a current location, create a new route
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleApiKey, // Place your own API key here
        request: PolylineRequest(
            origin: PointLatLng(
                currentLocation2.latitude, currentLocation2.longitude),
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
    currentLocation2 = GeocodingRepository.locationToGeocode(widget.order.staffGeocode!);
    destination = GeocodingRepository.locationToGeocode(widget.order.address!.geocode);
    getCurrentLocation(); // Get the location at the start
  }

  @override
  void dispose() {
    // Timer'ı temizlemeyi unutmayın
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation2.latitude, currentLocation2.longitude),
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
                    currentLocation2.latitude,
                    currentLocation2.longitude,
                  ),
                ),
                Marker(
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
