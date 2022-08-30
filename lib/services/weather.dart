import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '6732ece69f6fc46e491c5e8b5f3dd2d3';

class WeatherModel {
  
  Future<dynamic> getCityWeather(String cityName) async {
    
    var url = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
      },
    );

    
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    
    return weatherData;
  }

  // Get the Current Location and Weather Data.
  Future<dynamic> getLocationWeather() async {
    double? latitude;
    double? longitude;

    // Create an instance/object of the Location class.
    Location location = Location();

    // Use the location object to tap into the getCurrentLocation Method...
    // which uses the GeoLocation API Package...
    // to get the current position of the device.
    await location.getCurrentLocation();

    // Get the latitude and longitude of the current position.
    latitude = location.latitude;
    longitude = location.longitude;

    // Put the latitude and longitude in the Uri to get the weather data.
    NetworkHelper networkHelper = NetworkHelper(
      Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: '/data/2.5/weather',
        queryParameters: {
          'lat': '$latitude',
          'lon': '$longitude',
          'appid': apiKey,
          'units': 'metric',
        },
      ),
    );

    // Use the NetworkHelper to get the weather data.
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getWeatherMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
