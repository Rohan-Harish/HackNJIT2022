import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Networking {
  String _ip = '';
  String _port = '';

  Networking(String ip, String port) {
    _ip = ip;
    _port = port;
  }

  Future<http.Response> sendPost(String endpoint, Object body) {
    print(_ip + "/" + endpoint);
    Map<String, String> headers = {
      "from": "cleanCartApp",
    };
    return http.post(Uri.parse("$_ip/$endpoint"),
        headers: headers, body: jsonEncode(body));
  }
}
