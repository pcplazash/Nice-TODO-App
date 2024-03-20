import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/models/todo_model.dart';
import '../../core/themes/font_theme.dart';
import '/blocs/blocs_barrels.dart';


class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {

    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              'TODO App',
              style: titleFontStyle(context, color.primary),
            ),
            Text(
              'PCP-Dev',
              style: bodyFontStyle(context, color.secondary),
            ),
          ],
        ),
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final int activeTodoCount = state.todos
                .where((Todo todo) => !todo.completed)
                .toList()
                .length;

            context.read<ActiveTodoCountBloc>().add(
                CalculateActiveTodoCountEvent(
                    activeTodoCount: activeTodoCount));
          },
          child: BlocBuilder<ActiveTodoCountBloc, ActiveTodoCountState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${state.activeTodoCount}',
                    style:
                    titleFontStyle(context, color.tertiary),
                  ),
                  Text(
                    'Items left',
                    style:
                        subTitleFontStyle(context, color.tertiary),
                  ),
                ],
              );
            },
          ),
        ),
        // Text(
        //   '${context.watch<ActiveTodoCountCubit>().state.activeTodoCount} items left',
        //   style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
        // ),
      ],
    );
  }
}
