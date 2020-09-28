import 'dart:convert';

import 'package:file_store/src/models/basic/store_object.dart';

abstract class ObjectCodec<T extends StoreObject>{
  String serialize(T object);
  T deserialize(String source);
}

abstract class JsonObjectCodec<T extends JsonStoreObject> extends ObjectCodec<T>{
  @override
  String serialize(T object) => jsonEncode(object.toJson());
}