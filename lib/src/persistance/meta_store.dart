import 'dart:convert';
import 'dart:io';

import 'package:file_store/src/models/store_meta.dart';
import 'package:file_store/src/persistance/file_store.dart';

///
/// stores the last index for each store
///
class MetaStore extends FileStore<StoreMeta> {

  MetaStore(File file)
      : super(
          file: file,
          encode: (Map<String, StoreMeta> map) => jsonEncode(map
              .map((key, value) => MapEntry(key, value.toJson()))),
          decode: (content) => (jsonDecode(content) as Map<String, dynamic>)
              .map((key, value) =>
                  MapEntry(key, StoreMeta.fromJson(value))),
          defaultContent: '{}',
          nextId: () => 'meta',
        );

  Future<int> getNextIndex(String storeId) async{
    var storeMetaData = getElementById(storeId);
    var nextId = storeMetaData.last_id + 1;
    await replaceElementAt(storeId, StoreMeta(nextId));
    return nextId;
  }

  @override
  StoreMeta getElementById(String storeId) {
    var result = super.getElementById(storeId);
    if(result==null){
      result = StoreMeta(0)..storeId = storeId;
      addElement(result);
    }
    return result;
  }

}
