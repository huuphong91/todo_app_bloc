import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:todo_app_bloc/config/app_size.dart';
import 'package:todo_app_bloc/screens/home/bloc/home_bloc.dart';
import 'package:todo_app_bloc/screens/home/cubit/cubits.dart';
import 'package:todo_app_bloc/screens/home/home.dart';

class MyHomePage extends StatelessWidget {
  static const router = '/';

  MyHomePage({Key? key}) : super(key: key);

  final List<Widget> screens = [
    SizedBox.shrink(),
    SizedBox.shrink(),
    SizedBox.shrink(),
  ];

  setScreen(int index, Widget widget) {
    screens[index] = widget;
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeTabCubit>(create: (ctx) => HomeTabCubit()),
        BlocProvider<AllTodoCubit>(
            create: (ctx) =>
                AllTodoCubit(homeBloc: BlocProvider.of<HomeBloc>(context))),
        BlocProvider<CompleteTodoCubit>(
            create: (ctx) => CompleteTodoCubit(
                homeBloc: BlocProvider.of<HomeBloc>(context))),
        BlocProvider<IncompleteTodoCubit>(
            create: (ctx) => IncompleteTodoCubit(
                homeBloc: BlocProvider.of<HomeBloc>(context))),
      ],
      child: SafeArea(
        child: BlocBuilder<HomeTabCubit, int>(builder: (context, state) {
          if (screens[state] is SizedBox) {
            switch (state) {
              case 0:
                setScreen(state, AllToDoScreen());
                break;
              case 1:
                setScreen(state, CompleteToDoScreen());
                break;
              case 2:
                setScreen(state, IncompleteTodoScreen());
                break;
            }
          }
          return Scaffold(
            body: IndexedStack(index: state, children: screens),
            bottomNavigationBar: CustomBottomNavigation(
              animationDuration: Duration(milliseconds: 350),
              selectedItemOverlayColor: Color(0x383d63ff),
              backgroundColor: Colors.white,
              selectedIndex: state,
              onItemSelected: (index) {
                context.read<HomeTabCubit>().update(index);
              },
              items: <CustomBottomNavigationBarItem>[
                CustomBottomNavigationBarItem(
                  title: 'All',
                  icon: Icon(MdiIcons.formatListChecks, size: MySize.size22),
                  activeIcon:
                      Icon(MdiIcons.formatListChecks, size: MySize.size22),
                  activeColor: Color(0xff3d63ff),
                  inactiveColor: Color(0xff495057),
                ),
                CustomBottomNavigationBarItem(
                  title: 'Complete',
                  icon: Icon(MdiIcons.checkAll, size: MySize.size22),
                  activeIcon: Icon(MdiIcons.checkAll, size: MySize.size22),
                  activeColor: Color(0xff3d63ff),
                  inactiveColor: Color(0xff495057),
                ),
                CustomBottomNavigationBarItem(
                  title: 'Incomplete',
                  icon: Icon(Icons.radio_button_unchecked, size: MySize.size22),
                  activeIcon: Icon(Icons.radio_button_unchecked_outlined,
                      size: MySize.size22),
                  activeColor: Color(0xff3d63ff),
                  inactiveColor: Color(0xff495057),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
