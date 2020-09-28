import 'package:file_store/src/models/basic/codec.dart';
import 'package:file_store/src/models/basic/store_object.dart';
import 'store_file.dart';
import 'store_file_json.dart';

Map<Type, FileStore> _stores = {};

void addStore<T extends StoreObject>(FileStore<T> store) => _stores[T] = store;

FileStore<T> getStore<T extends StoreObject>() => _stores[T];

void setupJsonStore<T extends JsonStoreObject>(
    String basePath, String name, JsonObjectCodec codec) {
  if (getStore<T>() != null) return;
  var store = JsonFileStore<T>(name, basePath, codec);
  addStore<T>(store);
}
