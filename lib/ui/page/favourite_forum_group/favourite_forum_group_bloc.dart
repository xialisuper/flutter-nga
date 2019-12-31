import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_nga/data/data.dart';
import 'package:flutter_nga/ui/page/favourite_forum_group/favourite_forum_group_event.dart';
import 'package:flutter_nga/ui/page/favourite_forum_group/favourite_forum_group_state.dart';

class FavouriteForumGroupBloc
    extends Bloc<FavouriteChangedEvent, FavouriteForumGroupState> {
  onChanged() {
    add(FavouriteChangedEvent());
  }

  @override
  FavouriteForumGroupState get initialState =>
      FavouriteForumGroupState.initial();

  @override
  Stream<FavouriteForumGroupState> mapEventToState(
      FavouriteChangedEvent event) async* {
    final favouriteForumList = await Data().forumRepository.getFavouriteList();
    yield FavouriteForumGroupState(favouriteForumList);
  }
}
