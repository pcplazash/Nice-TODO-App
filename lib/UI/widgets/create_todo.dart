import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/themes/font_theme.dart';
import '/blocs/blocs_barrels.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  _CreateTodoState createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  final TextEditingController newTodoController = TextEditingController();

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .colorScheme;
    return TextField(
      controller: newTodoController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelText: 'Add New TODO',
          labelStyle: smallFontStyle(context, color.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),

          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.add_task, color: color.secondary,),
              // You can replace this with your desired icon
              onPressed: () {
                String? todoDesc = newTodoController.text.trim();
                if (todoDesc
                    .trim()
                    .isNotEmpty) {
                  context.read<TodoListBloc>().add(
                      AddTodoEvent(todoDesc: todoDesc));
                  newTodoController.clear();
                  FocusScope.of(context).unfocus();
                }
              },
            ),
          )

      ),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc
            .trim()
            .isNotEmpty) {
          context.read<TodoListBloc>().add(AddTodoEvent(todoDesc: todoDesc));
          newTodoController.clear();
        }
      },

      style: bodyFontStyle(context, color.outline),
      maxLength: 50,


    );
  }
}