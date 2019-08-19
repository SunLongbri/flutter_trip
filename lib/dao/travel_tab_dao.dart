import 'dart:convert';

import 'package:flutter_trip/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍类别接口
class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    final response = await http.get(TRAVEL_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print('TravelTabModel: ${result}');
      return TravelTabModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel_page.json');
    }
  }
}
