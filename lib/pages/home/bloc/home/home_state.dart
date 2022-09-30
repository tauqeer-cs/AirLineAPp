part of 'home_cubit.dart';

class HomeState extends Equatable {
  final List<HomeContent> contents;
  final BlocState blocState;
  final String message;

  const HomeState({
    this.contents =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });

  HomeState copyWith({
    BlocState? blocState,
    String? message,
    List<HomeContent>? contents,
  }) {
    return HomeState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      contents: contents ?? this.contents,
    );
  }

  @override
  List<Object?> get props => [contents, blocState, message];
}
