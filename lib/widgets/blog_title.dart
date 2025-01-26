import 'package:flutter/material.dart';

class BlogTitleWidget extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final String title; // 新しいパラメータを追加

  const BlogTitleWidget({
    Key? key,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.title = 'Test Blog', // デフォルト値を設定
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // グラデーション背景を追加
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7F00FF), Color(0xFFE100FF)], // 紫系のグラデーション
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // 上下左右の余白を広めにとる
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 戻るボタンを表示する場合
          if (showBackButton) ...[
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
              onPressed: onBackButtonPressed ?? () => Navigator.pop(context),
            ),
            const SizedBox(width: 8),
          ],

          // タイトル脇のアイコンを追加（アイコンはお好みで）
          const Icon(
            Icons.auto_stories_outlined,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 12),

          // タイトルテキストをパラメータから取得
          Text(
            title, // パラメータを使用
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28, // さらに大きめに設定
                ),
          ),
        ],
      ),
    );
  }
}
