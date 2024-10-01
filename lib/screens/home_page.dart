import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_clone/bloc/bloc_events.dart';
import 'package:news_api_clone/bloc/bloc_news.dart';
import 'package:news_api_clone/constants/color_const.dart';
import 'package:news_api_clone/constants/text_style.dart';
import 'package:news_api_clone/constants/widget_const.dart';
import 'package:news_api_clone/models/news_api_model.dart';
import 'package:news_api_clone/screens/expanded_page.dart';
import 'package:news_api_clone/utils/api_helper.dart';

import '../bloc/bloc_state.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MediaQueryData? mqData;
  String search = "Politic";
  List<String> trendingNews = [
    "All",
    "Politic",
    "Nature",
    "Education",
    "Sports",
    "Food",
    "Electric"
  ];
  bool seeAllHeadline = false;
  bool onChange = false;

  @override
  void initState() {
    context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    if(onChange){
      context.read<BlocNews>().add(GetNewsBlocEvent(keywordTitle: search));
    }
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              if (search == "") {
                search = "food";
              }
              onChange = true;
              search = value;
              setState(() {

              });
            });
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: "Let's see what happened today....",
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<BlocNews, BlocState>(builder: (_, state) {
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /*----Breaking News Heading------*/
                          SizedBox(
                            height: mqData!.size.height * 0.05,
                            child: Text("Breaking News !",
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
                                itemCount: state.newsHeadingData!.articles!.length,
                                itemBuilder: (_, index) {
                                  var data = state.newsHeadingData!.articles;
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        right: 15, top: 10, bottom: 10),
                                    child: InkWell(
                                      onTap: () {
                                        print(data[index].content!);
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return ExpandedNews(newsData: state.newsHeadingData!.articles![index],);
                                        }));
                                      },
                                      child: Container(
                                        height: mqData!.size.height * 0.2,
                                        width: mqData!.size.width * 0.8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: data![index].urlToImage != null
                                            ? Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        child: Image.network(
                                                          data[index]
                                                              .urlToImage!,
                                                          fit: BoxFit.cover,
                                                        )),
                                                  ),
                                                  Positioned(
                                                      bottom: 10,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            20,
                                                        child: Text(
                                                          data[index].title!,
                                                          style:
                                                              mTextStyle.mStyle(
                                                                  fontColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                          textAlign:
                                                              TextAlign.start,
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
                                                          data[index]
                                                              .source!
                                                              .name!,
                                                          style:
                                                              mTextStyle.mStyle(
                                                                  fontColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                          data[index]
                                                              .publishedAt!,
                                                          style:
                                                              mTextStyle.mStyle(
                                                                  fontColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Center(
                                                child:
                                                    Text("No Image loaded...")),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          /*----Trending right now------*/
                          SizedBox(
                              height: mqData!.size.height * 0.05,
                              child: Text("Trending Right Now",
                                  style: mTextStyle.mStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontColor: Colors.black))),
                          /*----Category Name ------*/
                          SizedBox(
                            height: mqData!.size.height * 0.06,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: trendingNews.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Row(
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            overlayColor: Colors.blue,
                                          ),
                                            onPressed: () {
                                              context.read<BlocNews>().add(
                                                  GetNewsBlocEvent(
                                                      keywordTitle:
                                                          trendingNews[index]));
                                            },
                                            child: Text(
                                              trendingNews[index],
                                              style: mTextStyle.mStyle(
                                                  fontColor: Colors.black),
                                            )),
                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          /*----Trending right now List ------*/
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: state.newsEverythingData!.articles!.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return ExpandedNews(newsData: state.newsEverythingData!.articles![index]);
                                      }));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 6),
                                      height: mqData!.size.height * 0.14,
                                      width: mqData!.size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: mqData!.size.width * 0.4,
                                            height: mqData!.size.height*0.14,
                                            child: state
                                                        .newsEverythingData!
                                                        .articles![index]
                                                        .urlToImage !=
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: Image.network(
                                                      state
                                                          .newsEverythingData!
                                                          .articles![index]
                                                          .urlToImage!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )
                                                : Center(
                                                    child: Text(
                                                        "No Image loaded!!")),
                                          ),
                                          SizedBox(
                                            width: mqData!.size.width * 0.5,
                                            height: mqData!.size.height*0.1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    state.newsEverythingData!
                                                        .articles![index].title!,
                                                    softWrap: true,
                                                    style: mTextStyle.mStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            13), // Optional as this is true by default
                                                  ),
                                                ),
                                                Text(
                                                  state
                                                      .newsEverythingData!
                                                      .articles![index]
                                                      .source!
                                                      .name!,
                                                ),
                                                state.newsEverythingData!.articles![index]
                                                            .author !=
                                                        null
                                                    ? Text(
                                                        'Author: ${state.newsEverythingData!.articles![index].author}')
                                                    : Text(
                                                        "No Author name founded..")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
