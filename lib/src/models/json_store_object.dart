import 'package:file_store/src/models/store_object.dart';

abstract class JsonStoreObject extends StoreObject{
  Map<String, dynamic> toJson();
}