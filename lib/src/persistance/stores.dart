import 'dart:io';
import 'package:file_store/src/models/json_store_object.dart';
import 'package:file_store/src/models/store_object.dart';
import 'package:path/path.dart';
import 'file_store.dart';
import 'json_file_store.dart';

Map<Type, FileStore> _stores = {};

void addStore<T extends StoreObject>(FileStore<T> store) => _stores[T] = store;

FileStore<T> getStore<T extends StoreObject>() => _stores[T];

Future<void> setupJsonStore<T extends JsonStoreObject>(
  String basePath,
  String fileName,
  T Function(Map<String, dynamic>) objectDecoder,
) async {
  if (getStore<T>() != null) return;
  var getFile = (String name) => File(join(basePath, '$name.json'));
  var store = JsonFileStore<T>(
    file: getFile(fileName),
    objectDecoder: objectDecoder,
  );
  await store.init();
  addStore<T>(store);
}