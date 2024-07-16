import 'package:api_pj/bloc/random_user/random_user_bloc.dart';
import 'package:api_pj/controller/random_controller.dart';
import 'package:api_pj/screen/manage_login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomUserScreen extends StatefulWidget {
  const RandomUserScreen({super.key});

  @override
  State<RandomUserScreen> createState() => _RandomUserScreenState();
}

class _RandomUserScreenState extends State<RandomUserScreen> {
  int page = 1;
  late RandomController controller;



  @override
  void initState() {
    super.initState();
    controller = RandomController(context);
    controller.internet();
    controller.scrollController.addListener(controller.scrollListener);
  }

  @override
  void dispose() {
    controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Danh sách',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => ManageLoginScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<RandomUserBloc, RandomUserState>(
          builder: (context, state) {
        if (state.errorConnect == 'not connected') {
          return ElevatedButton(
              onPressed: () {
                controller.internet();
              },
              child: const Text('thử lại'));
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              page = 1;
              await controller.getDataUser();
            },
            child: ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.listData.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.listData.length) {
                    return controller.isLoadingMore
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox.shrink();
                  }
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          '${state.listData?[index].picture?.medium}'),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: '${state.listData?[index].name?.first}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black),
                        children: <TextSpan>[
                          const TextSpan(text: ' '),
                          TextSpan(
                              text: '${state.listData?[index].name?.last}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      '${state.listData?[index].email}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                }),
          );
        }
      }),
    );
  }
}
