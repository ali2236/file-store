import 'json_store_object.dart';

const books = 'books';

class Book extends JsonStoreObject {
  final String title;
  final String author;

  Book(this.title, this.author) {
      if(title.isEmpty) throw 'The title field can not be empty';
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(json['title'], json['author']);
  }

  factory Book.fromUri(String uri) {
    var params = Uri.splitQueryString(uri);
    return Book.fromJson(params);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
    };
  }

  @override
  String toString() {
    return '$title';
  }
}
