import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';

Future<String> borrowForm({
  Borrow borrow,
  String action = '/$borrowings',
  String method = 'post',
  String title = 'New Borrowing',
}) async {
  var members = await getStore<Member>().getAllElements();
  var books = await getStore<Book>().getAllElements();

  var option = (e) => ' <option value="${e.storeId}">$e</option>';

  final membersOptions = members.map(option);
  final booksOptions = books.map(option);

  return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>$title</h3>
    </div>
    <div class="card-body">
        <form method="$method" action="$action">
            <div class="form-group">
                <label for="member-select">Member</label>
                 <select class="form-control" id="member-select" name="memberId">
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
