import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      final response =
          await http.get(Uri.parse('http://localhost:8080/api/articles'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Article.fromJson(json)).toList();
      } else {
        print('Error fetching articles: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error loading articles from API: $e');
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
