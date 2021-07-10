import 'package:bloc/bloc.dart';

class HomeTabCubit extends Cubit<int> {
  HomeTabCubit() : super(0);

  void update(int index) => emit(index);
}
