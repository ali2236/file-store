import 'dart:async';
import 'package:file_store/src/models/searchable.dart';
import 'package:file_store/src/models/store_object.dart';
import 'package:file_store/src/persistance/file_store.dart';
import 'file:///C:/Users/Aligator/projects/file_store/lib/src/views/pages/scaffold.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void addStoreObjectRoutes<T extends StoreObject>(
  Router app,
  String name,
  FileStore<T> store,
  T Function(String uri) uriParser,
  FutureOr<Response> Function(T object) editPageBuilder,
  String Function(List<T> object) objectListBuilder,
) {
  // add
  app.post('/$name', (Request req) async {
    var body = await req.readAsString();
    var object = uriParser(body);
    await store.addElement(object);
    return Response.found('/');
  });

  // replace
  app.post('/$name/<id>', (Request req, String id) async {
    var body = await req.readAsString();
    var object = uriParser(body);
    await store.replaceElementAt(id, object);
    return Response.found('/');
  });

  // delete
  app.get('/$name/delete/<id>', (Request req, String id) async {
    try {
      await store.removeAt(id);
      return Response.found('/');
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  // show edit page
  app.get('/$name/edit/<id>', (Request req, String id) async {
    try {
      var object = store.getElementById(id);
      return editPageBuilder(object);
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  //search
  app.post('/search/$name', (Request req) async {
    try {
      var body = await req.readAsString();
      var params = Uri.splitQueryString(body);
      var query = params['search'];
      var objects = store.elements
          .where((element) => (element as Searchable).match(query))
          .toList();
      return scaffold(body: '''<div class="my-2">${objectListBuilder(objects)}</div>''');
    } catch (e) {
      return Response.internalServerError(body: e.toString());
    }
  });
}
