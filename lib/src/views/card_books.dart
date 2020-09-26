import 'package:file_store/src/models/book.dart';
import 'card_book.dart';
import 'element_search_bar.dart';

String booksCard(List<Book> bookList){
  return '''
        <div class="card">
            <div class="card-title"><h3 class="m-4">All Books</h3></div>
            <div class="card-body">
                ${searchBar('/search/$books')}
                ${bookList.map(bookCard).join('\n')}
            </div>
        </div>
  ''';
}