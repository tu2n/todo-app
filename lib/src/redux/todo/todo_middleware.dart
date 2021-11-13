
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/todo.dart';
import '../app_state.dart';
import 'todo_action.dart';

class TodoMiddleware extends MiddlewareClass<AppState> {
  static final unSubscriber = PublishSubject<void>();

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {


    if(action is AddTodo) {
      List<Todo> todos = [];
      todos = store.state.todoState.todos;

      todos.add(action.todo);

      store.dispatch(UpdateTodos(todos: todos));
    }
    next(action);
  }
}