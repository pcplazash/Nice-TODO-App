import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/todos_page.dart';
import 'core/global_blocs/cubits/color_theme_cubit/color_theme_cubit.dart';
import 'core/themes/app_theme.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);


  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ColorThemeCubit>().updateAppTheme();
    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
      title: 'Daily Task Organizer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.select(
              (ColorThemeCubit colorThemeCubit) => colorThemeCubit.state.themeMode),
      home: const TodosPage(),
    );
  }
}
