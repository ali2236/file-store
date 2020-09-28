
import 'package:file_store/src/models/json_store_object.dart';

const borrowings = 'borrowings';

class Borrow extends JsonStoreObject{
  final String memberId;
  final String bookId;

  Borrow(this.memberId, this.bookId);

  factory Borrow.fromJson(Map<String, dynamic> json){
    return Borrow(json['memberId'], json['bookId']);
  }

  factory Borrow.fromUri(String uri){
    final params = Uri.splitQueryString(uri);
    return Borrow.fromJson(params);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'memberId' : memberId,
      'bookId' : bookId,
    };
  }
}