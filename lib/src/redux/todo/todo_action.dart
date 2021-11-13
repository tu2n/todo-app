import 'package:todo_app/src/model/todo.dart';

class SetCompleteAction {
  final List<Todo> todos;
  final int index;

  SetCompleteAction({this.todos, this.index});

  @override
  String toString() {
    return '${super.toString()} : {Title: ${todos[index].title}';
  }
}