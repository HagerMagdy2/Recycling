import 'package:firstly/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  Set<Marker> markers = {};
  String selectedAddress = '';

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      markers.add(Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude),
      ));
    });

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      selectedAddress = placemarks[0].name!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: kMainColor,
        title:
            Text('Pick Your Location', style: TextStyle(color: Colors.white)),
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
                selectedAddress = placemarks[0].name!;
              });
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(30.1, 30.1),
            ),
            markers: markers,
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
                    'Save',
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
                      'Selected Address:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$selectedAddress',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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