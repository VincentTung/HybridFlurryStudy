import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lib_flutter/cfg/url.dart';
import 'package:lib_flutter/entity/banner.dart';
import 'package:lib_flutter/net/httputil.dart';

class ApiHelper {
  ///banner信息
  static Future<List<Banner>> getBanner() async {
    Response response = await HttpUtil.getInstance().get(URL_BANNER);
    User aUser = User.fromJson(json.decode(response.toString()));
    return aUser;
  }
}
