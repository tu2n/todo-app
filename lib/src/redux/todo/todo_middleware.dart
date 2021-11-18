
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/todo.dart';
import '../app_state.dart';
import 'todo_action.dart';

class TodoMiddleware extends MiddlewareClass<AppState> {
  static final unSubscriber = PublishSubject<void>();

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {

    if(action is AddTodoAction) {
      List<Todo> todos = [];
      todos = store.state.todoState.todos;

      todos.add(action.todo);

      store.dispatch(UpdateTodos(todos: todos));
    }

    if(action is SetCompleteAction) {
      Todo todo = Todo(
        index: action.todo.index,
        title: action.todo.title,
        status: TodoStatus.Complete
      );

      store.state.todoState.todos.remove(action.todo);
      store.state.todoState.todos.add(todo);

    }

    if (action is SetIncompleteAction) {
      Todo todo = Todo(
          index: action.todo.index,
          title: action.todo.title,
          status: TodoStatus.Incomplete
      );

      store.state.todoState.todos.remove(action.todo);
      store.state.todoState.todos.add(todo);
    }

    next(action);
  }
}