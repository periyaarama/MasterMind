import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String documentId;
  final String title;
  final String author;
  final String description;
  final String isbn;
  final String publisher;
  final double price;
  final int numberOfPages;
  final List<String> genres;
  final String? pdfUrl;
  final String? ownerEmail;
  final String? imgUrl;

  Book({
    required this.documentId,
    required this.title,
    required this.author,
    required this.isbn,
    required this.publisher,
    required this.genres,
    required this.description,
    required this.numberOfPages,
    required this.price,
    required this.ownerEmail,
    required this.imgUrl,
    required this.pdfUrl,
  });

  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      documentId: documentId,
      title: map['title'],
      author: map['author'],
      isbn: map['isbn'],
      publisher: map['publisher'],
      genres: List<String>.from(map['genres']),
      description: map['description'],
      numberOfPages: map['numberOfPages'],
      price: map['price'],
      ownerEmail: map['ownerEmail'] as String?,
      imgUrl: map['imgUrl'] as String?,
      pdfUrl: map['pdfUrl'] as String?,
    );
  }

  factory Book.fromSnapshot(DocumentSnapshot<Object?> snapshot) {
    final map = snapshot.data() as Map<String, dynamic>;
    return Book.fromMap(map, snapshot.id);
  }
}
