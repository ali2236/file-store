import 'package:file_store/src/models/json_store_object.dart';

class StoreMeta extends JsonStoreObject {
  final int last_id;

  StoreMeta(this.last_id);

  factory StoreMeta.fromJson(Map<String, dynamic> json) {
    return StoreMeta(json['last_id']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'last_id': last_id,
    };
  }
}
