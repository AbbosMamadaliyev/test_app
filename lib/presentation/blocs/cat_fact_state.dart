part of 'cat_fact_bloc.dart';

abstract class CatFactState extends Equatable {
  const CatFactState();
}

class CatFactInitialState extends CatFactState {
  @override
  List<Object> get props => [];
}

class CatFactLoadedState extends CatFactState {
  CatFactModel catFactModel;
  String imgUrl;

  CatFactLoadedState(this.catFactModel, this.imgUrl);

  @override
  List<Object> get props => [catFactModel, imgUrl];
}

class ShowHistoryState extends CatFactState {
  List<CatFactModel> history;

  ShowHistoryState(this.history);

  @override
  List<Object> get props => [history];
}

class CatFactErrorState extends CatFactState {
  final String message;

  const CatFactErrorState(this.message);

  @override
  List<Object> get props => [message];
}
