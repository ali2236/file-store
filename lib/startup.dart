import 'dart:io';
import 'package:file_store/src/views/page_edit_student.dart';
import 'package:file_store/src/views/scaffold.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shelf/shelf.dart';
import 'package:path/path.dart';
import 'src/models/student.dart';
import 'package:shelf_router/shelf_router.dart';
import 'src/persistance/json_file_store.dart';
import 'src/views/page_index.dart';

Future<void> config(Router app) async {
  var basePath = 'files';
  var container = KiwiContainer();

  var getFile = (String name) => File(join(basePath, '$name.json'));

  var studentFile = JsonFileStore<Student>(
      file: getFile('students'),
      objectDecoder: (json) => Student.fromJson(json),
  );
  await studentFile.init();
  container.registerInstance<JsonFileStore<Student>>(studentFile);

  ///
  /// Add routes
  ///

  app.get('/', (Request req) async {
    return indexPage(req);
  });

  app.post('/students', (Request req) async {
    var body = await req.readAsString();
    var student = Student.fromUri(body);
    await studentFile.addElement(student);
    return Response.found('/');
  });

  app.post('/students/<index>', (Request req, String index) async {
    var studentIndex = int.tryParse(index);
    var body = await req.readAsString();
    var student = Student.fromUri(body);
    await studentFile.replaceElementAt(studentIndex, student);
    return Response.found('/');
  });

  app.delete('/students/<index>', (Request req, String index) async {
    try {
      var studentIndex = int.tryParse(index);
      await studentFile.removeAt(studentIndex);
      return Response.found('/');
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  app.get('/students/delete/<index>', (Request req, String index) async {
    try {
      var studentIndex = int.tryParse(index);
      await studentFile.removeAt(studentIndex);
      return Response.found('/');
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  app.get('/students/edit/<index>', (Request req, String index) async{
    try {
      var studentIndex = int.tryParse(index);
      var student = studentFile.elements[studentIndex];
      return studentEditPage(student);
    } catch (e) {
      return Response.ok(e.toString());
    }
  });
}
