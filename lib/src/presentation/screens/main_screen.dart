import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/core/Navigation.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/navigation/navigation_cubit.dart';
import 'package:way_to_fit/src/presentation/screens/profile/profile_screen.dart';
import 'package:way_to_fit/src/presentation/screens/rm/rm_screen.dart';
import 'package:way_to_fit/src/presentation/screens/wod/wod_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => injector.get<NavigationCubit>(),
        child: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: _buildBottomNavigationBar(),
          floatingActionButton: _buildFloatingActionButton(),
        ));
  }

  Widget _buildBody() {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      if (state.navigationBarItem == NavigationBarItem.wod) {
        return const WodScreen();
      } else if (state.navigationBarItem == NavigationBarItem.rm) {
        return const RmScreen();
      } else if (state.navigationBarItem == NavigationBarItem.profile) {
        return const ProfileScreen();
      }
      // TODO : error page
      return Container();
    });
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      if (state.navigationBarItem == NavigationBarItem.wod) {
        return FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () => {});
      } else if (state.navigationBarItem == NavigationBarItem.rm) {
        return FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () => {});
      }
      return Container();
    });
  }

  Widget _buildBottomNavigationBar() {
    NavigationCubit navigationCubit = injector.get<NavigationCubit>();

    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return NavigationBar(
        selectedIndex: state.index,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          if (index == 0) {
            navigationCubit.getNavigationBarItem(NavigationBarItem.wod);
          } else if (index == 1) {
            navigationCubit.getNavigationBarItem(NavigationBarItem.rm);
          } else if (index == 2) {
            navigationCubit.getNavigationBarItem(NavigationBarItem.profile);
          }
        },
        destinations: [
          NavigationDestination(
              icon: Icon(NavigationBarItem.wod.icon),
              label: NavigationBarItem.wod.label),
          NavigationDestination(
              icon: Icon(NavigationBarItem.rm.icon),
              label: NavigationBarItem.rm.label),
          NavigationDestination(
              icon: Icon(NavigationBarItem.profile.icon),
              label: NavigationBarItem.profile.label),
        ],
      );
    });
  }
}
