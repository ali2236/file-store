import 'dart:async';
import 'dart:io';
import 'package:file_store/src/models/store_meta.dart';
import 'package:file_store/src/models/store_object.dart';

class FileStore<T extends StoreObject> {
  final File _file;
  final Map<String, T> Function(String source) decode;
  final String Function(Map<String, T> elements) encode;
  final FutureOr Function() _nextId;
  final String defaultContent;

  FileStore({
    File file,
    this.decode,
    this.encode,
    this.defaultContent,
    FutureOr Function() nextId,
  })  : _file = file,
        _nextId = nextId,
        assert(file != null),
        assert(decode != null),
        assert(encode != null),
        assert(nextId != null),
        assert(defaultContent != null) {
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(defaultContent);
    }
  }

  Future<void> init() async {
    _elements = await _readFile();
  }

  Map<String, T> _elements;

  List<T> get elements => _elements.values.toList();

  Future<Map<String, T>> _readFile() async {
    var contents = await _file.readAsString();
    Map<String, StoreObject> elements = decode(contents);
    elements.forEach((key, value) => value.storeId = int.tryParse(key));
    return elements;
  }

  Future<void> _writeFile() async {
    var contents = encode(_elements);
    await _file.writeAsString(contents);
  }

  Future<void> addElement(T element) async {
    element.storeId = await Future.sync(_nextId);
    _elements[element.storeId.toString()] = element;
    await _writeFile();
  }

  Future<T> removeAt(String storeId) async {
    var e = _elements.remove(storeId);
    await _writeFile();
    return e;
  }

  Future<void> replaceElementAt(String storeId, T element) async {
    element.storeId = int.tryParse(storeId);
    _elements[storeId] = element;
    await _writeFile();
  }

  T getElementById(String storeId){
    return _elements[storeId];
  }
}
