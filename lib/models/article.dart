import 'package:http/http.dart' as http;

class Article {
  final String id;
  final String title;
  final String description;
  final List<String> imagePath;
  final String author;
  final DateTime date;
  final List<String> tags;
  final String markdownPath;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.author,
    required this.date,
    required this.tags,
    required this.markdownPath,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    String description = json['content'] as String;
    if (description.length > 100) {
      description = description.substring(0, 100) + '...';
    }

    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      description: description,
      imagePath: List<String>.from(json['imageUrls']),
      author: 'Admin',
      date: DateTime.parse(json['date']),
      tags: List<String>.from(json['tags']),
      markdownPath: json['markdownFileName'],
    );
  }
}
