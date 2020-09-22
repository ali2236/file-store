import 'dart:io';
import 'package:file_store/src/models/store_object.dart';

class FileStore<T extends StoreObject> {
  final File file;
  final List<T> Function(String source) decode;
  final String Function(List<T> elements) encode;

  FileStore({this.file, this.decode, this.encode})
      : assert(file != null),
        assert(decode != null),
        assert(encode != null) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync('[]');
    }
  }

  Future<void> init() async {
    _elements = await _readFile();
  }

  List<T> _elements;

  List<T> get elements => _elements;

  Future<List<T>> _readFile() async{
    var contents = await file.readAsString();
    List<StoreObject> elements = decode(contents);
    for(var i=0;i<elements.length;i++){
      elements[i].index = i;
    }
    return elements;
  }

  Future<void> _writeFile() async{
    var contents = encode(_elements);
    await file.writeAsString(contents);
  }

  Future<void> addElement(T element) async {
    _elements.add(element);
    await _writeFile();
  }

  Future<T> removeAt(int index) async {
    var e = _elements.removeAt(index);
    await _writeFile();
    return e;
  }
}
