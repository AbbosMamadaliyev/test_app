part of 'cat_fact_bloc.dart';

abstract class CatFactEvent extends Equatable {
  const CatFactEvent();
}

class CatFactLoadEvent extends CatFactEvent {
  @override
  List<Object?> get props => [];
}

class CatFactNextRandomEvent extends CatFactEvent {
  @override
  List<Object?> get props => [];
}

class ShowHistoryEvent extends CatFactEvent {
  @override
  List<Object?> get props => [];
}
