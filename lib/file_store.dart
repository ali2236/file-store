import 'dart:io' as dio;
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/views/presenters/presenter_book.dart';
import 'package:file_store/src/views/presenters/presenter_borrowing.dart';
import 'package:file_store/src/views/presenters/presenter_member.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/routes/routes_store_object.dart';
import 'src/views/pages/page_index.dart';

const _basePath = 'fileStore';

void main(List<String> args) async {
  final port = (args.length>0 ? int.tryParse(args.first) : null) ?? 3000;
  // setup routing
  final app = Router();
  setup(app);

  // start server
  var server = await io.serve(app.handler, 'localhost', port);
  print('Serving at http://${server.address.host}:${server.port}');
  print('File Store made by Ali Ghanbari');
  _launchBrowser(server);
}

void setup(Router app) async {
  final memberCodec = MemberJsonCodec();
  final bookCodec = BookJsonCodec();
  final borrowCodec = BorrowJsonCodec();

  final memberPresenter = MemberPresenter();
  final bookPresenter = BookPresenter();
  final borrowingPresenter = BorrowingPresenter();

  setupJsonStore<Member>(_basePath, members, memberCodec);
  setupJsonStore<Book>(_basePath, books, bookCodec);
  setupJsonStore<Borrow>(_basePath, borrowings, borrowCodec);

  addStoreObjectRoutes<Member>(
    app,
    members,
    getStore<Member>(),
    memberCodec,
    memberPresenter,
  );

  addStoreObjectRoutes<Book>(
    app,
    books,
    getStore<Book>(),
    bookCodec,
    bookPresenter,
  );

  addStoreObjectRoutes<Borrow>(
    app,
    borrowings,
    getStore<Borrow>(),
    borrowCodec,
    borrowingPresenter,
  );

  app.get('/', (r) {
    return indexPage(r, [
      borrowingPresenter,
      memberPresenter,
      bookPresenter,
    ]);
  });
  
  app.get('/favicon.ico', (req)=> Response.ok(<int>[]));
}

void _launchBrowser(dio.HttpServer server) => dio.Process.runSync(
      'start http://${server.address.host}:${server.port}',
      [],
      runInShell: true,
    );
