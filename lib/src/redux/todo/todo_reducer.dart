import 'package:redux/redux.dart';

import 'todo_action.dart';
import 'todo_state.dart';

final todoReducer = combineReducers<TodoState>([
  TypedReducer<TodoState, UpdateTodos>(_updateTodos),
]);

TodoState _updateTodos(TodoState state, UpdateTodos action) {
  return state.copyWith(todos: action.todos);
}