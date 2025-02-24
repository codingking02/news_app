import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/news/data/model/news_response/article.dart';
import 'package:news_app/news/viewmodel/news_viewmodel.dart';
import 'package:news_app/news/widgets/floatingbottomsheet.dart';
import 'package:news_app/news/widgets/news_item.dart';
import 'package:news_app/news/widgets/searchtextfield.dart';
import 'package:news_app/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({super.key});
  static const routeName = 'search-screen';
  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Article> news = [];
  List<int> searchList = [];
  bool isAssigned = false;
  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<SettingsProvider>(context).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Consumer<NewsViewmodel>(
        builder: (_, viewModel, __) {
          news = viewModel.allArticles;
          if (!isAssigned) {
            searchList = List.generate(
              viewModel.allArticles.length,
              (index) => index,
            );
            isAssigned = true;
          }
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Searchtextfield(
                  textEditingController: searchController,
                  onClear: () {
                    searchController.clear();
                    onSearch('');
                  },
                  onTap: () {
                    scrollController.animateTo(
                      0.0, // Scroll to the top
                      duration: Duration(milliseconds: 500), // Smooth animation
                      curve: Curves.easeInOut,
                    );
                  },
                  onChanged: (query) {
                    onSearch(query);
                  },
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: index == viewModel.allArticles.length - 1
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
                                  article: viewModel.allArticles[index],
                                );
                              },
                            );
                          },
                          child: searchList.contains(index)
                              ? NewsItem(
                                  article: viewModel.allArticles[index],
                                )
                              : SizedBox.shrink(),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return searchList.contains(index)
                          ? SizedBox(
                              height: 16.h,
                            )
                          : SizedBox.shrink();
                    },
                    itemCount: viewModel.allArticles.length,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void onSearch(String query) {
    searchList.clear();
    for (int i = 0; i < news.length; i++) {
      if ((news[i].author ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (news[i].content ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (news[i].title ?? '').toLowerCase().contains(query.toLowerCase()) ||
          (news[i].description ?? '').toLowerCase().contains(
                query.toLowerCase(),
              )) {
        searchList.add(i);
      }
    }
    setState(() {});
  }
}
