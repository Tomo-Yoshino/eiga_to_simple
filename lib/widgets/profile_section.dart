import 'package:flutter/material.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 背景にグラデーションを適用
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFC1CC), // 淡いピンク
            Color(0xFFFF91AF), // 明るいピンク
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      // 余白を調整（上部のマージンを削除）
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(
          bottom: 8.0, left: 8.0, right: 8.0), // 上部のマージンを削除
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // プロフィール写真
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white, // 外枠用の下地色
            backgroundImage: const AssetImage(
              'assets/images/profile.png', // ローカルアセットパス
            ),
          ),
          const SizedBox(height: 12),

          // 名前
          const Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // 肩書き
          const SizedBox(height: 4),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),

          // 筆者概要 (自己紹介等)
          const SizedBox(height: 12),
          const Text(
            'I am a Flutter developer with 5+ years experience in mobile and web. '
            'I love traveling, coffee, and exploring new technologies.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
