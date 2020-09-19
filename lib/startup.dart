import 'package:file_store/src/presentation/page_index.dart';
import 'package:file_store/src/services/service_student.dart';
import 'package:kiwi/kiwi.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:path/path.dart';
import 'src/models/student.dart';

Future<void> config(Router app) async {

  var basePath = 'files';
  var container = KiwiContainer();

  var studentService = StudentService(join(basePath, 'students.json'));
  await studentService.init();
  container.registerInstance<StudentService>(studentService);

  ///
  /// Add routes
  ///

  app.get('/', (Request req) async {
    return indexPage(req);
  });

  app.post('/students', (Request req) async{
    var body = await req.readAsString();
    var student = Student.fromUri(body);
    await studentService.add(student);
    return Response.found('/');
  });

  app.get('/students/delete/<id>', (Request req, String id) async{
    try {
      var studentId = int.tryParse(id);
      var index = studentService.elements.indexWhere((s) => s.id == studentId);
      await studentService.removeAt(index);
      return Response.found('/');
    } catch (e){
      return Response.ok(e.toString());
    }
  });
}
