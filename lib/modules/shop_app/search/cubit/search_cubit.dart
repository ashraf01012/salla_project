import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/models/shop_app/search_model.dart';
import 'package:salla/modules/shop_app/search/cubit/search_state.dart';
import 'package:salla/shared/components/constans.dart';
import 'package:salla/shared/network/end_points.dart';
import 'package:salla/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
