import 'package:file_store/src/models/store_object.dart';

class Book extends StoreObject {
  final int id;
  final String title;
  final String author;

  Book(this.id, this.title, this.author);

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(json['id'], json['title'], json['author']);
  }

  factory Book.fromUri(String uri){
    var params = Uri.splitQueryString(uri);
    return Book(int.tryParse(params['id']), params['title'], params['author']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
    };
  }
}
