import 'package:file_store/src/models/basic/codec.dart';
import 'package:file_store/src/models/basic/store_object.dart';
import 'package:file_store/src/persistance/store_file.dart';

class JsonFileStore<T extends JsonStoreObject> extends FileStore<T>{

  final JsonObjectCodec<T> codec;

  JsonFileStore(String name, String basePath,this.codec) : super(basePath, name);

  @override
  Future<void> addElement(T element) async{
     await addFile(codec.serialize(element));
  }

  @override
  List<T> getAllElements(){
    var allContents = allFileContents();
    var elements = List<T>(allContents.length);
    int i = 0;
    allContents.forEach((id, source) {
      var model = codec.deserialize(source);
      model.storeId = id;
      elements[i++] = model;
    });
    return elements;
  }

  @override
  T getElementById(String storeId) {
    var file = getfile(storeId);
    if(file.existsSync()){
      return codec.deserialize(file.readAsStringSync())..storeId = storeId;
    } else {
      return null;
    }
  }

  @override
  Future<void> removeElementById(String storeId) async{
    var file = getfile(storeId);
    if(file.existsSync()){
      file.deleteSync();
    }
  }

  @override
  Future<void> replaceElementAt(String storeId, T element) async{
    var file = getfile(storeId);
    if(file.existsSync()){
      var contents = codec.serialize(element);
      await file.writeAsString(contents);
    } else {
      throw "element #$storeId can not be replaced because it doesn't exist!";
    }
  }

}