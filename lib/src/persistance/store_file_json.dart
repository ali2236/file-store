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
  Future<Iterable<T>> getAllElements() async{
    var allContents = await allFileContents();
    return allContents.map((source) => codec.deserialize(source));
  }

  @override
  Future<T> getElementById(String storeId) async{
    var file = getfile(storeId);
    if(file.existsSync()){
      return codec.deserialize(await file.readAsString());
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