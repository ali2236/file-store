import 'package:file_store/src/models/book.dart';
import 'card_book.dart';

String booksCard(List<Book> books){
  return '''
        <div class="card">
            <div class="card-title"><h3 class="m-4">All Books</h3></div>
            <div class="card-body">
                ${books.map(bookCard).join('\n')}
            </div>
        </div>
  ''';
}