import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'src/redux/app_state.dart';
import 'src/redux/store.dart';
import 'src/screens/home/home_screen.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await createStore();
  runApp(TodoApp(store: store,));
}

class TodoApp extends StatelessWidget {
  final Store<AppState> store;

  const TodoApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}


