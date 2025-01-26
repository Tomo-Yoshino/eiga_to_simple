import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import '../models/article.dart';
import '../widgets/blog_title.dart';
import '../widgets/profile_section.dart';

class ArticleDetailScreen extends StatefulWidget {
  final Article article;
  final List<Article> allArticles; // 他記事へのリンク用に全記事リストを受け取る

  const ArticleDetailScreen({
    Key? key,
    required this.article,
    required this.allArticles,
  }) : super(key: key);

  @override
  _ArticleDetailScreenState createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  String markdownData = '';

  @override
  void initState() {
    super.initState();
    loadMarkdown();
  }

  // Markdownファイルを読み込む
  Future<void> loadMarkdown() async {
    try {
      final data = await rootBundle.loadString(widget.article.markdownPath);
      setState(() {
        markdownData = data;
      });
    } catch (e) {
      setState(() {
        markdownData = '# エラー\nMarkdownファイルの読み込みに失敗しました。';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 上部ヘッダーに戻るボタンを表示
            BlogTitleWidget(
              showBackButton: true,
              onBackButtonPressed: () {
                Navigator.pop(context);
              },
            ),

            // メインコンテンツ
            Expanded(
              child: isSmallScreen
                  ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 左側: 記事本体
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: markdownData.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : MarkdownBody(
                                    data: markdownData,
                                    styleSheet: MarkdownStyleSheet.fromTheme(
                                            Theme.of(context))
                                        .copyWith(
                                      h1: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      h2: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      p: Theme.of(context).textTheme.bodyMedium,
                                      code: const TextStyle(
                                        backgroundColor: Colors.grey,
                                        fontFamily: 'Courier',
                                      ),
                                      a: TextStyle(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    imageBuilder: (uri, title, alt) {
                                      return Image.asset(
                                        uri.path,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                          ),

                          // 右側: プロフィール
                          const ProfileSectionWidget(),

                          // 他記事へのリンク
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildOtherArticles(context),
                          ),
                        ],
                      ),
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 左側: 記事本体 (3/4)
                        Expanded(
                          flex: 3,
                          child: markdownData.isEmpty
                              ? const Center(child: CircularProgressIndicator())
                              : SingleChildScrollView(
                                  padding: const EdgeInsets.all(16.0),
                                  child: MarkdownBody(
                                    data: markdownData,
                                    styleSheet: MarkdownStyleSheet.fromTheme(
                                            Theme.of(context))
                                        .copyWith(
                                      h1: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      h2: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                      p: Theme.of(context).textTheme.bodyMedium,
                                      code: const TextStyle(
                                        backgroundColor: Colors.grey,
                                        fontFamily: 'Courier',
                                      ),
                                      a: TextStyle(
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    imageBuilder: (uri, title, alt) {
                                      return Image.asset(
                                        uri.path,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                        ),

                        // 右側: プロフィールと他記事へのリンク (1/4)
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const ProfileSectionWidget(),
                                const SizedBox(height: 16),
                                _buildOtherArticles(context),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // 他記事へのリンクを作成するメソッド
  Widget _buildOtherArticles(BuildContext context) {
    // 現在の記事以外のリストを取得
    final otherArticles = widget.allArticles
        .where((a) => a.title != widget.article.title)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '他の記事',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...otherArticles.map((article) {
          return ListTile(
            title: Text(
              article.title,
              style: const TextStyle(
                color: Colors.blueAccent,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(
                    article: article,
                    allArticles: widget.allArticles,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ],
    );
  }
}
