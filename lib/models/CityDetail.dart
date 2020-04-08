class CityDetail {
  String name;
  String country;
  int temperature;
  String description;
  String weatherIcon;
  int feelsLike;
  int humidity;
  int windSpeed;
  int cloudCover;
  int visibility;

  CityDetail({
    this.name,
    this.country,
    this.temperature,
    this.description,
    this.weatherIcon,
    this.feelsLike,
    this.humidity,
    this.windSpeed,
    this.cloudCover,
    this.visibility,
  });

  factory CityDetail.fromJSON(Map<String, dynamic> json) {
    return CityDetail(
      name: json['location']['name'] as String,
      country: json['location']['country'] as String,
      temperature: json['current']['temperature'] as int,
      description: json['current']['weather_descriptions'][0] as String,
      weatherIcon: json['current']['weather_icons'][0] as String,
      feelsLike: json['current']['feelslike'] as int,
      humidity: json['current']['humidity'] as int,
      windSpeed: json['current']['wind_speed'] as int,
      cloudCover: json['current']['cloudcover'] as int,
      visibility: json['current']['visibility'] as int,
    );
  }
}