abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({required this.id, required this.title, required this.price});

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading $title\n');
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() {
    return 'Audiobook: $title, Narrator: $narrator, Duration: $durationHours, Price: $price';
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return 'EBook: $title, Author: $author, Size: $fileSizeMB, Price: $price';
  }
}

class ShoppingCart {
  List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double subtotal = _items.fold(0.0, (sum, item) => sum + item.price);
    return subtotal + subtotal * taxRate;
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    for (MediaItem item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
  }
}

void main() {
  ShoppingCart cart = ShoppingCart();

  Audiobook ab1 = Audiobook(
    id: '1',
    title: 'Title 1',
    price: 100.0,
    durationHours: 1.0,
    narrator: 'Narrator 1',
  );

  Audiobook ab2 = Audiobook(
    id: '2',
    title: 'Title 2',
    price: 200.0,
    durationHours: 2.0,
    narrator: 'Narrator 2',
  );

  EBook eb1 = EBook(
    id: '3',
    title: 'Title 3',
    price: 300.0,
    fileSizeMB: 10.0,
    author: 'Author 3',
  );

  EBook eb2 = EBook(
    id: '4',
    title: 'Title 4',
    price: 400.0,
    fileSizeMB: 20.0,
    author: 'Author 4',
  );

  cart.addItem(ab1);
  cart.addItem(ab2);
  cart.addItem(eb1);
  cart.addItem(eb2);

  cart.printReceipt();

  print('Total: ${cart.calculateTotalWithTax()}');

  List<MediaItem> filtered = cart.filterByMaxPrice(350.0);
  for (MediaItem item in filtered) {
    print(item.getDetails());
  }
}