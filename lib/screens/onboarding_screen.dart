import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/helpers/constants.dart';
import 'package:weatherapp/screens/home_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _pageController = PageController(initialPage: 0);

  final List<PageViewModel> pages = [
    PageViewModel(
      title: '\nChoose Your Destination !',
      body: '\nGet all your location updates in one touch',
      image: const Center(
        child: Icon(Icons.sunny, size: 200, color: appColor),
      ),
      decoration:  PageDecoration(
        titleTextStyle: const TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: appColor),
        bodyTextStyle: TextStyle(
            fontSize: 22,
            height: 1.5,
            fontWeight: FontWeight.bold,
            color: red),
      ),
    ),
    PageViewModel(
        title: '\nAccess Everywhere !',
        body: '\nLocate your address,Check your current weather ',
        image: const Center(
            child: Icon(
          CupertinoIcons.cloud_bolt_rain_fill,
          size: 200,
          color: appColor,
        )
            //Image.asset('assets/images/onb2.png'),
            ),
        decoration:  PageDecoration(
            titleTextStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: appColor),
            bodyTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.5,
                color: red))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(8, 8),
            color: Color(0xFF218CB5),
            activeSize: Size.square(15),
            activeColor: blackColor,
          ),
          showDoneButton: true,
          done: const Text(
            ' Done',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          showSkipButton: true,
          skip: InkWell(
            onTap: () async {
              _completeOnboarding().then((_) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              });
            },
            child:  const Text(
              'Skip',
              style: TextStyle(fontSize: 20, color: blackColor),
            ),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 25,
            color: blackColor,
          ),
          onDone: () {
            _completeOnboarding().then((value){});
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          },
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  Future _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIns', true);
  }
}
