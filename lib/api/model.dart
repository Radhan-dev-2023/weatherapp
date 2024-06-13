class WeatherModel {
  final String? temp;
  final String? city;
  final String? desc;
  final String? tempMax;
  final String? tempMin;
  final String? tempHumidity;
  final String? tempPressure;
  final String? wind;
  final int? sunRise;
  final int? sunSet;
  final String? rain;
  final String? timeZone;
  final String? visibility;
  final String? clouds;

  WeatherModel.fromMap(
    Map<String, dynamic> json,
  )   : temp = json['main']['temp'].toString(),
        visibility = json['visibility'].toString(),
        clouds = json['clouds']['all'].toString(),
        city = json['name'],
        tempMax = json['main']['temp_max'].toString(),
        tempMin = json['main']['temp_min'].toString(),
        wind = json['wind'] != null ? json['wind']['speed'].toString() : null,
        tempHumidity = json['main']['pressure'].toString(),
        tempPressure = json['main']['humidity'].toString(),
        //wind=json['wind']['speed'].toString(),
        rain = json['rain'] != null ? json['rain']['1h'].toString() : null,
        sunRise = json['sys']['sunrise'] as int,
        sunSet = json['sys']['sunset'] as int,
        timeZone = json['timezone'].toString(),
        desc = json['weather'][0]['description'];
}
