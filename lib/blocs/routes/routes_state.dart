part of 'routes_cubit.dart';



class RoutesState extends Equatable {
  final List<CMSRoute> routes;
  final BlocState blocState;
  final String message;

  const RoutesState({
    this.routes =const [],
    this.blocState = BlocState.initial,
    this.message = '',
  });

  RoutesState copyWith({
    BlocState? blocState,
    String? message,
    List<CMSRoute>? routes,
  }) {
    return RoutesState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      routes: routes ?? this.routes,
    );
  }

  @override
  List<Object?> get props => [routes, blocState, message];
}
