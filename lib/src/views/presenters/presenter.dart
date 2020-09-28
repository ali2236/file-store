import 'package:file_store/src/models/basic/store_object.dart';
import 'package:file_store/src/persistance/store_file.dart';
import 'package:file_store/src/persistance/stores.dart';

abstract class StoreObjectPresenter<T extends StoreObject> {
  final String baseUrl;
  final String modelName;

  StoreObjectPresenter(this.baseUrl, this.modelName);

  String buildForm(FormType type, {T model});

  String buildItem(T model);

  String buildList(List<T> models);

  // workaround
  FileStore get store => getStore<T>();
}

enum FormType { create, edit }
