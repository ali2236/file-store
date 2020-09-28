import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';

String borrowCard(Borrow borrow) {
  var member = getStore<Member>().getElementById(borrow.memberId);
  var book = getStore<Book>().getElementById(borrow.bookId);
  return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${book != null ? book.toString() : '*deleted book*'}</h4>
    <p>${member != null ? member.toString() : '*deleted member*'}</p>
    <div>
    <a class="btn btn-secondary" type="button" href="/$borrowings/edit/${borrow.storeId}">Edit</a>
    <a class="btn btn-danger" type="button" href="/$borrowings/delete/${borrow.storeId}">Delete</a>
    </div>
  </div>
  ''';
}
