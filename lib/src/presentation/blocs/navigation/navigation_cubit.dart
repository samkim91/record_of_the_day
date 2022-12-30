import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:way_to_fit/src/core/Navigation.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavigationBarItem.wod, 0));

  void getNavigationBarItem(NavigationBarItem navigationBarItem) {
    switch (navigationBarItem) {
      case NavigationBarItem.wod:
        emit(const NavigationState(NavigationBarItem.wod, 0));
        break;
      case NavigationBarItem.rm:
        emit(const NavigationState(NavigationBarItem.rm, 1));
        break;
      case NavigationBarItem.profile:
        emit(const NavigationState(NavigationBarItem.profile, 2));
        break;
    }
  }
}
