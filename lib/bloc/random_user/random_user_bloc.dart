
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/random_user_model.dart';

part 'random_user_event.dart';
part 'random_user_state.dart';

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  RandomUserBloc() : super (RandomUserState()) {
    on<RandomUserEvent>((event, emit) => emit(RandomUserState(
      listData: event.listData ?? state.listData,
      errorConnect: event.errorConnect ?? state.errorConnect,
      isLoadingMore: event.isLoadingMore ?? state.isLoadingMore,

    )));


  }
}