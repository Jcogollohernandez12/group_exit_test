import 'package:flutter_bloc/flutter_bloc.dart';

class ExpressCubit extends Cubit<bool> {
  ExpressCubit() : super(false);

  void setActive(bool active) => emit(active);
  void toggle() => emit(!state);
}
