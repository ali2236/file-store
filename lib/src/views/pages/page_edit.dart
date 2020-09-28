import 'dart:async';
import 'package:file_store/src/models/basic/store_object.dart';
import 'package:file_store/src/views/presenters/presenter.dart';
import 'package:shelf/shelf.dart';

import 'scaffold.dart';

FutureOr<Response> editPage<T extends StoreObject>(
    T model, StoreObjectPresenter<T> presenter) {
  return scaffold(
    body: '''
<div class="row my-2">
    <div class="col">${presenter.buildForm(FormType.edit, model: model)}</div>
</div>
    ''',
  );
}
