import 'dart:convert';

import 'package:flutter_trip/model/travel_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_URL = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

///旅拍页接口
var Params = {
  "districtId": -1,
  "groupChannelCode": "RX-OMF",
  "type": null,
  "lat": -180,
  "lon": -180,
  "locatedDistrictId": 0,
  "pagePara": {
    "pageIndex": 1,
    "pageSize": 10,
    "sortType": 9,
    "sortDirection": 0
  },
  "imageCutType": 1,
  "head": {},
  "contentType": "json"
};

class TravelDao {
  static Future<TravelItemModel> fetch(
      String url, String groupChannelCode, int pageIndex, int pageSize) async {
    print('传入的参数:url${url},groupChannelCode:${groupChannelCode}');
    //动态改变json中固定的参数
    Map paramsMap = Params['pagePara'];
    paramsMap['pageIndex'] = pageIndex;
    paramsMap['pageSize'] = pageSize;
    Params['groupChannelCode'] = groupChannelCode;
    print('groupChannelCode:${groupChannelCode}');
    final response = await http.post(url, body: jsonEncode(Params));
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); //fix 中文乱码问题
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      print('TravelTabModel: ${result}');
      return TravelItemModel.fromJson(result);
    } else {
      throw Exception('Failed to load travel');
    }
  }
}
