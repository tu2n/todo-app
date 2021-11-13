import 'package:meta/meta.dart';
import 'todo/todo_state.dart';


@immutable
class AppState {
  final TodoState todoState;

  const AppState({
    @required this.todoState,
  });

  factory AppState.initial() => AppState(
    todoState: TodoState.initial(),
  );


  AppState copyWith({
    todoState,
  }) => AppState(
    todoState: todoState ?? this.todoState,
  );
}