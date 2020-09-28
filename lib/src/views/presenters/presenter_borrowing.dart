import 'package:file_store/src/models/book.dart';
import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'package:file_store/src/views/presenters/presenter.dart';

class BorrowingPresenter extends StoreObjectPresenter<Borrow> {
  BorrowingPresenter() : super(borrowings, 'Borrowing');

  @override
  String buildForm(FormType type, {Borrow model}) {
    var isEdit = type == FormType.edit;

    var members = getStore<Member>().getAllElements();
    var books = getStore<Book>().getAllElements();

    var option = (e) => ' <option value="${e.storeId}">$e</option>';

    final membersOptions = members.map(option);
    final booksOptions = books.map(option);

    return '''<div class="card p-2">
    <div class="card-title text-center">
        <h3>${isEdit ? 'Edit this ${modelName}' : 'New ${modelName}'}</h3>
    </div>
    <div class="card-body">
        <form method="post" action="${isEdit ? '/$baseUrl/${model.storeId}' : '/$baseUrl'}">
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

  @override
  String buildItem(Borrow model) {
    var member = getStore<Member>().getElementById(model.memberId);
    var book = getStore<Book>().getElementById(model.bookId);
    return '''
  <div class="card card-body my-2">
    <h4 class="pb-2">${book != null ? book.toString() : '*deleted book*'}</h4>
    <p>${member != null ? member.toString() : '*deleted member*'}</p>
    <div>
    <!--<a class="btn btn-secondary" type="button" href="/$borrowings/edit/${model.storeId}">Edit</a>-->
    <a class="btn btn-danger" type="button" href="/$borrowings/delete/${model.storeId}">Delete</a>
    </div>
  </div>
  ''';
  }

  @override
  String buildList(List<Borrow> models) {
    return '''
  <div class="card">
    <div class="card-title"><h3 class="m-4">All Borrowings</h3></div>
    <div class="card-body">
        ${/*searchBar('/search/$borrows')*/ ''}
        ${models.map(buildItem).join('\n')}
     </div>
</div>
  ''';
  }

}