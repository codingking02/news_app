import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/api/news_api.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/data/model/news_response/news_response.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/sources/data/model/source_response/source_response.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:news_app/news/widgets/floatingbottomsheet.dart';
import 'package:news_app/news/widgets/news_item.dart';
import 'package:news_app/sources/widgets/tab_item.dart';

class NewsView extends StatefulWidget {
  NewsView({required this.category, super.key});
  MyCategory category;
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<SourceResponse> futureSources;
  @override
  void initState() {
    super.initState();
    futureSources = NewsApi().getCategorySources(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    //SECOND WAY WITH FUTUREBUILDER
    //LOADS TABBAR THEN NEWS
    return FutureBuilder<SourceResponse>(
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
          List<Source> sources = snapshot.data!.sources ?? [];
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
                  child: FutureBuilder<NewsResponse>(
                    future: sources.isNotEmpty
                        ? NewsApi().getNewsFromSource(
                            sources[currentIndex].id ?? '',
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
                        List<Article> articles = snapshot.data!.articles ?? [];

                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: index == articles.length - 1
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
                                          article: articles[index],
                                        );
                                      },
                                    );
                                  },
                                  child: NewsItem(
                                    article: articles[index],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 16.h,
                              );
                            },
                            itemCount: articles.length,
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
