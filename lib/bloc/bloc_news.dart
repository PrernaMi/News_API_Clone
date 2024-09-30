import 'package:bloc/bloc.dart';
import 'package:news_api_clone/bloc/bloc_events.dart';
import 'package:news_api_clone/bloc/bloc_state.dart';
import 'package:news_api_clone/utils/api_helper.dart';

class BlocNews extends Bloc<BlocEvents, BlocState> {
  ApiHelper? apiHelper;

  BlocNews({required this.apiHelper}) : super(BlocInitialState()) {

    on<GetEveryThingNewsBlocEvent>((event, emit) async {
      emit(BlocLoadingState());
      var data = await apiHelper!.getApi(
          url:
              "https://newsapi.org/v2/everything?q=${event.keywordTitle}&apiKey=4ab369a46bc84b2abb4ea4369b772b06");
      if(data != null){
        emit(BlocLoadedState(newsData: data));
      }else{
        emit(BlocErrorState(errorMsg: "No Data loaded...."));
      }
    });

    on<GetHeadingNewsBlocEvent>((event, emit) async {
      emit(BlocLoadingState());
      var data = await apiHelper!.getApi(
          url:
              "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ab369a46bc84b2abb4ea4369b772b06");
      if(data != null){
        emit(BlocLoadedState(newsData: data));
      }else{
        emit(BlocErrorState(errorMsg: "No Data loaded...."));
      }
    });
  }
}
