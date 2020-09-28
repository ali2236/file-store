import 'package:file_store/src/models/book.dart';

String bookForm(
    {Book book,
    String action = '/$books',
    String method = 'post',
    String title = 'New Book'}) {
  return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>$title</h3>
    </div>
    <div class="card-body">
        <form method="$method" action="$action">
            <div class="form-group">
                <label for="bk-tl">Book Title</label>
                <input id="bk-tl" class="form-control" name="title" type="text" placeholder="Title" value="${book?.title ?? ''}">
            </div>
            <div class="form-group">
                <label for="bk-ath">Book Author</label>
                <input id="bk-ath" type="text" class="form-control" name="author" placeholder="Author" value="${book?.author ?? ''}">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
}
