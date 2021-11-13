
enum TodoStatus {Complete, Incomplete}

class Todo {
  final int index;
  final String title;
  final TodoStatus status;

  const Todo({this.index, this.title, this.status});
}