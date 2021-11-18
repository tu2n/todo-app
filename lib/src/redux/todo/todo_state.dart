import 'package:todo_app/src/model/todo.dart';

class TodoState {
  final List<Todo> todos;
  final int complete;
  final int inComplete;

  TodoState({
    this.todos,
    this.complete,
    this.inComplete
  });

  factory TodoState.initial() => TodoState(
      todos: <Todo>[],
      complete: null,
      inComplete: null
  );

  TodoState copyWith({
    List<Todo> todos,
    int complete,
    int inComplete,
  }) => TodoState(
    todos: todos ?? this.todos,
    complete: complete ?? this.complete,
    inComplete: inComplete ?? this.inComplete,
  );
}