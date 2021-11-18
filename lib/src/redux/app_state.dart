import 'package:meta/meta.dart';
import 'home/home_state.dart';
import 'todo/todo_state.dart';


@immutable
class AppState {
  final TodoState todoState;
  final HomeState homeState;

  const AppState({
    @required this.todoState,
    @required this.homeState
  });

  factory AppState.initial() => AppState(
    todoState: TodoState.initial(),
    homeState: HomeState.initial(),

  );


  AppState copyWith({
    todoState,
    homeState
  }) => AppState(
    todoState: todoState ?? this.todoState,
    homeState: homeState ?? this.homeState
  );
}