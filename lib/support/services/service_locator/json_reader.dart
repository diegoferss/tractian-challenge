import 'dart:convert';

import 'package:flutter/services.dart';

abstract class JsonReader {
  Future<List<dynamic>> read({required String path});
}

class JsonReaderImpl extends JsonReader {
  @override
  Future<List<dynamic>> read({required String path}) async {
    final json = await rootBundle.loadString(path);
    return jsonDecode(json);
  }
}
