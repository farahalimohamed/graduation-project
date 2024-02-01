import 'dart:async';

import 'package:ambulance_track/constants.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AmbulanceScreen extends StatefulWidget {
  LatLng userloc;

  AmbulanceScreen({required this.userloc});

  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  ////////////get ambulance location//////////////////
  Future<LatLng> getUserLoc() async {
    final response = await http.get(
      Uri.parse('${localhost}getConnection/$ambId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("a333 ${response.statusCode}");
    final responseBody = jsonDecode(response.body);
    double userLat = double.parse(responseBody['userloc']['lat']);
    double userLng = double.parse(responseBody['userloc']['lng']);
    print(userLat);
    return LatLng(userLat, userLng);
  }

  void _updateData(Timer timer) async {
    // This function will be called every 5 seconds
    widget.userloc = await getUserLoc();
    setState(() {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 16.0,
          ),
        ),
      );
    });

    // Fetch the updated user location
    await fetchCurrentLocation();
  }

  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    fetchCurrentLocation();
    Timer.periodic(Duration(seconds: 5), _updateData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.userloc,
          zoom: 16,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }

  //////////// fetch and update user location in backend////////////////////
  Future<void> fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _markers.add(
      Marker(
        markerId: MarkerId('ambulanceLocation'),
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId('userLocation'),
        position: LatLng(widget.userloc.latitude, widget.userloc.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDkWapKK5xx_BkMSLYDQjrV6IIaM4W-rSE',
      PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
      PointLatLng(widget.userloc.latitude, widget.userloc.longitude),
      travelMode: TravelMode.driving, // Replace with your preferred travel mode
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: PolylineId('polyline'),
            color: Colors.blue,
            width: 5,
            points: polylineCoordinates,
          ),
        );
        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(
                _currentPosition.latitude,
                _currentPosition.longitude,
              ),
              northeast: LatLng(
                widget.userloc.latitude,
                widget.userloc.longitude,
              ),
            ),
            300.0,
          ),
        );
      });
    }
    ///////////back update loc///////////
    Map data = {
      'id': "$ambId",
      'Lat': _currentPosition.latitude,
      'Lng': _currentPosition.longitude
    };
    final response = await http.post(
      Uri.parse('${localhost}updateAmbulanceLoc/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
  }
}
