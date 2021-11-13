
import 'app_state.dart';
import 'home/home_reducer.dart';
import 'todo/todo_reducer.dart';


AppState appReducer(AppState state, action) {
  return AppState(
    todoState: todoReducer(state.todoState, action),
    homeState: homeReducer(state.homeState, action)
  );
}