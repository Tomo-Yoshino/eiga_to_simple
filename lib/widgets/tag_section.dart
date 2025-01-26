import 'package:flutter/material.dart';

class TagSectionWidget extends StatelessWidget {
  const TagSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ダミーのタグリスト
    final tags = ['Flutter', 'Dart', 'Web', 'Mobile', 'Design', 'Programming'];

    return Container(
      color: Colors.lightBlue[50],
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'タグで記事を絞り込み',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: tags.map((tag) {
              return ElevatedButton(
                onPressed: () {
                  // タグで記事を絞り込む処理
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent
                      .withOpacity(0.7), // 修正: primary → backgroundColor
                  foregroundColor:
                      Colors.white, // 修正: onPrimary → foregroundColor
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(tag),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
