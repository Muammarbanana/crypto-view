import 'package:flutter_bloc/flutter_bloc.dart';

class CustomThemeCubit extends Cubit<bool> {
  CustomThemeCubit() : super(false);

  void toggleDarkMode() {
    emit(!state);
  }
}
