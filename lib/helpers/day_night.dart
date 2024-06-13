

Future<String> getGreeting() async {
  final now = DateTime.now();
  bool isDayTime = now.hour >= 6 && now.hour < 18;
  return isDayTime ? "Day" : "Night";
}


