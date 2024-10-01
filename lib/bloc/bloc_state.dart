import 'package:news_api_clone/models/news_api_model.dart';

abstract class BlocState{}

class BlocInitialState extends BlocState{}
class BlocLoadedState extends BlocState{
  NewsDataModel? newsHeadingData;
  NewsDataModel? newsEverythingData;
  BlocLoadedState({required this.newsHeadingData,required this.newsEverythingData});
}
class BlocLoadingState extends BlocState{}
class BlocErrorState extends BlocState{
  String? errorMsg;
  BlocErrorState({required this.errorMsg});
}