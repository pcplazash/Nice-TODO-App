import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '/blocs/blocs_barrels.dart';
import 'core/global_blocs/cubits/color_theme_cubit/color_theme_cubit.dart';
import 'todo_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ColorThemeCubit>(
        create: (context) => ColorThemeCubit(),
      ),
      BlocProvider<TodoFilterBloc>(
        create: (context) => TodoFilterBloc(),
      ),
      BlocProvider<TodoSearchBloc>(
        create: (context) => TodoSearchBloc(),
      ),
      BlocProvider<TodoListBloc>(
        create: (context) => TodoListBloc(),
      ),
      BlocProvider<ActiveTodoCountBloc>(
        create: (context) => ActiveTodoCountBloc(
          initialActiveTodoCount:
              context.read<TodoListBloc>().state.todos.length,
        ),
      ),
      BlocProvider<FilteredTodosBloc>(
        create: (context) => FilteredTodosBloc(
          initialTodos: context.read<TodoListBloc>().state.todos,
        ),
      ),
    ], child: TodoApp());
  }
}
