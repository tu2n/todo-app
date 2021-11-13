
import 'app_state.dart';
import 'todo/todo_reducer.dart';


AppState appReducer(AppState state, action) {
  return AppState(
    todoState: todoReducer(state.todoState, action),
  );
}