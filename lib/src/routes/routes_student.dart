import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/persistance/file_store.dart';
import 'package:file_store/src/views/page_edit_student.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void addStudentRoutes(Router app, FileStore studentFile){
  // add
  app.post('/students', (Request req) async {
    var body = await req.readAsString();
    var student = Student.fromUri(body);
    await studentFile.addElement(student);
    return Response.found('/');
  });

  // replace
  app.post('/students/<index>', (Request req, String index) async {
    var studentIndex = int.tryParse(index);
    var body = await req.readAsString();
    var student = Student.fromUri(body);
    await studentFile.replaceElementAt(studentIndex, student);
    return Response.found('/');
  });

  // delete
  app.get('/students/delete/<index>', (Request req, String index) async {
    try {
      var studentIndex = int.tryParse(index);
      await studentFile.removeAt(studentIndex);
      return Response.found('/');
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  // show edit page
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
