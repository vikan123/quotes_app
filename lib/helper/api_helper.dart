import 'dart:convert';
import 'package:get/get.dart';
import 'package:quotes_app/modal/api.dart';
import 'package:http/http.dart' as http;
import '../get/api_controller.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  List<ApiModal> allQuotes = [];
  static ApiController apiController = Get.find();

  final String api =
      "https://type.fit/api/quotes?limit=10&query=${apiController}";

  Future<List<ApiModal>?> getApi() async {
    http.Response res = await http.get(Uri.parse(api),
        headers: {'x-Api-Key': 'mqkCxGvWNd8ALLDdVfC0kVb2CTyJrJmGurVDEdPX'});

    if (res.statusCode == 200) {
      List quotes = jsonDecode(res.body);
      allQuotes = quotes.map((e) => ApiModal.fromApi(data: e)).toList();
      return allQuotes;
    }
  }
}