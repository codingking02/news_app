import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/model/category.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/viewmodel/news_viewmodel.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:news_app/sources/data/model/source_response/source.dart';
import 'package:news_app/settings/theme/apptheme.dart';
import 'package:news_app/news/widgets/floatingbottomsheet.dart';
import 'package:news_app/news/widgets/news_item.dart';
import 'package:news_app/sources/view/sources_tabbar.dart';
import 'package:news_app/sources/viewmodel/source_viewmodel.dart';
import 'package:news_app/sources/viewmodel/sources_states.dart';
import 'package:news_app/sources/widgets/tab_item.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  List<Source> sources = [];
  @override
  void initState() {
    super.initState();
    sourceViewmodel.getSources(widget.category);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.addListener(
          () {
            if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 200) {
              Provider.of<NewsViewmodel>(context, listen: false)
                  .getNews(sources[currentIndex].id!);
            }
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return BlocProvider(
      create: (context) => sourceViewmodel,
      child: BlocBuilder<SourceViewmodel, SourcesStates>(
        builder: (context, state) {
          if (state is GetSourcesLoading) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: CircularProgressIndicator(
                      color: isDark ? AppTheme.white : AppTheme.black,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is GetSourcesError) {
            return ErrorWidget(state.errorMessage);
          } else if (state is GetSourcesSuccess) {
            sources = state.sources;
            Provider.of<NewsViewmodel>(context, listen: false)
                .getAllNews(sources[currentIndex].id!);
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
                  DefaultTabBar(
                    onTap: (index) {
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
                    currentIndex: currentIndex,
                    sources: sources,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Expanded(
                    child: Consumer<NewsViewmodel>(
                      builder: (_, viewModel, __) {
                        if (viewModel.isLoading) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                return isDark
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey
                                            .shade800, // Darker grey for base
                                        highlightColor: Colors.grey
                                            .shade500, // Lighter grey for highlight
                                        child: Container(
                                          width: double.infinity,
                                          height: 350.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade900,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: Colors.grey
                                            .shade300, // Light grey for base
                                        highlightColor: Colors.grey
                                            .shade100, // Brighter white for highlight
                                        child: Container(
                                          width: double.infinity,
                                          height: 350.h,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemCount: 2,
                            ),
                          );
                        } else if (viewModel.errorMessage != null) {
                          return ErrorWidget(viewModel.errorMessage ?? '');
                        } else if (viewModel.articles.isEmpty) {
                          return Icon(
                            Icons.error,
                            color: isDark ? AppTheme.white : AppTheme.black,
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
                                                color: isDark
                                                    ? AppTheme.white
                                                    : AppTheme.black,
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
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
