import 'package:flutter/material.dart';

// 各要素のWidgetをインポート
import '../widgets/blog_title.dart';
import '../widgets/article_list.dart';
import '../widgets/profile_section.dart';
import '../widgets/search_section.dart';
import '../widgets/tag_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  @override
  Widget build(BuildContext context) {
    bool smallScreen = isSmallScreen(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 上部: ブログタイトル
            const BlogTitleWidget(
              title: '映画と、シンプルな日々', // 新しいタイトルを渡す
            ),

            // 残りスペースにRowを入れて、左に記事一覧、右にプロフィール・検索・タグなどを配置
            Expanded(
              child: smallScreen
                  ? SingleChildScrollView(
                      // const を削除
                      padding: EdgeInsets.zero, // 不要なパディングがないように設定
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ArticleListWidget(),
                          const ProfileSectionWidget(),
                          const SearchSectionWidget(),
                          const TagSectionWidget(),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        // 左側：記事一覧
                        const Expanded(
                          flex: 3,
                          child: ArticleListWidget(),
                        ),
                        // 右側：プロフィール・検索・タグ
                        Expanded(
                          flex: 1,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.zero, // 不要なパディングがあれば調整
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    // 親(Expanded)が与える高さ(constraints.maxHeight)以上になる
                                    // => 最低でも左側と同じだけの高さを確保
                                    minHeight: constraints.maxHeight,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start, // 上寄せ
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      ProfileSectionWidget(),
                                      SearchSectionWidget(),
                                      TagSectionWidget(),
                                    ],
                                  ),
                                ),
                              );
                            },
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
}
