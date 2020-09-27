import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_store/src/models/json_store_object.dart';
import 'package:file_store/src/persistance/file_store.dart';
import 'package:file_store/src/persistance/meta_store.dart';


class JsonFileStore<T extends JsonStoreObject> extends FileStore<T> {
  JsonFileStore({File file, T Function(Map<String, dynamic>) objectDecoder, String storeId, MetaStore metaStore})
      : super(file: file, encode: _encode, decode: _decode<T>(objectDecoder),
    defaultContent: '{}', nextId: _nextId(metaStore, storeId),
  );

  static String _encode(Map<String,JsonStoreObject> elements) {
    return jsonEncode(elements.map((k,v) => MapEntry(k, v.toJson())));
  }

  static Map<String,T> Function(String content) _decode<T extends JsonStoreObject>(
      T Function(Map<String, dynamic>) objectJsonDecoder,) {
    return (content) {
      Map<String, dynamic> json = jsonDecode(content);
      return json.map((k,v) => MapEntry(k, objectJsonDecoder(v)));
    };
  }

  static FutureOr Function() _nextId(MetaStore metaStore, String storeId){
    return () => metaStore.getNextIndex(storeId);
  }
}
