import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/mynews.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  NewsItem({required this.myNews, super.key});
  MyNews myNews;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    DateTime dateTime = DateTime.parse(myNews.publishedAt);
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.white),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: myNews.urlToImage,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppTheme.white,
                highlightColor: AppTheme.white,
                child: Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.grey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
              height: 220.h,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            myNews.content ?? '',
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
                  'By : ${myNews.author ?? ''}',
                  style: textTheme.labelMedium,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Text(
                timeago.format(dateTime, allowFromNow: true),
                style: textTheme.labelMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
