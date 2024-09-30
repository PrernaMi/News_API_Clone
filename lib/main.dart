import 'package:flutter/material.dart';
import 'package:news_api_clone/bloc/bloc_news.dart';
import 'package:news_api_clone/screens/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_clone/utils/api_helper.dart';

void main() {
  runApp(BlocProvider(create: (context){
    return BlocNews(apiHelper: ApiHelper());
  },child: MyApp(),));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(),
    );
  }
}
