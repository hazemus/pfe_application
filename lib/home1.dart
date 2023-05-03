import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pfe_app/login_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage1> {
  late FirebaseStorage storage;
  late String imageUrl = '';
  String _locationMessage = "";
  Location _location = Location();
  @override
  void initState() {
    storage = FirebaseStorage.instance;
    super.initState();

    _requestPermission();
  }

  Future<File> _downloadImage(String url) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String fileName = url.split('/').last;
    File file = File('$tempPath/$fileName');
    if (file.existsSync()) {
      return file;
    }
    final ref = storage.refFromURL(url);
    await ref.writeToFile(file);
    return file;
  }

  void _seePhotos() async {
    String url = "gs://pfeapp-bc690.appspot.com/SELOGO.jpg";
    File file = await _downloadImage(url);

    setState(() {
      imageUrl = file.path;
    });
  }

  Future<void> _requestPermission() async {
    var permission = await _location.requestPermission();
    if (permission == PermissionStatus.granted) {
      _getLocation();
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

  int _selectedIndex = 0;
  List<Widget> _pages = [];

  @override
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
    print('Logout');
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      PageWithText('Home'),
      PageWithButton(_locationMessage, 'Open Map', _openMap, ''),
      PageWithButton('Photos', 'See Photos', _seePhotos, imageUrl),
      PageWithButton('About Us', '', _logout, ''),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('My Eyes'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.photo_album),
            label: 'Photos',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: Icon(Icons.person),
            label: 'About Us',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class PageWithButton extends StatelessWidget {
  final String title;
  final String buttonLabel;
  final VoidCallback buttonFunction;
  final String imageUrl;

  PageWithButton(
      this.title, this.buttonLabel, this.buttonFunction, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          if (buttonLabel
              .isNotEmpty) // Show the button if the label is not empty
            ElevatedButton(
              onPressed: buttonFunction,
              child: Text(buttonLabel),
            ),
          if (buttonLabel.isEmpty) // Show the text if the label is empty
            Text('THIS IS THE ABOUT US PAGE',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.black,
                    )),
          if (imageUrl.isNotEmpty) // Show the image if the URL is not empty
            Image.file(
              File(imageUrl),
              height: 200,
            ),
        ],
      ),
    );
  }
}

class PageWithText extends StatefulWidget {
  final String title;
  PageWithText(this.title);

  @override
  State<PageWithText> createState() => _PageWithTextState();
}

class _PageWithTextState extends State<PageWithText> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
          ),
          Text(
            'Welcome to My Eyes! ',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            'We are excited to have you here. we hope you enjoy your experience with our app. Thanks for choosing My Eyes!',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            'By SE Engineering',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            'Hello!',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          Text(
            'Our app provides support services for the visually impaired.\n It features real-time location tracking and can capture and transfer the last photo taken by smart glasses, benefiting those with partial vision.\n Our goal is to empower people with visual impairments for greater independence in daily activities.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.black,
                ),
          )
        ],
      ),
    );
  }
}
