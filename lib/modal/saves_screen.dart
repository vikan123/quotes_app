class Saves {
  late int id;
  late String quotes;
  late String category;
  late String author;

  Saves({
    required this.quotes,
    required this.category,
    required this.author,
  });

  factory Saves.fromMap({required Map data}) {
    return Saves(
      quotes: data['FaQuotes'],
      category: data['FaCategory'],
      author: data['FaAuthor'],
    );
  }
}