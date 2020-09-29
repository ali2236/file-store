import 'package:file_store/src/models/basic/codec.dart';
import 'package:file_store/src/models/member.dart';
import 'package:file_store/src/persistance/stores.dart';
import 'basic/store_object.dart';
import 'book.dart';

const borrowings = 'borrowings';

class Borrow extends JsonStoreObject {
  final String memberId;
  final String bookId;

  Borrow(this.memberId, this.bookId);

  Member get member => getStore<Member>().getElementById(memberId);

  Book get book => getStore<Book>().getElementById(bookId);

  @override
  Map<String, dynamic> toJson() => {
      'memberId': memberId,
      'bookId': bookId,
    };

  @override
  bool match(String query) => book.match(query) || member.match(query);
}

class BorrowJsonCodec extends JsonObjectCodec<Borrow>{

  @override
  Borrow deserializeFromMap(Map<String, dynamic> json) {
    return Borrow(json['memberId'], json['bookId']);
  }

}
