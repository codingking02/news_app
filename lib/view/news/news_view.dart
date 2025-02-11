import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/api/news_api.dart';
import 'package:news_app/main.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/model/mynews.dart';
import 'package:news_app/model/source.dart';
import 'package:news_app/theme/apptheme.dart';
import 'package:news_app/widgets/news/floatingbottomsheet.dart';
import 'package:news_app/widgets/news/news_item.dart';
import 'package:news_app/widgets/news/tab_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsView extends StatefulWidget {
  NewsView({required this.category, super.key});
  MyCategory category;
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<List<Source>> futureSources;
  @override
  void initState() {
    super.initState();
    futureSources = NewsApi().getCategorySources(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    //SECOND WAY WITH FUTUREBUILDER
    //LOADS TABBAR THEN NEWS
    return FutureBuilder<List<Source>>(
      future: futureSources,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.r),
                  child: CircularProgressIndicator(
                    color: AppTheme.white,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        } else if (!snapshot.hasData) {
          return Center(
            child: Icon(Icons.error),
          );
        } else {
          List<Source> sources = snapshot.data ?? [];
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    padding: EdgeInsetsDirectional.only(
                      start: 16.w,
                    ),
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorColor: AppTheme.white,
                    labelPadding: EdgeInsetsDirectional.only(end: 16.w),
                    dividerColor: Colors.transparent,
                    onTap: (index) async {
                      if (currentIndex == index) return;
                      currentIndex = index;
                      setState(() {});
                      // news.clear();
                      // setState(() {});
                      // news = await NewsApi()
                      //     .getNewsFromSource(sources[currentIndex].id);
                      // setState(() {});
                    },
                    tabs: sources.map((source) {
                      return TabItem(
                        source: source,
                        isSelected: currentIndex == sources.indexOf(source),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Expanded(
                  child: FutureBuilder<List<MyNews>>(
                    future: sources.isNotEmpty
                        ? NewsApi().getNewsFromSource(
                            sources[currentIndex].id,
                            context,
                          )
                        : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.white,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return ErrorWidget(snapshot.error.toString());
                      } else if (!snapshot.hasData) {
                        return Icon(Icons.error);
                      } else {
                        List<MyNews> news = snapshot.data ?? [];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == news.length - 1
                                    ? EdgeInsets.only(bottom: 16.h)
                                    : EdgeInsets.zero,
                                child: InkWell(
                                  onTap: () async {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Floatingbottomsheet(
                                          news: news[index],
                                        );
                                      },
                                    );
                                  },
                                  child: NewsItem(
                                    myNews: news[index],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16.h,
                              );
                            },
                            itemCount: news.length,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

//first Way WITHOUTUsing FUTUREBUILDER
//LOADS TABBAR(SOURCES) AND NEWS AT ONCE
// List<Source> sources = [];
// List<MyNews> news = [];
// int currentIndex = 0;
// @override
// void initState() {
//   super.initState();
//   getSourcesandNews();
// }
// Future<void> getSourcesandNews() async {
//   NewsApi newsApi = NewsApi();
//   sources = await newsApi.getCategorySources(widget.category);
//   news = await newsApi.getNewsFromSource(
//     sources[currentIndex].id,
//   );
//   setState(() {});
// }
// SizedBox(
//       width: double.infinity,
//       height: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           sources.isEmpty
//               ? Padding(
//                   padding: EdgeInsets.all(10.r),
//                   child: CircularProgressIndicator(
//                     color: AppTheme.white,
//                   ),
//                 )
//               : DefaultTabController(
//                   length: sources.length,
//                   child: TabBar(
//                     padding: EdgeInsetsDirectional.only(
//                       start: 16.w,
//                     ),
//                     tabAlignment: TabAlignment.start,
//                     isScrollable: true,
//                     indicatorColor: AppTheme.white,
//                     labelPadding: EdgeInsetsDirectional.only(end: 16.w),
//                     dividerColor: Colors.transparent,
//                     onTap: (index) async {
//                       if (currentIndex == index) return;
//                       currentIndex = index;

//                       news.clear();
//                       setState(() {});
//                       news = await NewsApi()
//                           .getNewsFromSource(sources[currentIndex].id);
//                       setState(() {});
//                     },
//                     tabs: sources.map((source) {
//                       return TabItem(
//                         source: source,
//                         isSelected: currentIndex == sources.indexOf(source),
//                       );
//                     }).toList(),
//                   ),
//                 ),
//           SizedBox(
//             height: 24.h,
//           ),
//           news.isEmpty
//               ? Expanded(
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       color: AppTheme.white,
//                     ),
//                   ),
//                 )
//               : Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     child: ListView.separated(
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: index == news.length - 1
//                               ? EdgeInsets.only(bottom: 16.h)
//                               : EdgeInsets.zero,
//                           child: NewsItem(
//                             myNews: news[index],
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) {
//                         return SizedBox(
//                           height: 16.h,
//                         );
//                       },
//                       itemCount: news.length,
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     )
