import 'package:flutter/material.dart';
import '../models/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    Key? key,
    required this.article,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Row(
              children: [
                // 左側: サムネイル画像 (1/4)
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: SizedBox(
                    height: 100, // 固定の高さを設定
                    child: AspectRatio(
                      aspectRatio: 1, // 正方形
                      child: Image.asset(
                        article.imagePath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // 右側: 記事情報 (3/4)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 記事タイトル
                        Text(
                          article.title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // 記事概要 (1行)
                        Text(
                          article.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // 更新日
                        Text(
                          '更新日: ${article.date.year}-${article.date.month.toString().padLeft(2, '0')}-${article.date.day.toString().padLeft(2, '0')}',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                        ),

                        const SizedBox(height: 8),

                        // 紐付けタグ
                        Wrap(
                          spacing: 6.0,
                          children: article.tags.map((tag) {
                            return Chip(
                              label: Text(tag),
                              backgroundColor:
                                  Colors.blueAccent.withOpacity(0.2),
                              labelStyle: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
