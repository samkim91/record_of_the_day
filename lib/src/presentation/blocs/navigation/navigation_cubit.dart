import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/presentation/screens/navigation.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationBarItem.wod));

  void getNavigationBarItem(NavigationBarItem navigationBarItem) {
    switch (navigationBarItem) {
      case NavigationBarItem.wod:
        emit(const NavigationState(NavigationBarItem.wod));
        break;
      case NavigationBarItem.rm:
        emit(const NavigationState(NavigationBarItem.rm));
        break;
      case NavigationBarItem.profile:
        emit(const NavigationState(NavigationBarItem.profile));
        break;
    }
  }
}
