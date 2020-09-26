import 'package:file_store/src/models/searchable.dart';
import 'package:file_store/src/models/store_object.dart';

abstract class JsonStoreObject extends StoreObject implements Searchable {
  Map<String, dynamic> toJson();

  @override
  bool match(String query) {
    var q = query.toLowerCase();
    return toJson()
      .values
      .map((e) => e.toString().toLowerCase())
      .map((e) => e.contains(q))
      .reduce((value, element) => value || element);
  }
}
