import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/views/presenters/presenter.dart';

class BookPresenter extends StoreObjectPresenter<Book> {
  BookPresenter() : super(books,'Book');

  @override
  String buildForm(FormType type, {Book model}) {
    final isEdit = type==FormType.edit;
    return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>${isEdit ? 'Edit ${modelName}' : 'Add a new ${modelName}'}</h3>
    </div>
    <div class="card-body">
        <form method="post" action="${isEdit ? '/$baseUrl/edit' : '/$baseUrl'}">
            <div class="form-group">
                <label for="bk-tl"> ${modelName} Title</label>
                <input id="bk-tl" class="form-control" name="title" type="text" placeholder="Title" value="${model?.title ?? ''}">
            </div>
            <div class="form-group">
                <label for="bk-ath"> ${modelName} Author</label>
                <input id="bk-ath" type="text" class="form-control" name="author" placeholder="Author" value="${model?.author ?? ''}">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
  }

  @override
  String buildItem(Book model) {

  }

  @override
  String buildList(List<Book> models) {

  }

}