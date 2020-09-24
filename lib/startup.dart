import 'package:file_store/src/persistance/store_student.dart';
import 'package:shelf_router/shelf_router.dart';
import 'src/routes/routes_student.dart';
import 'src/views/page_index.dart';

const _basePath = 'files';

Future<void> config(Router app) async {
  await setupStudentStore(_basePath);
  app.get('/', indexPage);
  addStudentRoutes(app, studentStore);
}

