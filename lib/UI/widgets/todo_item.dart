import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todo_list/todo_list_bloc.dart';
import '../../core/models/todo_model.dart';
import '../../core/themes/font_theme.dart';



class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  backgroundColor: color.secondary.withOpacity(0.85).withBlue(140),
                  title: Text(
                    'Edit Task',
                    style: subTitleFontStyle(context, Colors.white),
                  ),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    style: bodyFontStyle(context, color.primary),
                    maxLines: 4,
                    maxLength: 50,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      labelStyle: smallFontStyle(context, color.primary),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      filled: true,
                      errorText: error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(color.background),
                          side: MaterialStateProperty.all(
                              BorderSide(color: color.primary))),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel',
                          style: smallFontStyle(context, color.primary)),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error = textController.text.isEmpty ? true : false;
                          if (!error) {
                            context.read<TodoListBloc>().add(
                              EditTodoEvent(
                                id: widget.todo.id,
                                todoDesc: textController.text,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(color.background),
                          side: MaterialStateProperty.all(
                              BorderSide(color: color.primary))),
                      child: Text(
                        'Edit',
                        style: smallFontStyle(context, color.primary),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          activeColor: color.tertiary,
          checkColor: color.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          value: widget.todo.completed,
          onChanged: (bool? checked) {
            context
                .read<TodoListBloc>()
                .add(ToggleTodoEvent(id: widget.todo.id));
          },
        ),
      ),
      title: Text(
        widget.todo.desc,
        style: bodyFontStyle(context, color.outline),
      ),
    );
  }
}
