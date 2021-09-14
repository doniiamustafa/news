import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/API%20model/new_model.dart';
import 'package:news_app/news_screen/states.dart';

class ScreenCubit extends Cubit<NewsState>
{
  ScreenCubit() : super(LoadingsNewsState());

  static ScreenCubit get(context) => BlocProvider.of(context);

  NewModel newModel;
  List articles = [] ;

  void getNews() async {
    // NewModel newModel;  (global declared )

      emit(LoadingsNewsState());

      Dio dio = new Dio();
      dio.options.baseUrl = 'https://newsapi.org/';
      await dio.get(
          'v2/top-headlines',
          queryParameters: {
            "country" : "eg",
            "category" : "sports",
            "apiKey" : "cc4ead19257a47d4bd9b89c5baf18048",
          }
      ).then((value) {
        newModel = NewModel.fromJson(value.data);
        print('success++++');
       emit(SuccessNewsState());
      }).catchError((error)
      {
        print(error);
       emit(FailedNewsState());
      });
    }

  }
