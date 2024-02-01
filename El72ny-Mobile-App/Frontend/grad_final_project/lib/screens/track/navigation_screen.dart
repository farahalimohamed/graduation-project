import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../constants.dart';
import '../home/home_screen.dart';

class AmbulanceScreen extends StatefulWidget {
  LatLng ambulanceloc;

  AmbulanceScreen({required this.ambulanceloc});

  @override
  _AmbulanceScreenState createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  ////////////get ambulance location//////////////////
  Future<LatLng> getAmbulanceLoc() async {
    final response = await http.get(
      Uri.parse('$localhost/api/getConnection/$ambId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("a333 ${response.statusCode}");
    final responseBody = jsonDecode(response.body);
    double ambLat = double.parse(responseBody['ambloc']['lat']);
    double ambLng = double.parse(responseBody['ambloc']['lng']);
    return LatLng(ambLat, ambLng);
  }

  ///////////// Cancel the connection/////////////
  Future<void> cancelConnection() async {
    final response = await http.post(
      Uri.parse('$localhost/api/deleteConnection/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({"uid": userId}),
    );
    if (response.statusCode == 200) {
      casee = '';
      ambId = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
      print("deleted successfully");
    } else {
      print("not deleted");
    }
  }

  void _updateData(Timer timer) async {
    // This function will be called every 5 seconds
    widget.ambulanceloc = await getAmbulanceLoc();
    setState(() {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: widget.ambulanceloc,
            zoom: 16.0,
          ),
        ),
      );
    });

    // Fetch the updated user location
    await fetchCurrentLocation();

    //compare the location if within 10 meters show pop up
    double dis = Geolocator.distanceBetween(
        _currentPosition.latitude,
        _currentPosition.longitude,
        widget.ambulanceloc.latitude,
        widget.ambulanceloc.longitude);
    if (dis <= 10) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tracking Notification'),
            content: Text('Has the ambulance Arrived?'),
            actions: <Widget>[
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  timer.cancel();
                  await cancelConnection();
                },
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        },
      );
    }
  }

  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    fetchCurrentLocation();
    Timer timer = Timer.periodic(Duration(seconds: 5), _updateData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.ambulanceloc,
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

  //////////// fetch and update ambulance location in backend////////////////////
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
        markerId: MarkerId('userLocation'),
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
      ),
    );
    final image = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/emergency-services.png');
    _markers.add(
      Marker(
        markerId: MarkerId('ambulanceLocation'),
        position:
            LatLng(widget.ambulanceloc.latitude, widget.ambulanceloc.longitude),
        // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        icon: image,
      ),
    );

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> polylineCoordinates = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDkWapKK5xx_BkMSLYDQjrV6IIaM4W-rSE',
      PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
      PointLatLng(widget.ambulanceloc.latitude, widget.ambulanceloc.longitude),
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
                widget.ambulanceloc.latitude,
                widget.ambulanceloc.longitude,
              ),
            ),
            300.0,
          ),
        );
      });
    }
    ///////////back update loc///////////
    Map data = {
      'user_id': "$userId",
      'Lat': _currentPosition.latitude,
      'Lng': _currentPosition.longitude
    };
    final response = await http.post(
      Uri.parse('${localhost}/api/updateUserLoc/'),
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.statusCode);
  }
}
