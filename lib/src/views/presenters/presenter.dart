import 'package:file_store/src/models/basic/store_object.dart';

abstract class StoreObjectPresenter<T extends StoreObject> {
  final String baseUrl;
  final String modelName;

  StoreObjectPresenter(this.baseUrl, this.modelName);

  String buildForm(FormType type, {T model});

  String buildItem(T model);

  String buildList(List<T> models);
}

enum FormType { create, edit }
