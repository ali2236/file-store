import 'json_store_object.dart';

const books = 'books';

class Book extends JsonStoreObject {
  final String title;
  final String author;

  Book(this.title, this.author);

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(json['title'], json['author']);
  }

  factory Book.fromUri(String uri) {
    var params = Uri.splitQueryString(uri);
    return Book(params['title'], params['author']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
    };
  }
}
