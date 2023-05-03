/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pfe_app/screens/mps.dart';
import 'package:pfe_app/screens/photoPage.dart';
import 'package:pfe_app/screens/settingsPage.dart';
import 'package:pfe_app/widgets/custom_tag.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home Page',
      home: const Home(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '': (context) => const Home(),
        '/page1': (context) => const Mps(),
        '/page2': (context) => const PhotosPage(),
        '/page3': (context) => const SettingsPage(),
      },
    );
  }
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  List<IconData> listOfIcons = [
    Icons.home,
    Icons.location_on,
    Icons.photo,
    Icons.settings,
  ];

  List<String> listOfStrings = [
    'Home',
    'Location',
    'Photos',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 32, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 21, 4, 34),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          Intro(),
          Qui(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
              });
              // Navigate to the corresponding page when a button is pressed
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/page1');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/page2');
                  break;
                case 3:
                  Navigator.pushNamed(context, '/page3');
                  break;
                case 4:
                  Navigator.pushNamed(context, '/page4');
                  break;
                default:
                  break;
              }
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? const Color.fromARGB(255, 1, 8, 20).withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex ? listOfStrings[index] : '',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Qui extends StatelessWidget {
  const Qui({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text(
            'Hello!',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 3,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our app provides support services for the visually impaired.\n It features real-time location tracking and can capture and transfer the last photo taken by smart glasses, benefiting those with partial vision.\n Our goal is to empower people with visual impairments for greater independence in daily activities.',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 2.25,
                ),
          ),
        ],
      ),
    );
  }
}

class Intro extends StatelessWidget {
  const Intro({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ImageContainer(
        height: MediaQuery.of(context).size.height * 0.45,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        image: 'assets/images/image.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTag(
              backgroundColor:
                  const Color.fromARGB(255, 197, 189, 231).withAlpha(150),
              children: [
                Text(
                  'Welcome to My Eyes! ',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromARGB(255, 241, 240, 245),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'We are excited to have you here. we hope you enjoy your experience with our app. Thanks for choosing My Eyes!',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
            ),
            Text(
              'By SE Engineering',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ));
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.image,
    this.padding,
    this.margin,
    this.child,
  });
  final double width;
  final double height;
  final String image;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double borderRadius;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      margin: margin,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          )),
      child: child,
    );
  }
}*/

