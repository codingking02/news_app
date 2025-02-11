import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:news_app/widgets/news/floatingbottomsheet.dart';
import 'package:news_app/widgets/news/news_item.dart';
import 'package:news_app/widgets/news/searchtextfield.dart';
import 'package:provider/provider.dart';

class SearchNews extends StatefulWidget {
  const SearchNews({super.key});
  static const routeName = 'search-screen';
  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  TextEditingController searchController = TextEditingController();
  late NewsProvider newsProvider;
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
    newsProvider = Provider.of<NewsProvider>(context);
    if (!isAssigned) {
      searchList = List.generate(
        newsProvider.mynews.length,
        (index) => index,
      );
      isAssigned = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Searchtextfield(
              onChanged: (query) {
                onSearch(query);
                print(searchList);
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
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == newsProvider.mynews.length - 1
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
                              news: newsProvider.mynews[index],
                            );
                          },
                        );
                      },
                      child: searchList.contains(index)
                          ? NewsItem(
                              myNews: newsProvider.mynews[index],
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
                itemCount: newsProvider.mynews.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  void onSearch(String query) {
    searchList.clear();
    for (int i = 0; i < newsProvider.mynews.length; i++) {
      if (newsProvider.mynews[i].author
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          newsProvider.mynews[i].content
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          newsProvider.mynews[i].title
              .toLowerCase()
              .contains(query.toLowerCase()) ||
          newsProvider.mynews[i].description
              .toLowerCase()
              .contains(query.toLowerCase())) {
        searchList.add(i);
      }
    }
    setState(() {});
  }
}
