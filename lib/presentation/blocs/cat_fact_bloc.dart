import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_app/data/local_dataproviders/hive_helper.dart';
import 'package:test_app/data/remote_dataproviders/api_client.dart';
import 'package:test_app/domain/models/cat_model.dart';

part 'cat_fact_event.dart';
part 'cat_fact_state.dart';

class CatFactBloc extends Bloc<CatFactEvent, CatFactState> {
  final _apiClient = ApiClient();
  final _hiveBox = LocalDataProvider();

  void addToBox(CatFactModel catFactModel) {
    final box = _hiveBox.box();
    box.add(catFactModel);
  }

  CatFactBloc() : super(CatFactInitialState()) {
    on<CatFactLoadEvent>((event, emit) async {
      try {
        final CatFactModel catFactModel = await _apiClient.getFact();

        addToBox(catFactModel);
        final String imgUrl = _apiClient.imgUrl();

        emit(CatFactLoadedState(catFactModel, imgUrl));
      } catch (e) {
        print('error: $e');
        emit(CatFactErrorState(e.toString()));
      }
    });

    on<CatFactNextRandomEvent>((event, emit) async {
      try {
        final CatFactModel catFactModel = await _apiClient.getFact();

        addToBox(catFactModel);

        final String imgUrl = _apiClient.imgUrl();

        emit(CatFactLoadedState(catFactModel, imgUrl));
      } catch (e) {
        print('error: $e');
        emit(CatFactErrorState(e.toString()));
      }
    });

    on<ShowHistoryEvent>((event, emit) async {
      try {
        final box = _hiveBox.box();
        List<CatFactModel> history = [];

        history = box.values.toList();

        emit(ShowHistoryState(history));
      } catch (e) {
        print('error: $e');
        emit(CatFactErrorState(e.toString()));
      }
    });
  }
}
