
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todo_app/src/redux/todo/todo_action.dart';

import '../../../redux/app_state.dart';
import '../../../model/todo.dart';
import '../../../utilities/size_config.dart';
import '../../../../constants.dart';
import 'empty_signage.dart';

class BodyComponent extends StatelessWidget {
  const BodyComponent({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    SizeConfig().init(context);

    return StoreConnector<AppState, Map<String,dynamic>>(
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

        List<Todo> completeTodos = [];
        List<Todo> inCompleteTodos = [];

        todos = vm['todos'];

        // for (var element in todos) {
        //   if(element.status == TodoStatus.Complete) {
        //     debugPrint("Complete todo: ${element.title}");
        //     completeTodos.add(element);
        //     debugPrint("Complete todo count: ${completeTodos.length}");
        //   }
        //   if(element.status == TodoStatus.Incomplete){
        //     debugPrint("Incomplete todo: ${element.title}");
        //     inCompleteTodos.add(element);
        //     debugPrint("Incomplete todo count: ${inCompleteTodos.length}");
        //   }
        // }

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
                child: ListTile(
                  onTap: () {
                    store.dispatch(SetCompleteAction(todo: todos[index]));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(finalTodos[index].title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(describeEnum(finalTodos[index].status),
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
    );
  }
}
