import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:way_to_fit/src/injector.dart';
import 'package:way_to_fit/src/presentation/blocs/navigation/navigation_cubit.dart';
import 'package:way_to_fit/src/presentation/screens/navigation.dart';
import 'package:way_to_fit/src/presentation/screens/profile/profile_screen.dart';
import 'package:way_to_fit/src/presentation/screens/rm/rm_list_screen.dart';
import 'package:way_to_fit/src/presentation/screens/wod/wod_create_screen.dart';
import 'package:way_to_fit/src/presentation/screens/wod/wod_list_screen.dart';

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
        return WodListScreen(scrollController: ScrollController());
      } else if (state.navigationBarItem == NavigationBarItem.rm) {
        return const RmListScreen();
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
            child: const Icon(Icons.add),
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WodCreateScreen()))
                });
      } else if (state.navigationBarItem == NavigationBarItem.rm) {
        return FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () => {});
      }
      return const SizedBox();
    });
  }

  Widget _buildBottomNavigationBar() {
    NavigationCubit navigationCubit = injector.get<NavigationCubit>();

    return BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
      return NavigationBar(
        selectedIndex: state.navigationBarItem.index,
        height: 70,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          if (index == NavigationBarItem.wod.index) {
            navigationCubit.getNavigationBarItem(NavigationBarItem.wod);
          } else if (index == NavigationBarItem.rm.index) {
            navigationCubit.getNavigationBarItem(NavigationBarItem.rm);
          } else if (index == NavigationBarItem.profile.index) {
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
