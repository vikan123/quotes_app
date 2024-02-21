class QuotesModals {
  late int id;
  late String text;
  late String category;
  late String author;

  QuotesModals(
      this.text,
      this.category,
      this.author,
      );

  factory QuotesModals.fromMap({required Map data}) {
    return QuotesModals(
      data['text']??'',
      data['Category']??'',
      data['Author']??'',
    );
  }
}