import 'package:file_store/src/models/basic/codec.dart';
import 'package:file_store/src/models/basic/searchable.dart';
import 'package:file_store/src/models/basic/store_object.dart';
import 'package:file_store/src/persistance/store.dart';
import 'package:file_store/src/views/pages/page_edit.dart';
import 'package:file_store/src/views/pages/page_exception.dart';
import 'package:file_store/src/views/pages/page.dart';
import 'package:file_store/src/views/presenters/presenter.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void addStoreObjectRoutes<T extends StoreObject>(
  Router app,
  String name,
  Store<T> store,
  ObjectCodec<T> codec,
  StoreObjectPresenter presenter,
) {
  // add
  app.post('/$name', (Request req) async {
    try {
      var body = await req.readAsString();
      var object = (codec as JsonObjectCodec).deserializeFromMap(
          Uri.splitQueryString(body)) as T;
      await store.addElement(object);
      return Response.found('/');
    } catch (e){
      return exceptionPage(req, e.toString());
    }
  });

  // replace
  app.post('/$name/<id>', (Request req, String id) async {
    var body = await req.readAsString();
    var object = (codec as JsonObjectCodec).deserializeFromMap(Uri.splitQueryString(body)) as T;
    await store.replaceElementAt(id, object);
    return Response.found('/');
  });

  // delete
  app.get('/$name/delete/<id>', (Request req, String id) async {
    try {
      await store.removeElementById(id);
      return Response.found('/');
    } catch (e) {
      return Response.ok(e.toString());
    }
  });

  // show edit page
  app.get('/$name/edit/<id>', (Request req, String id) {
    try {
      var object = store.getElementById(id);
      return editPage(object, presenter);
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
      var objects = (await store.getAllElements())
          .where((element) => (element as Searchable).match(query))
          .toList();
      return scaffold(
          body: '''<div class="my-2">${presenter.buildList(objects)}</div>''');
    } catch (e) {
      return Response.internalServerError(body: e.toString());
    }
  });
}
