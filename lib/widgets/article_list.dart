import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import '../models/article.dart';
import 'article_card.dart';
import '../screens/article_detail_screen.dart'; // インポートを追加
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleListWidget extends StatelessWidget {
  const ArticleListWidget({Key? key}) : super(key: key);

  // 記事データ取得
  Future<List<Article>> getArticles() async {
    try {
      // 'articles' コレクションから全ドキュメントを取得
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('articles').get();

      // 各ドキュメントのデータを Article オブジェクトに変換
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Article(
          title: data['title'],
          description: data['description'],
          imagePath: List<String>.from(data['imagePath']),
          author: data['author'],
          // Firestore の Timestamp を DateTime に変換
          date: (data['date'] as Timestamp).toDate(),
          tags: List<String>.from(data['tags']),
          markdownPath: data['markdownPath'],
        );
      }).toList();
    } catch (e) {
      print('Error loading articles from Firestore: $e');
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
