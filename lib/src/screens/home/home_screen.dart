import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';


import '../../model/todo.dart';
import '../../redux/app_state.dart';
import '../../utilities/size_config.dart';
import '../../redux/todo/todo_action.dart';
import 'components/create_todo_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: const Text("TODO"),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return CreateTodoDialog(
                        controller: controller,
                        cancel: () => Navigator.pop(context),
                        save: () {
                          Todo todo = Todo(
                            title: controller.text,
                            status: TodoStatus.Incomplete
                          );

                          store.dispatch(AddTodo(todo: todo));
                          controller.clear();
                          Navigator.pop(context);
                        },
                      );
                    }
                );
              },
              icon: const Icon(CupertinoIcons.add)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StoreConnector<AppState, dynamic>(
                converter: (store) => store.state.todoState.todos,
                builder: (context, vm) {
                  List<Todo> todos = [];
                  todos = vm;
                  return todos.isNotEmpty
                      ? ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration (
                              color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(todos[index].title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(describeEnum(todos[index].status),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 10);
                        },
                  ) : Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: SizeConfig.safeBlockVertical * 20
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/empty.svg',
                            height: 200,
                          ),
                          const SizedBox(height: 20,),
                          const Text("Tap add button to create todo.", style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}