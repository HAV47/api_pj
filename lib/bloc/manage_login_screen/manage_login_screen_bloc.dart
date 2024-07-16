


import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_login_screen_event.dart';
part 'manage_login_screen_state.dart';


class ManageLoginScreenBloc extends Bloc<ManageLoginScreenEvent,ManageLoginScreenState>{
  ManageLoginScreenBloc() : super (ManageLoginScreenState(

  ));

}