import 'package:redux/redux.dart';

import 'todo_action.dart';
import 'todo_state.dart';

final todoReducer = combineReducers<TodoState>([
  TypedReducer<TodoState, SetCompleteAction>(_setCompleteAction),
]);

TodoState _setCompleteAction(TodoState state, SetCompleteAction action) {
  return state.copyWith(todos: action.todos);
}