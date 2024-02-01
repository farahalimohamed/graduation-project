//AIzaSyDkWapKK5xx_BkMSLYDQjrV6IIaM4W-rSE
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import '../../constants.dart';
import '../Login/login_screen.dart';
import '../chats/chats_screen.dart';
import '../home/home_screen.dart';
import '../settings/profile.dart';
import '../settings/setting_page.dart';
import 'pharmacy.dart';

class Pharmacy {
  final String name;
  final String address;
  final double rating;
  final Map<String, dynamic> openingHours;
  final double latitude;
  final double longitude;
  final double distance;

  Pharmacy({
    required this.name,
    required this.address,
    required this.rating,
    required this.openingHours,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });
}

class PharmacyListScreen extends StatefulWidget {
  @override
  _PharmacyListScreenState createState() => _PharmacyListScreenState();
}

class _PharmacyListScreenState extends State<PharmacyListScreen> {
  final String apiKey = 'AIzaSyDkWapKK5xx_BkMSLYDQjrV6IIaM4W-rSE';
  List<Pharmacy> pharmacies = [];
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    fetchCurrentLocation();
  }

  Future<void> fetchCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied
      return;
    }

    if (permission == LocationPermission.denied) {
      // Location permissions are denied, ask for permissions
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permissions are denied
        return;
      }
    }

    // Fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });

    fetchNearbyPharmacies(position.latitude, position.longitude);
  }

  Future<void> fetchNearbyPharmacies(double latitude, double longitude) async {
    if (currentPosition == null) {
      return;
    }

    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentPosition!.latitude},${currentPosition!.longitude}&radius=5000&type=pharmacy&key=$apiKey';
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'OK') {
        List<dynamic> results = data['results'];
        List<Pharmacy> nearbyPharmacies = [];
        for (var pharmacyData in results) {
          String name = pharmacyData['name'];
          String address = pharmacyData['vicinity'];
          double rating = pharmacyData.containsKey('rating')
              ? pharmacyData['rating'].toDouble()
              : 0.0;
          Map<String, dynamic> openingHours =
              pharmacyData.containsKey('opening_hours')
                  ? pharmacyData['opening_hours']
                  : {};
          double pharmacyLatitude =
              pharmacyData['geometry']['location']['lat']; // Extract latitude
          double pharmacyLongitude =
              pharmacyData['geometry']['location']['lng'];

          double distance = Geolocator.distanceBetween(
            latitude,
            longitude,
            pharmacyLatitude,
            pharmacyLongitude,
          );

          Pharmacy pharmacy = Pharmacy(
            name: name,
            address: address,
            rating: rating,
            openingHours: openingHours,
            latitude: pharmacyLatitude,
            longitude: pharmacyLongitude,
            distance: distance,
          );
          nearbyPharmacies.add(pharmacy);
        }
        // Sort pharmacies based on distance (from nearest to farthest)
        nearbyPharmacies.sort((a, b) => a.distance.compareTo(b.distance));
        setState(() {
          pharmacies = nearbyPharmacies;
        });
      } else {
        print('Failed to fetch hospitals. Error: ${data['status']}');
      }
    } else {
      print('Failed to fetch hospitals. Error: ${response.statusCode}');
    }
  }

  Widget _buildPharmacyItem(Pharmacy pharmacy) {
    bool isOpenNow = false;

    if (pharmacy.openingHours.containsKey('open_now')) {
      isOpenNow = pharmacy.openingHours['open_now'];
    }

    String openingHoursText = 'Closed';

    if (isOpenNow) {
      openingHoursText = 'Open Now';
    }
    return ListTile(
      title: Text(pharmacy.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Address: ${pharmacy.address}'),
          Text('Rating: ${pharmacy.rating}'),
          Text('Opening Hours: $openingHoursText'),
        ],
      ),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Color(0xff566CA6),
          elevation: 5,
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PharmacyMapScreen(
              pharmacyLatitude: pharmacy.latitude,
              // Pass the latitude of the pharmacy
              pharmacyLongitude: pharmacy.longitude,
              pharmacyName: pharmacy.name,
              pharmacyAddress: pharmacy.address,
            ),
          ),
        ),
        child: Text('Map'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD7DCE7),
      bottomNavigationBar: _Navbar1(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFD7DCE7),
        title: Text(
          'Nearby Pharmacies',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       right: 6,
        //     ),
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.account_circle_outlined,
        //         size: 35,
        //         color: Colors.black,
        //       ),
        //       onPressed: (){},
        //       // onPressed: () => Navigator.push(
        //       //   context,
        //       //   MaterialPageRoute(
        //       //     builder: (context) => ProfilePage(),
        //       //   ),
        //       // ),
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: pharmacies.length, // Rename hospitals to pharmacies
              itemBuilder: (context, index) {
                final pharmacy =
                    pharmacies[index]; // Rename hospital to pharmacy
                return _buildPharmacyItem(
                    pharmacy); // Rename _buildHospitalItem to _buildPharmacyItem
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _Navbar1() {
    int _selectedIndex = 0;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 35,
            color: Colors.black.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            iconSize: 35.0,
            icon: const Icon(Icons.home),
            color: Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.chat),
            color: Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
              if (userId == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileLoginScreen(
                      widid: 2,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatsScreen(),
                  ),
                );
              }
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.settings),
            color: Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            iconSize: 30.0,
            icon: Icon(Icons.person),
            color: Colors.grey.withOpacity(0.7),
            onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
              if (userId == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MobileLoginScreen(
                      widid: 2,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
