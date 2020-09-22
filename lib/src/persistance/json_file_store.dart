import 'dart:convert';
import 'dart:io';
import 'package:file_store/src/models/json_store_object.dart';
import 'package:file_store/src/persistance/file_store.dart';

class JsonFileStore<T extends JsonStoreObject> extends FileStore<T> {
  JsonFileStore({File file, T Function(Map<String, dynamic>) objectDecoder})
      : super(file: file, encode: _encode, decode: _decode<T>(objectDecoder));

  static String _encode(List<JsonStoreObject> elements) {
    return jsonEncode(elements.map((e) => e.toJson()).toList());
  }

  static List<
      T> Function(String content) _decode<T extends JsonStoreObject>(
      T Function(Map<String, dynamic>) objectJsonDecoder,) {
    return (content) {
      List json = jsonDecode(content);
      return json.map<T>((j) => objectJsonDecoder(j)).toList();
    };
  }
}
