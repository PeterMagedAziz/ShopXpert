import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_app/modules/search/cubit/states.dart';
import 'package:salla_app/shard/network/remote/end_points.dart';

import '../../../models/search_model.dart';
import '../../../shard/component/constants.dart';
import '../../../shard/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search({required String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      lang: 'lang',
      data: {
        'text': text,
      },
    ).then((value) async {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
