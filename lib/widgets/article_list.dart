import 'package:flutter/material.dart';
import '../models/article.dart';
import 'article_card.dart';
import '../screens/article_detail_screen.dart'; // インポートを追加

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  // ダミー記事データ
  List<Article> getDummyArticles() {
    return [
      Article(
        title: 'Flutterでのレスポンシブデザインの実装方法',
        description: 'Flutterを使ったレスポンシブデザインの基本的な実装方法について解説します。',
        imagePath: 'assets/images/thumbnail_1.png', // ローカルパス
        author: 'John Doe',
        date: DateTime(2023, 10, 1),
        tags: ['Flutter', 'Responsive', 'Design'],
        markdownPath: 'assets/markdown/article1.md', // Markdownファイルのパス
      ),
      Article(
        title: 'Dartの非同期処理: FutureとStreamの使い分け',
        description: 'Dartでの非同期処理の基本であるFutureとStreamの違いと適切な使い分け方法を紹介します。',
        imagePath: 'assets/images/thumbnail_1.png', // ローカルパス
        author: 'Jane Smith',
        date: DateTime(2023, 9, 15),
        tags: ['Dart', 'Asynchronous', 'Programming'],
        markdownPath: 'assets/markdown/article1.md', // Markdownファイルのパス
      ),
      // さらに記事を追加...
    ];
  }

  @override
  Widget build(BuildContext context) {
    final articles = getDummyArticles();

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleCard(
          article: articles[index],
          onTap: () {
            // 記事詳細ページへ遷移する処理を実装
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailScreen(
                  article: articles[index],
                  allArticles: articles, // 全記事リストを渡す
                ),
              ),
            );
          },
        );
      },
    );
  }
}
