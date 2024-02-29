import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/ui/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void increment() => emit(state.copyWith(count: state.count + 1));
}
