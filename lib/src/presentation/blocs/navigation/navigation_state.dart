part of 'navigation_cubit.dart';

class NavigationState extends Equatable {
  final NavigationBarItem navigationBarItem;

  const NavigationState(this.navigationBarItem);

  @override
  List<Object> get props => [navigationBarItem];
}
