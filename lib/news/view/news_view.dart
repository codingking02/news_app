import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/viewmodel/news_viewmodel.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:news_app/news/widgets/floatingbottomsheet.dart';
import 'package:news_app/news/widgets/news_item.dart';
import 'package:news_app/sources/viewmodel/source_viewmodel.dart';
import 'package:news_app/sources/widgets/tab_item.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  NewsView({required this.category, super.key});
  MyCategory category;
  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  SourceViewmodel sourceViewmodel = SourceViewmodel();
  ScrollController scrollController = ScrollController();
  bool isAssigned = false;
  @override
  void initState() {
    super.initState();
    sourceViewmodel.getSources(widget.category);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.addListener(
          () {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              Provider.of<NewsViewmodel>(context, listen: false)
                  .getNews(sourceViewmodel.sources[currentIndex].id!);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sourceViewmodel,
      child: Consumer<SourceViewmodel>(
        builder: (_, viewModel, __) {
          if (viewModel.isLoading) {
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
          } else if (viewModel.errorMessage != null) {
            return ErrorWidget(viewModel.errorMessage ?? '');
          } else if (viewModel.sources.isEmpty) {
            return Center(
              child: Icon(Icons.error),
            );
          } else {
            List<Source> sources = viewModel.sources;
            if (!isAssigned) {
              Provider.of<NewsViewmodel>(context, listen: false).getNews(
                sources[currentIndex].id ?? '',
              );
              isAssigned = true;
            }
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
                        Provider.of<NewsViewmodel>(context, listen: false)
                            .resetNews();
                        Provider.of<NewsViewmodel>(context, listen: false)
                            .getNews(
                          sources[currentIndex].id ?? '',
                        );

                        setState(() {});
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
                    child: Consumer<NewsViewmodel>(
                      builder: (_, viewModel, __) {
                        if (viewModel.isLoading) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.r),
                              child: CircularProgressIndicator(
                                color: AppTheme.white,
                              ),
                            ),
                          );
                        } else if (viewModel.errorMessage != null) {
                          return ErrorWidget(viewModel.errorMessage ?? '');
                        } else if (viewModel.articles.isEmpty) {
                          return Icon(
                            Icons.error,
                            color: AppTheme.white,
                          );
                        } else {
                          List<Article> articles = viewModel.articles;

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: ListView.separated(
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index == articles.length) {
                                  if (viewModel.isLoading) {
                                    return viewModel.hasMoreData
                                        ? Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(16.r),
                                              child: CircularProgressIndicator(
                                                color: AppTheme.white,
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink();
                                  }
                                } else {
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
                                }
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemCount: articles.length + 1,
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
      ),
    );
  }
}
