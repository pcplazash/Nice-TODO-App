import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../core/models/todo_model.dart';
import '../../core/themes/font_theme.dart';
import '/blocs/blocs_barrels.dart';
import 'todo_item.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({Key? key}) : super(key: key);

  List<Todo> setFilteredTodos(
    Filter filter,
    List<Todo> todos,
    String searchTerm,
  ) {
    List<Todo> _filteredTodos;

    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = _filteredTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    return _filteredTodos;
  }

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosBloc>().state.filteredTodos;
    final color = Theme.of(context).colorScheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoFilterBloc, TodoFilterState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              state.filter,
              context.read<TodoListBloc>().state.todos,
              context.read<TodoSearchBloc>().state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
        BlocListener<TodoSearchBloc, TodoSearchState>(
          listener: (context, state) {
            final filteredTodos = setFilteredTodos(
              context.read<TodoFilterBloc>().state.filter,
              context.read<TodoListBloc>().state.todos,
              state.searchTerm,
            );
            context
                .read<FilteredTodosBloc>()
                .add(CalculateFilteredTodosEvent(filteredTodos: filteredTodos));
          },
        ),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        separatorBuilder: (BuildContext context, int index) {

          return Divider(color: color.tertiary);
        },
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todos[index].id),
            background: showBackground(context, 0),
            secondaryBackground: showBackground(context, 1),
            onDismissed: (_) {
              context
                  .read<TodoListBloc>()
                  .add(RemoveTodoEvent(todo: todos[index]));
            },
            confirmDismiss: (_) {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: color.secondary.withOpacity(0.85).withBlue(150),
                    title: Text(
                      'Are you sure?',
                      style: subTitleFontStyle(context, Colors.white),
                    ),
                    content: Text(
                      'Do you really want to delete this task?',
                      style: bodyFontStyle(context, Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(color.background),
                            side: MaterialStateProperty.all(
                                BorderSide(color: color.primary))),
                        child: Text('No', style: buttonFontStyle(context, color.primary)),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(color.background),
                            side: MaterialStateProperty.all(
                                BorderSide(color: color.primary))),
                        child: Text(
                          'Yes',style: buttonFontStyle(context, color.primary)
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: TodoItem(todo: todos[index]),
          );
        },
      ),
    );
  }

  Widget showBackground(BuildContext context, int direction) {
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(24),
        color: color.secondary.withOpacity(0.7).withBlue(150),
      ),
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: Icon(
        Icons.delete_sweep_outlined,
        size: 30.0,
        color: color.background,
      ),
    );
  }
}
