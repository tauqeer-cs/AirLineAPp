import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryContainerListener extends StatelessWidget {
  final Widget child;

  const SummaryContainerListener(
      {Key? key, required this.child, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        final isOpen = context.read<SummaryContainerCubit>().state;
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          print('User is going down');
          if (isOpen) {
            context.read<SummaryContainerCubit>().changeVisibility(false);
          }
        } else {
          if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
            print('User is going up');
            if (!isOpen) {
              context.read<SummaryContainerCubit>().changeVisibility(true);
            }
          }
        }
        return true;
      },
      child: child,
    );
  }
}