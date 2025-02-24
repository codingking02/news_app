import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  NewsItem({required this.article, super.key});
  Article article;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: isDark ? AppTheme.white : AppTheme.black),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              placeholder: (context, url) => isDark
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade800, // Darker grey for base
                      highlightColor:
                          Colors.grey.shade500, // Lighter grey for highlight
                      child: Container(
                        width: double.infinity,
                        height: 350.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey.shade300, // Light grey for base
                      highlightColor:
                          Colors.grey.shade100, // Brighter white for highlight
                      child: Container(
                        width: double.infinity,
                        height: 350.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                color: isDark ? AppTheme.white : AppTheme.black,
              ),
              fit: BoxFit.cover,
              height: 220.h,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            article.content ?? '',
            style: textTheme.titleMedium,
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'By : ${article.author ?? ''}',
                  style: textTheme.labelMedium,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Text(
                timeago.format(article.publishedAt ?? DateTime.now(),
                    allowFromNow: true),
                style: textTheme.labelMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
