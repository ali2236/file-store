import 'package:file_store/src/models/store_object.dart';
import 'package:file_store/src/persistance/file_store.dart';

abstract class FileService<T extends StoreObject> {
  final FileStore<T> _fileStore;
  FileService(FileStore<T> fileStore) : _fileStore = fileStore;

  List<T> get elements => List.unmodifiable(_fileStore.elements);

  Future<void> init() => _fileStore.init();

  Future<void> add(T element)=> _fileStore.addElement(element);

  Future<T> removeAt(int index) => _fileStore.removeAt(index);
}