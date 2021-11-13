import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';

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
        String asset;
        String description;

        List<Todo> todos = [];
        List<Todo> finalTodos = [];


        todos = vm['todos'];

        switch(vm['indexTab']) {
          case 0 : {
            finalTodos = todos;
            asset = "assets/svg/check_boxes.svg";
            description = "Tap add button to create todo.";
          }
          break;
          case 1 :{
              finalTodos = todos.where((element) => element.status == TodoStatus.Complete).toList();
              asset = "assets/svg/done.svg";
              description = "No completed todo yet.";
            }
            break;
          case 2 : {
            finalTodos = todos.where((element) => element.status == TodoStatus.Incomplete).toList();
            asset = "assets/svg/working.svg";
            description = "No incomplete todo yet.";
          }
        }

        return finalTodos.isNotEmpty
            ? Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration (
                    color: kColor1,
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
