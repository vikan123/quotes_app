class ApiModal {
  final String text;
  final String author;
  final String category;

  ApiModal(
      this.text,
      this.author,
      this.category,
      );

  factory ApiModal.fromApi({required Map data}) {
    return ApiModal(
      data['text']??'',
      data['author']??'',
      data['category']??'',
    );
  }
}