import 'searchable.dart';

abstract class StoreObject {
  dynamic storeId;
}

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