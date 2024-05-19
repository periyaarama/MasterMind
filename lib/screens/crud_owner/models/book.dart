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
    //print errors
    print('Title: ${map['title']}');
    print('Author: ${map['author']}');
    print('Description: ${map['description']}');
    print('Publisher: ${map['publisher']}');
    print('ISBN: ${map['isbn']}');
    print('Owner Email: ${map['ownerEmail']}');
    print('Image URL: ${map['imgUrl']}');
    print('Number of Pages: ${map['numberOfPages']}');
    print('Price: ${map['price']}');
    print('Genres: ${map['genres']}');

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
}
