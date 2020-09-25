import 'package:file_store/src/models/searchable.dart';
import 'package:file_store/src/models/store_object.dart';

abstract class JsonStoreObject extends StoreObject implements Searchable {
  Map<String, dynamic> toJson();

  @override
  bool match(String query) => toJson()
      .values
      .map((e) => e.toString())
      .map((e) => query.contains(e))
      .reduce((value, element) => value || element);
}
