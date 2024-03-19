import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../blocs/todo_filter/todo_filter_bloc.dart';
import '../../core/models/todo_model.dart';
import '../../core/themes/font_theme.dart';

class FilterButton extends StatelessWidget {
  final Filter filter;

  const FilterButton({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final color = Theme.of(context).colorScheme;
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    final buttonColor = currentFilter == filter
        ? color.primary
        : color.tertiaryContainer.withOpacity(0.1);
    return Container(
      width: height * 0.13,
      height: height * 0.052,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextButton(
        onPressed: () {
          context
              .read<TodoFilterBloc>()
              .add(ChangeFilterEvent(newFilter: filter));
        },
        child: Text(
          filter == Filter.all
              ? 'All'
              : filter == Filter.active
                  ? 'Active'
                  : 'Completed',
          style: smallFontStyle(context, textColor(context, filter)),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final color = Theme.of(context).colorScheme;
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    return currentFilter == filter ? color.background : color.outline;
  }
}
