import 'dart:io';
import 'package:file_store/src/models/store_object.dart';

abstract class FileStore<T extends StoreObject> {

  final File file;

  FileStore(this.file) {
    if(!file.existsSync()){
      file.createSync(recursive: true);
      file.writeAsStringSync('[]');
    }
  }

  Future<void> init() async{
    _elements = await readFile();
  }

  List<T> _elements;

  List<T> get elements => _elements;

  Future<List<T>> readFile();

  Future<void> writeFile();

  Future<void> addElement(T element) async{
    _elements.add(element);
    await writeFile();
  }

  Future<T> removeAt(int index) async{
    var e = _elements.removeAt(index);
    await writeFile();
    return e;
  }
}