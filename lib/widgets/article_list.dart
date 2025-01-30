import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/article.dart';
import 'article_card.dart';
import '../screens/article_detail_screen.dart'; // インポートを追加

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  // 記事データ取得
  Future<List<Article>> getArticles() async {
    try {
      // JSONファイルを読み込む
      final String jsonString =
          await rootBundle.loadString('assets/articles.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      // JSONデータをArticleオブジェクトのリストに変換
      return jsonList
          .map((json) => Article(
                title: json['title'],
                description: json['description'],
                imagePath: json['imagePath'],
                author: json['author'],
                date: DateTime.parse(json['date']),
                tags: List<String>.from(json['tags']),
                markdownPath: json['markdownPath'],
              ))
          .toList();
    } catch (e) {
      print('Error loading articles: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
      future: getArticles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final articles = snapshot.data ?? [];
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
      },
    );
  }
}
