
enum TodoStatus {Complete, Incomplete}

class Todo {
  final String title;
  final TodoStatus status;

  const Todo({this.title, this.status});
}