import 'dart:io';
import 'package:args/args.dart';
import 'package:file_store/startup.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

const _hostname = 'localhost';

void main(List<String> args) async {
  var parser = ArgParser()..addOption('port', abbr: 'p');
  var result = parser.parse(args);


  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '2236';
  var port = int.tryParse(portStr);

  var router = Router();
  await config(router);

  var server = await io.serve(router.handler, _hostname, port);
  print('Serving at http://${server.address.host}:${server.port}');
}