import 'package:api_pj/bloc/random_user/random_user_bloc.dart';
import 'package:api_pj/controller/random_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageLoginScreen extends StatefulWidget {
  const ManageLoginScreen({super.key});

  @override
  State<ManageLoginScreen> createState() => _ManageLoginScreenState();
}

class _ManageLoginScreenState extends State<ManageLoginScreen> {
  late RandomController controller;

  @override
  void initState() {
    super.initState();
    controller = RandomController(context);
    controller.scrollController.addListener(controller.scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Login Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: BlocBuilder<RandomUserBloc, RandomUserState>(
                  builder: (context, state) {
                return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${state.listData?[index].picture?.medium}'),
                          radius: 30,
                        ),
                        title: Text(
                          '${state.listData?[index].login?.username}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${state.listData?[index].login?.password}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    });
              }),
            ),
            GestureDetector(
              onTap: () {
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text('Next page')),
                ),
              ),
            ),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: BlocBuilder<RandomUserBloc, RandomUserState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ListTile(

                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              '${state.listData?[index + 1].picture?.medium}'),
                          radius: 30,
                        ),
                        title: Text(
                          '${state.listData?[index + 5].login?.username}',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${state.listData?[index + 5].login?.password}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 14),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),

                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// biết ơn những người đã rời đi, trân trọng những người còn ở lại, cảm ơn quá khứ hiện tại tương lai mong rằng phút giây này sẽ còn mãi mãi
