import 'dart:io';

import 'package:api_pj/controller/radom_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/random_user/random_user_bloc.dart';
import '../model/random_user_model.dart';

class RandomController {
  BuildContext context;

  RandomController(this.context);

  RandomService randomService = RandomService();
  final ScrollController scrollController = ScrollController();

  String errorConnect = '';
  List<Results> listData = [];
  bool isLoadingMore = false;
  int page = 1;

  Future<void> getDataUser() async {
    try {
      RandomUserModel response = await randomService.random(page);
      if (response.results!.isNotEmpty) {
        if (page == 1) {
          listData = response.results ?? [];
        } else {
          listData.addAll(response.results ?? []);
        }
        isLoadingMore = false;
        context.read<RandomUserBloc>().add(RandomUserEvent(listData: listData));
      } else {
        print('Lỗi dữ liệu');
      }
    } catch (e) {
      print('Lỗi: $e');
      isLoadingMore = false;
      context.read<RandomUserBloc>().add(RandomUserEvent(isLoadingMore: isLoadingMore));
    }
  }

  void internet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        getDataUser();
        errorConnect = '';
        context
            .read<RandomUserBloc>()
            .add(RandomUserEvent(errorConnect: errorConnect));
      }
    } on SocketException catch (_) {
      errorConnect = 'not connected';
      context
          .read<RandomUserBloc>()
          .add(RandomUserEvent(errorConnect: errorConnect));
      print('not connected');
    }
}

void scrollListener() {
  if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      isLoadingMore = true;
      page++;
      context
          .read<RandomUserBloc>()
          .add(RandomUserEvent(isLoadingMore: isLoadingMore));
      getDataUser();
    }
  }
}
