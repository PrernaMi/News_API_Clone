import 'package:bloc/bloc.dart';
import 'package:news_api_clone/bloc/bloc_events.dart';
import 'package:news_api_clone/bloc/bloc_state.dart';
import 'package:news_api_clone/utils/api_helper.dart';

class BlocNews extends Bloc<BlocEvents, BlocState> {
  ApiHelper? apiHelper;

  BlocNews({required this.apiHelper}) : super(BlocInitialState()) {

    on<GetNewsBlocEvent>((event, emit) async {
      emit(BlocLoadingState());
      var data = await apiHelper!.getApi(
          url:
              "https://newsapi.org/v2/everything?q=${event.keywordTitle}&apiKey=4ab369a46bc84b2abb4ea4369b772b06");
      var data1 = await apiHelper!.getApi(
          url:
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=4ab369a46bc84b2abb4ea4369b772b06");
      if(data != null && data1 != null){
        emit(BlocLoadedState(newsEverythingData: data,newsHeadingData: data1));
      }else{
        emit(BlocErrorState(errorMsg: "No Data loaded...."));
      }
    });
  }
}
