import 'dart:convert';
import 'package:file_store/src/models/basic/codec.dart';
import 'basic/store_object.dart';

const borrowings = 'borrowings';

class Borrow extends JsonStoreObject {
  final String memberId;
  final String bookId;

  Borrow(this.memberId, this.bookId);

  @override
  Map<String, dynamic> toJson() => {
      'memberId': memberId,
      'bookId': bookId,
    };
}

class BorrowJsonCodec extends JsonObjectCodec<Borrow>{
  @override
  Borrow deserialize(String source) {
    final json = jsonDecode(source);
    return Borrow(json['memberId'], json['bookId']);
  }

}
