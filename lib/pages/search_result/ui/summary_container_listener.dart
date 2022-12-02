import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryContainerListener extends StatefulWidget {
  final Widget child;

  const SummaryContainerListener(
      {Key? key, required this.child, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  State<SummaryContainerListener> createState() =>
      _SummaryContainerListenerState();
}

class _SummaryContainerListenerState extends State<SummaryContainerListener> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isOpen = context.watch<SummaryContainerCubit>().state;
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (widget.scrollController.position.pixels == 0 ||
            widget.scrollController.position.pixels >=
                widget.scrollController.position.maxScrollExtent - 125) {
          if (!isOpen) {
            context.read<SummaryContainerCubit>().changeVisibility(true);
          }
        }
        /*else if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          if (isOpen) {
            context.read<SummaryContainerCubit>().changeVisibility(false);
          }
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward){
          if (!isOpen) {
            context.read<SummaryContainerCubit>().changeVisibility(true);
          }
        }*/
        else {
          if (isOpen) {
            context.read<SummaryContainerCubit>().changeVisibility(false);
          }
        }

        //context.read<SummaryContainerCubit>().changeVisibility(true);
        return true;
      },
      child: widget.child,
    );
  }
}
