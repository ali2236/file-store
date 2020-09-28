import 'dart:async';
import 'package:file_store/src/views/pages/scaffold.dart';
import 'package:file_store/src/views/presenters/presenter.dart';
import 'package:shelf/shelf.dart';

final _responsiveSizing = 'col-lg-4 col-sm-12';

FutureOr<Response> indexPage(
    Request request, List<StoreObjectPresenter> presenters) async {
  return scaffold(
    body: '''
    <div class="row my-2">
    ${presenters.map((e) => '<div class="$_responsiveSizing">${e.buildForm(FormType.create)}</div>').join('\n')}
</div>
<div class="row">
    ${presenters.map((e) => '<div class="$_responsiveSizing"> ${e.buildList(e.store.getAllElements())}</div>').join('\n')}
</div>
      ''',
  );
}
