import 'package:redux/redux.dart';

import 'home_action.dart';
import 'home_state.dart';


final homeReducer = combineReducers<HomeState>([
  TypedReducer<HomeState, UpdateTabIndexAction>(_updateTabIndexAction),
]);

HomeState _updateTabIndexAction(HomeState state, UpdateTabIndexAction action) {
  return state.copyWith(indexTab: action.index);
}