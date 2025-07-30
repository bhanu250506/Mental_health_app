

class Quote {
  final String id;
  final String text;
  final String author;

  Quote({
    required this.id,
    required this.text,
    required this.author
});

  factory Quote.fromJson(Map<String, dynamic> json){
    return Quote(
        id: json['_id'],
        text: json['text'],
        author: json['author']
    );
  }

}