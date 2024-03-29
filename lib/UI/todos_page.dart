import 'package:flutter/material.dart';

import '../core/utils/responsive.dart';
import '../UI/widgets/create_todo.dart';
import '../UI/widgets/search_and_filter_todo.dart';
import '../UI/widgets/show_todos.dart';
import '../UI/widgets/todo_header.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.wp(5), vertical: responsive.hp(5),),
            child: Column(
              children: [
                const TodoHeader(),
                SizedBox(height: responsive.hp(4),),
                const CreateTodo(),
                SizedBox(height: responsive.hp(0.5),),
                const SearchAndFilterTodo(),
                SizedBox(height: responsive.hp(1),),
                const ShowTodos(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}


