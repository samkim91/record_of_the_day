part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavigationBarItem navigationBarItem;
  final int index;

  const NavigationState(this.navigationBarItem, this.index);

  @override
  List<Object> get props => [navigationBarItem, index];
}
