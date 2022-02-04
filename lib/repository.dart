import 'package:dio/dio.dart';

class ApiCall {
  Dio dio = Dio();

  Future<dynamic> getPhoto() async {
    Options option = Options(headers: {
      "Authorization": "ReBXZ51-VO2HMQsbkr4wNuzrPhwRKZkCVehf25gY2ds"
    });
    final client = "ux3DkRF7XrKROn-6FBalvyracO0ajdvl2D8K5JphWx4";
    final response = await dio.get(
        "https://api.unsplash.com/photos?client_id=$client",
        options: option);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return null;
    }
  }
}
