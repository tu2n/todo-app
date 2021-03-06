
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


import '../../redux/home/home_action.dart';
import '../../../constants.dart';
import '../../model/todo.dart';
import '../../redux/app_state.dart';
import '../../utilities/size_config.dart';
import '../../redux/todo/todo_action.dart';
import 'components/create_todo_dialog.dart';
import 'components/empty_signage.dart';
import 'input_validator.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  int rebuild = 0;

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
      resizeToAvoidBottomInset: false,
      backgroundColor: kColor2,
      appBar: AppBar(
        backgroundColor: kColor2,
        elevation: 0.0,
        title: const Text("TODO"),
        actions: [
          IconButton(
              onPressed: () {
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return buildInputs(store);
                      // return CreateTodoDialog(
                      //   controller: controller,
                      //   cancel: () => Navigator.pop(context),
                      //   save: () {
                      //     int index;
                      //     if(store.state.todoState.todos.isEmpty) {
                      //       index = 0;
                      //     } else {
                      //       index = store.state.todoState.todos.length + 0;
                      //     }
                      //     Todo todo = Todo(
                      //       index: index,
                      //       title: controller.text,
                      //       status: TodoStatus.Incomplete
                      //     );
                      //
                      //     store.dispatch(AddTodoAction(todo: todo));
                      //     controller.clear();
                      //     Navigator.pop(context);
                      //   },
                      // );
                    }
                );
              },
              icon: const Icon(CupertinoIcons.add)
          ),
        ],
      ),
      body: StoreConnector<AppState, Map<String,dynamic>>(
        converter: (store) => {
          "todos" : store.state.todoState.todos,
          "indexTab" : store.state.homeState.indexTab
        },

        builder: (context, vm) {
          debugPrint("Tab index: ${vm['indexTab']}");
          String asset;
          String description;

          List<Todo> todos = [];
          List<Todo> finalTodos = [];

          todos = vm['todos'];

          switch(vm['indexTab']) {
            case 0: {
              asset = "assets/svg/check_boxes.svg";
              description = "Tap add button to create todo.";
              for (var element in todos) {
                finalTodos.add(element);
              }

            } break;
            case 1: {
              asset = "assets/svg/done.svg";
              description = "No completed todo yet.";
              for (var element in todos) {
                if(element.status == TodoStatus.Complete) finalTodos.add(element);
              }
            } break;
            case 2: {
              asset = "assets/svg/working.svg";
              description = "No incomplete todo yet.";
              for (var element in todos) {
                if(element.status == TodoStatus.Incomplete) finalTodos.add(element);
              }
            } break;
          }

          return finalTodos.isNotEmpty
              ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: finalTodos.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration (
                      color: kColor1,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: CheckboxListTile(
                    activeColor: kColor3,
                    value: finalTodos[index].status == TodoStatus.Complete,
                    onChanged: (value) {
                      if(value) {
                        debugPrint("Value: $value");
                        store.dispatch(SetCompleteAction(todo: todos[index]));
                      }else{
                        debugPrint("Value: $value");
                        store.dispatch(SetIncompleteAction(todo: todos[index]));
                      }
                      setState(() {
                        rebuild++;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(finalTodos[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 10);
              },
            ),
          ) : Center(
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.safeBlockVertical * 15
              ),
              child: EmptySignage(
                asset: asset,
                description: description,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: StoreConnector<AppState, dynamic>(
        converter: (store) => store.state.homeState.indexTab,
        builder: (context, vm) {
          return BottomNavigationBar(
            currentIndex: vm,
            onTap: (index) => store.dispatch(UpdateTabIndexAction(index: index)),
            backgroundColor: kColor2,
            selectedItemColor: kColor3,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  label: 'All',
                  icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                  label: 'Complete',
                  icon: Icon(Icons.check)

              ),
              BottomNavigationBarItem(
                  label: 'Incomplete',
                  icon: Icon(Icons.cancel)
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildInputs(Store<AppState> store) {
    return CupertinoAlertDialog(
      title: const Text("Create new todo"),
      content: Form(
        key: _formKey,
        child: CupertinoTextFormFieldRow(
          validator: InputValidator.validate,
          controller: controller,
          padding: const EdgeInsets.all(10),
          placeholder: "Todo title",
          style: const TextStyle(color: Colors.black54),
          decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            border: Border.all(
                color: CupertinoColors.lightBackgroundGray,
                width: 2
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      actions: [
        CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
            child: const Text("Save"),
            onPressed: () {
              if(_formKey.currentState.validate()) {
                int index;
                if(store.state.todoState.todos.isEmpty) {
                  index = 0;
                } else {
                  index = store.state.todoState.todos.length + 0;
                }
                Todo todo = Todo(
                    index: index,
                    title: controller.text,
                    status: TodoStatus.Incomplete
                );
                store.dispatch(AddTodoAction(todo: todo));
                controller.clear();
                Navigator.pop(context);
              }
            }
        )
      ],
    );
  }
}