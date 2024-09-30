import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_clone/bloc/bloc_events.dart';
import 'package:news_api_clone/bloc/bloc_news.dart';
import 'package:news_api_clone/constants/color_const.dart';
import 'package:news_api_clone/constants/text_style.dart';
import 'package:news_api_clone/constants/widget_const.dart';
import 'package:news_api_clone/models/news_api_model.dart';
import 'package:news_api_clone/utils/api_helper.dart';

import '../bloc/bloc_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData? mqData;
  String search = "Politic";
  bool onChange = false;
  List<String> trendingNews = [
    "Politic",
    "Nature",
    "Education",
    "Sports",
    "Food",
    "Electric"
  ];

  @override
  void initState() {
    onChange = false;
    context.read<BlocNews>().add(GetHeadingNewsBlocEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    onChange
        ? context
            .read<BlocNews>()
            .add(GetEveryThingNewsBlocEvent(keywordTitle: search))
        : context.read<BlocNews>().add(GetHeadingNewsBlocEvent());
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            onChange = true;
            setState(() {
              if (search == "") {
                search = "food";
              }
              search = value;
            });
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Let's see what happened today....",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ),
      body: BlocBuilder<BlocNews, BlocState>(builder: (_, state) {
        if (state is BlocLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is BlocErrorState) {
          return Text(state.errorMsg!);
        } else if (state is BlocLoadedState) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: mqData!.size.height,
                child: Column(
                  children: [
                    /*----Breaking News Heading------*/
                    SizedBox(
                      height: mqData!.size.height * 0.07,
                      child: HeadingRow.row(
                          heading: "Breaking News !",
                          style: mTextStyle.mStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.black)),
                    ),
                    /*----Breaking News Container------*/
                    SizedBox(
                      height: mqData!.size.height * 0.3,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.newsData!.articles!.length,
                          itemBuilder: (_, index) {
                            var data = state.newsData!.articles;
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 15, top: 10, bottom: 10),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: mqData!.size.height * 0.2,
                                  width: mqData!.size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: data![index].urlToImage != null
                                      ? Stack(
                                          children: [
                                            Positioned.fill(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    data[index].urlToImage!,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                            Positioned(
                                                bottom: 10,
                                                child: Container(
                                                  padding: EdgeInsets.all(8.0),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      20,
                                                  child: Text(
                                                    data[index].title!,
                                                    style: mTextStyle.mStyle(
                                                        fontColor: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                )),
                                            Positioned(
                                              top: 40,
                                              left: 10,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    data[index].source!.name!,
                                                    style: mTextStyle.mStyle(
                                                        fontColor: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Icon(
                                                    Icons.circle,
                                                    size: 6,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    data[index].publishedAt!,
                                                    style: mTextStyle.mStyle(
                                                        fontColor: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      : Center(
                                          child: Text("No Image loaded...")),
                                ),
                              ),
                            );
                          }),
                    ),
                    /*----Trending right now------*/
                    SizedBox(
                      height: mqData!.size.height * 0.07,
                      child: HeadingRow.row(
                          heading: "Trending Right Now",
                          style: mTextStyle.mStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontColor: Colors.black)),
                    ),
                    /*----Category Name ------*/
                    SizedBox(
                      height: mqData!.size.height * 0.1,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: trendingNews.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    trendingNews[index],
                                    style: mTextStyle.mStyle(
                                        fontColor: Colors.black),
                                  )),
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
          // return state.newsData != null
          //     ? ListView.builder(
          //         itemCount: state.newsData!.articles!.length,
          //         itemBuilder: (_, index) {
          //           var data = state.newsData!.articles;
          //           return data != null
          //               ? Stack(
          //                 children: [
          //                   Image.network(data[index].urlToImage ?? ""),
          //                   ListTile(
          //                     title: Text(data[index].title!),
          //                     subtitle: Text(data[index].description ?? ""),
          //                   ),
          //                 ],
          //               )
          //               : Center(child: CircularProgressIndicator());
          //         })
          //     : Center(child: CircularProgressIndicator());
        }
        return Container();
      }),
    );
  }
}
