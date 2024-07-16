part of 'random_user_bloc.dart';

class RandomUserState {
  List<Results>? listData;
  String? errorConnect;
  bool? isLoadingMore;

  RandomUserState({this.listData,this.errorConnect,this.isLoadingMore});
}