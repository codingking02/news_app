import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Floatingbottomsheet extends StatelessWidget {
  Floatingbottomsheet({required this.article, super.key});
  Article article;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Container(
      padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.white : AppTheme.black,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: CachedNetworkImage(
              imageUrl: article.urlToImage ?? '',
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: isDark ? AppTheme.white : AppTheme.black,
                highlightColor: isDark ? AppTheme.white : AppTheme.black,
                child: Container(
                  height: 220.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.grey,
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
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
            article.content ?? '',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isDark ? AppTheme.black : AppTheme.white,
                ),
          ),
          SizedBox(
            height: 8.h,
          ),
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () async {
                Uri url = Uri.parse(article.url ?? '');
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                  );
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? AppTheme.black : AppTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ),
                ),
              ),
              child: Text(
                'View Article',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
