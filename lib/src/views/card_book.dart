import 'package:file_store/src/models/book.dart';

String bookCard(Book book) {
  return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${book.title}</h4>
    <p>${book.author}</p>
    <div>
    <a class="btn btn-secondary" type="button" href="/$books/edit/${book.index}">Edit</a>
    <a class="btn btn-danger" type="button" href="/$books/delete/${book.index}">Delete</a>
    </div>
  </div>
  ''';
}
