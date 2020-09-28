import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';

String borrowForm({Borrow borrow, String action = '/$borrowings', String method = 'post', String title = 'New Borrowing'}){
  final membersOptions = getStore<Member>().elements.map((e) => ' <option value="${e.storeId}">$e</option>');
  final booksOptions = getStore<Book>().elements.map((e) => ' <option value="${e.storeId}">$e</option>');
  return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>$title</h3>
    </div>
    <div class="card-body">
        <form method="$method" action="$action">
            <div class="form-group">
                <label for="member-select">Member</label>
                 <select class="form-control" id="member-select" name="memberId" >
                     ${membersOptions.join('\n')}
                 </select>
            </div>
            <div class="form-group">
                <label for="book-select">Book</label>
                <select class="form-control" id="book-select" name="bookId">
                     ${booksOptions.join('\n')}
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>
  ''';
}