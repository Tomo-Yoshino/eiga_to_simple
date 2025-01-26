class Article {
  final String title;
  final String description;
  final String imagePath; // ローカル画像のパス
  final String author;
  final DateTime date;
  final List<String> tags;
  final String markdownPath; // Markdownファイルのパス

  Article({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.author,
    required this.date,
    required this.tags,
    required this.markdownPath, // 新規追加
  });
}
