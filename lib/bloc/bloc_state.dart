import 'package:news_api_clone/models/news_api_model.dart';

abstract class BlocState{}

class BlocInitialState extends BlocState{}
class BlocLoadedState extends BlocState{
  NewsDataModel? newsData;
  BlocLoadedState({required this.newsData});
}
class BlocLoadingState extends BlocState{}
class BlocErrorState extends BlocState{
  String? errorMsg;
  BlocErrorState({required this.errorMsg});
}