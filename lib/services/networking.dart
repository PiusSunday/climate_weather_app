import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  
  final Uri url;

  NetworkHelper(this.url);

  Future getData() async {

    // Use the URL passed when initializing the NetworkHelper Class to make HTTP get request.
    http.Response response = await http.get(url);

    // Check if the response is successful.
    if (response.statusCode == 200) {
      
      // If the response is successful, put it a variable.
      String responseBody = response.body;
      
      // Convert/Decode the responseBody to a JSON object.
      // If the response is successful, return the JSON data.
      return jsonDecode(responseBody);

    } else {
      // If the response is not successful, print an error.
      var responseStatusCode = response.statusCode;
      print(responseStatusCode);
    }
  }
}
