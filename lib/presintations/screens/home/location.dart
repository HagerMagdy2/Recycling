import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Set<Marker> markers = {};
  String selectedAddress = '';
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, don't continue.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can get the position.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Update the map and marker.
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
      ));
    });

    // Move the camera to the current location.
    final GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));

    // Get the address of the current location.
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      selectedAddress = placemarks[0].name ?? 'Unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        foregroundColor: Colors.white,
        title: Text(
          tr('Pick Your Location'),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onTap: (LatLng location) async {
              markers.clear();
              markers.add(Marker(
                markerId: MarkerId('selectedLocation'),
                position: location,
              ));
              setState(() {});

              List<Placemark> placemarks = await placemarkFromCoordinates(
                  location.latitude, location.longitude);
              setState(() {
                selectedAddress = placemarks[0].name ?? 'Unknown';
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(30.1, 30.1),
              zoom: 14.0, // Adjust the initial zoom level.
            ),
            markers: markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            bottom: 10,
            left: 150,
            right: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedAddress);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 219, 77, 67)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    tr('Save'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      tr('Selected Address:'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        selectedAddress,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
