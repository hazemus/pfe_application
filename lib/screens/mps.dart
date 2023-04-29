import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Mps extends StatefulWidget {
  const Mps({Key? key}) : super(key: key);

  @override
  State<Mps> createState() => _MpsState();
}

class _MpsState extends State<Mps> {
  String _locationMessage = "";
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  Future<void> _requestPermission() async {
    var permission = await _location.requestPermission();
    if (permission == PermissionStatus.granted) {
      _getLocation();
      _openMap();
    }
  }

  Future<void> _getLocation() async {
    try {
      var currentLocation = await _location.getLocation();
      setState(() {
        _locationMessage =
            "Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _openMap() async {
    var currentLocation = await _location.getLocation();
    var url =
        "https://www.google.com/maps/search/?api=1&query=${currentLocation.latitude},${currentLocation.longitude}";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Location App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                _locationMessage,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
