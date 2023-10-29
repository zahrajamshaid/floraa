
class WeatherData {
  final String temperature;
  final String condition;
  final String humidity;
  final String windSpeed;
  final String visibility;

  WeatherData({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final double temperatureInKelvin = json['main']['temp'];
    final double temperatureInCelsius = temperatureInKelvin - 273.15;
    return WeatherData(
      temperature: '${temperatureInCelsius.toStringAsFixed(1)} °C',
      condition: json['weather'][0]['main'],
      humidity: '${json['main']['humidity']}%',
      windSpeed: '${json['wind']['speed']} m/s',
      visibility: '${json['visibility']} m',
    );
  }
}