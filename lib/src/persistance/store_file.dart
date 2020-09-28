 import 'dart:io';
import 'store.dart';
import 'package:file_store/src/models/basic/store_object.dart';
import 'package:path/path.dart' as path;

abstract class FileStore<T extends StoreObject> extends Store<T> {
  final String basePath;
  final String name;

  FileStore(String basePath, this.name) : basePath = path.join(basePath, name);

  File getfile(String name) {
    return File(path.join(basePath, name));
  }

  Future<int> _getNextId() async {
    var file = getfile(name);
    if (!file.existsSync()) {
      await file.create(recursive: true);
      await file.writeAsString("0");
    }
    int lastId = int.tryParse(await file.readAsString());
    int nextId = lastId + 1;
    await file.writeAsString(nextId.toString());
    return nextId;
  }

  Future<void> addFile(String contents) async {
    var id = await _getNextId();
    var file = getfile(id.toString());
    await file.create(recursive: true);
    await file.writeAsString(contents);
  }

  Map<String,String> allFileContents(){
    var directory = Directory(basePath);
    if(!directory.existsSync()) directory.createSync(recursive: true);
    var files = directory.listSync();
    var contents = <String, String>{};
    var skippedMeta = false;
    for(int i=0;i<files.length;i++){
      var file = files[i];
      var fileName = path.basename(file.path);
      if(!skippedMeta && fileName == name){
        skippedMeta = true;
      } else {
        var f = File(file.path);
        var content = f.readAsStringSync();
        contents[fileName] = content;
      }
    }
    return contents;
  }
}
