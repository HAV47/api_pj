part of 'random_user_bloc.dart';



class RandomUserEvent{
  List<Results>? listData;
  String? errorConnect;
  bool? isLoadingMore;

  RandomUserEvent({this.listData,this.errorConnect,this.isLoadingMore});
}