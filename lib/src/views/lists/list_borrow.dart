import 'package:file_store/src/models/borrow.dart';
import 'package:file_store/src/views/items/card_borrow.dart';

String borrowListCard(List<Borrow> borrowList) {
  return '''
  <div class="card">
    <div class="card-title"><h3 class="m-4">All Borrowings</h3></div>
    <div class="card-body">
        ${/*searchBar('/search/$borrows')*/ ''}
        ${borrowList.map(borrowCard).join('\n')}
     </div>
</div>
  ''';
}
