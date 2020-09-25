import 'package:file_store/src/models/student.dart';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/routes/routes_store_object.dart';
import 'package:file_store/src/views/card_books.dart';
import 'package:file_store/src/views/card_students.dart';
import 'package:file_store/src/views/page_edit_book.dart';
import 'package:file_store/src/views/page_edit_student.dart';
import 'package:shelf_router/shelf_router.dart';
import 'src/views/page_index.dart';

const _basePath = 'files';

Future<void> config(Router app) async {
  ///
  /// setup stores
  ///
  await setupJsonStore<Student>(
      _basePath, students, (j) => Student.fromJson(j));
  await setupJsonStore<Book>(_basePath, books, (j) => Book.fromJson(j));

  ///
  /// add store interaction APIs
  ///
  addStoreObjectRoutes<Student>(app, students, getStore<Student>(),
      (uri) => Student.fromUri(uri), studentEditPage, studentsCard);

  addStoreObjectRoutes<Book>(app, books, getStore<Book>(),
      (uri) => Book.fromUri(uri), bookEditPage, booksCard);

  ///
  /// add index page
  ///
  app.get('/', indexPage);
}
