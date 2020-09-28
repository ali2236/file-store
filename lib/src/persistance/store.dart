import 'package:file_store/src/models/basic/store_object.dart';

abstract class Store<T extends StoreObject>{

  List<T> getAllElements();

  Future<void> addElement(T element);

  Future<void> removeElementById(String storeId);

  Future<void> replaceElementAt(String storeId, T element);

  T getElementById(String storeId);
}