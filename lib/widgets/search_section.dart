import 'package:flutter/material.dart';

class SearchSectionWidget extends StatelessWidget {
  const SearchSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50],
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '記事検索',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // テキストフィールドで検索キーワードを受け付け
          const TextField(
            decoration: InputDecoration(
              hintText: 'キーワードを入力',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // 検索実行処理を入れる
            },
            child: const Text('検索'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(40), // ボタンの高さを統一
              backgroundColor:
                  Colors.blueAccent, // 修正: primary → backgroundColor
            ),
          ),
        ],
      ),
    );
  }
}
