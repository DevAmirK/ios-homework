class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });
}

class Library {
  List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  List<Book> getAvailableBooks() {
    return _books.where((book) => book.isBorrowed == false).toList();
  }

  double getTotalValue() {
    return _books.fold(0.0, (sum, book) => sum + book.price);
  }
}

void main() {
  Library library = Library();

  library.addBook(Book(title: 'Title 1', author: 'Author 1', price: 100.0));
  library.addBook(Book(title: 'Title 2', author: 'Author 2', price: 200.0));
  library.addBook(Book(title: 'Title 3', author: 'Author 3', price: 300.0, isBorrowed: true));
  library.addBook(Book(title: 'Title 4', author: 'Author 4', price: 400.0));

  print('Available Books');
  List<Book> available = library.getAvailableBooks();
  for (Book book in available) {
    print('- ${book.title} by ${book.author}. Price: ${book.price}');
  }

  print('Total Collection Value: ${library.getTotalValue()}');
}