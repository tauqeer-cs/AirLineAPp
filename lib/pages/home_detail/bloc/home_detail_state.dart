part of 'home_detail_cubit.dart';

@immutable
class HomeDetailState extends Equatable {
  final HomeDetail? content;
  final BlocState blocState;
  final String message;

  const HomeDetailState({
    this.content,
    this.blocState = BlocState.initial,
    this.message = '',
  });

  HomeDetailState copyWith({
    BlocState? blocState,
    String? message,
    HomeDetail? content,
  }) {
    return HomeDetailState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [content, blocState, message];
}
