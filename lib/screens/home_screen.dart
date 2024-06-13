
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/helpers/constants.dart';
import 'package:weatherapp/helpers/container_widget.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:weatherapp/helpers/error_data.dart';
import 'package:weatherapp/screens/onboarding_screen.dart';


import '../api/call_api.dart';
import '../api/model.dart';
import '../helpers/bottom_sheet.dart';
import '../helpers/day_night.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
    return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
  }

  TextEditingController textController = TextEditingController(text: "");
  Future<WeatherModel>? _myData;

  @override
  void initState() {
    setState(() {
      _myData = getData(true, "");
    });

    super.initState();
  }
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'WEATHER APP',
          style: TextStyle(
              fontSize: 18, color: Color(0xFF218CB5), fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Are you sure you want to exit the app',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF218CB5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF218CB5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7))),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                       OnBoardingScreen()));
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ).then((value) {
      if (value == true) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        backgroundColor: indigo,
        body: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return WillPopScope(onWillPop:_onBackPressed,child: errorData());
              } else if (snapshot.hasData) {
                final data = snapshot.data as WeatherModel;
                final imageUrl = getImageUrl(data.desc ?? "");
                return SafeArea(
                  maintainBottomViewPadding: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(

                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2,
                                color: grey,
                              ),
                            ),
                            height: MediaQuery.of(context).size.height * 0.98,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: double.infinity,
                                  width: double.maxFinite,

                                  child:

                                  Image.network(
                                   imageUrl,
                                  // "https://i.pinimg.com/originals/48/bd/7c/48bd7c6e9b128643ba415cea5c6b3ede.gif",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 30,
                                  child: FutureBuilder<String>(
                                    future: getGreeting(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return  const Text(
                                          'Error',
                                          style: TextStyle(
                                            color: blackColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        return Text(
                                            snapshot.data!.contains("Day")
                                                ? "☀️ Day"
                                                : "🌙 Night",
                                            style: fRedBoldHigh);
                                      }
                                    },
                                  ),
                                ),
                                Positioned(
                                  top: 60,
                                  right: 15,
                                  child: AnimSearchBar(
                                    helpText: "Search by Location.....",
                                    rtl: true,
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
                                    color:  appColor,
                                    textController: textController,
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      color: white,
                                      size: 26,
                                    ),
                                    onSuffixTap: () async {
                                      textController.text == ""
                                          ? const Text("No city entered")
                                          : setState(() {
                                              _myData = getData(
                                                  false, textController.text);
                                            });

                                      FocusScope.of(context).unfocus();
                                      textController.clear();
                                    },
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: blackColor,
                                        letterSpacing: 2),
                                    onSubmitted: (String) {},
                                  ),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.19,
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  child: Text("📍 ${data.city ?? ""}",
                                      style: fRedBoldHigh),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.24,
                                  left: MediaQuery.of(context).size.width*0.03,
                                  child: customContainer(
                                    ctx,
                                    "${data.wind??"12"} m/s",

                                    "${data.clouds??"0"} %",
                                    blackColor,
                                    "assets/icons/windy.png",
                                    "assets/icons/clouds_icon.png",
                                    "Wind",
                                    "Clouds",
                                  ),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.45,
                                  left: MediaQuery.of(context).size.width*0.03,
                                  child: customContainer(
                                      ctx,
                                      "${data.tempPressure??"12"} hPa",
                                      "${data.rain?.substring(0,3)??"12"} %",
                                      green,
                                      "assets/icons/pressure.png",

                                      "assets/icons/rain.png",
                                      "Pressure",
                                      "Rain"),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.65,
                                  left: MediaQuery.of(context).size.width*0.03,
                                  child: customContainer(
                                    ctx,

                                    "${data.tempHumidity?.substring(0,3)??"545"} %",
                                    "${data.visibility?.substring(0,3)??"545"} m",
                                    green,
                                    "assets/icons/low-visibility.png",
                                    "assets/icons/humidity.png",

                                    "Humidity",
                                    "Visiblity",

                                  ),
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.90,
                                  left: 10,
                                  child: Text(
                                    "Weather is ${data.desc ?? "Mist"} now.",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Text(
                            "More To Know",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: indigo,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: MediaQuery.of(ctx).size.height * 0.48,
                              decoration: BoxDecoration(
                                color: blue,
                                image: DecorationImage(

                                  image: NetworkImage(
                                    imageUrl
                                    //"https://i.pinimg.com/originals/48/bd/7c/48bd7c6e9b128643ba415cea5c6b3ede.gif",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 2,
                                  color:grey,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  sheet(
                                      ctx,
                                      CupertinoIcons.thermometer_sun,
                                      "${data.tempMax??"22"} °C",
                                      CupertinoIcons.thermometer,
                                      "${data.tempMin??"12"} °C",
                                      "Temp High",
                                      "Temp Low"),
                                  const SizedBox(height: 20),
                                  sheet(
                                      ctx,
                                      CupertinoIcons.sunrise,

                                      _convertUnixTo12HourFormat(data.sunRise ?? 0),
                                      CupertinoIcons.sunset,
                                      _convertUnixTo12HourFormat(data.sunSet ?? 0),
                                      "SunRise",
                                      "Sunset"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            } 
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(

                child: Container(
                  color: const Color(0xFF218CB5),
                  height: double.infinity,width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network("https://i.pinimg.com/originals/75/16/ea/7516ea5454d6ebb256d2ecb34b66a95c.gif",),
                        const Text("LOADING ......",style: TextStyle(fontWeight: FontWeight.bold,color: white,fontSize: 22),)
                      ],
                    )),
              );
            } else {
              return Center(
                child: Text("${snapshot.connectionState} occured"),
              );
            }
            return const Center(
              child: Text("Server timed out!"),
            );
          },
          future: _myData,
        ));
  }
  String _convertUnixTo12HourFormat(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true);
    final localDate = date.toLocal();
    final format = DateFormat('h:mm a');
    return format.format(localDate);
  }
  String getImageUrl(String description) {
    if (description.toLowerCase().contains("clear sky")) {
      return "https://i.pinimg.com/originals/48/bd/7c/48bd7c6e9b128643ba415cea5c6b3ede.gif";
    } else if (description.toLowerCase().contains("sunny")) {
      return "https://i.makeagif.com/media/12-22-2017/LlqpSd.gif";
    }
    else if(description.toLowerCase().contains("haze")){
      return "https://images.bhaskarassets.com/web2images/521/2024/01/23/_1705981803.gif";
    }
    else if(description.toLowerCase().contains("light rain")){
      return "https://www.icegif.com/wp-content/uploads/2023/03/icegif-526.gif";
    }
    else if(description.toLowerCase().contains("heavy intensity rain")){
      return "https://www.icegif.com/wp-content/uploads/2023/03/icegif-526.gif";
    }
    else if(description.toLowerCase().contains("few clouds")){
      return "https://i.pinimg.com/originals/48/bd/7c/48bd7c6e9b128643ba415cea5c6b3ede.gif";
    }
    else if(description.toLowerCase().contains("clouds")){
      return "https://i.pinimg.com/originals/48/bd/7c/48bd7c6e9b128643ba415cea5c6b3ede.gif";
    }
    else if(description.toLowerCase().contains("mist")){
      return "https://i.pinimg.com/originals/cc/51/a3/cc51a378a4accec027b87361dab54217.gif";

    }
    else if(description.toLowerCase().contains("rain")){
      return "https://theapopkavoice.com/uploads/original/20230712-183836-header_raining.gif";

    }

    else {
      return "https://i.makeagif.com/media/12-22-2017/LlqpSd.gif";
    }
  }
}
