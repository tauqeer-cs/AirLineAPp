import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../widgets/app_error_screen.dart';
import '../widgets/app_loading_screen.dart';

class GenericState extends Equatable {
  final BlocState blocState;
  final String message;

  const GenericState({
    this.blocState = BlocState.initial,
    this.message = "",
  });

  @override
  List<Object?> get props => [blocState, message];

  GenericState copyWith({
    BlocState? blocState,
    String? message,
  }) {
    return GenericState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
    );
  }
}

enum BlocState { initial, loading, finished, failed }

void blocListenerWrapper(
    {Function()? onInitial,
    Function()? onLoading,
    Function()? onFinished,
    Function()? onFailed,
    required BlocState blocState}) {
  switch (blocState) {
    case BlocState.initial:
      if (onInitial != null) onInitial();
      break;
    case BlocState.loading:
      if (onLoading != null) onLoading();
      break;
    case BlocState.finished:
      if (onFinished != null) onFinished();
      break;
    case BlocState.failed:
      if (onFailed != null) onFailed();
      break;
  }
}

Widget blocBuilderWrapper({
  Widget? initialBuilder,
  Widget? loadingBuilder,
  Widget? finishedBuilder,
  Widget? failedBuilder,
  required BlocState blocState,
}) {
  switch (blocState) {
    case BlocState.initial:
      return initialBuilder ?? const SizedBox.shrink();
    case BlocState.loading:
      return loadingBuilder ?? AppLoadingScreen(message: "loading".tr());
    case BlocState.finished:
      return finishedBuilder ?? const SizedBox.shrink();
    case BlocState.failed:
      return failedBuilder ?? finishedBuilder ?? const AppErrorScreen();
  }
}
