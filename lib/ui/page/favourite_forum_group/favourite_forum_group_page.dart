import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nga/ui/page/favourite_forum_group/favourite_forum_group.dart';
import 'package:flutter_nga/ui/page/forum/forum_grid_item_widget.dart';

class FavouriteForumGroupPage extends StatefulWidget {
  @override
  _FavouriteForumGroupState createState() => _FavouriteForumGroupState();
}

class _FavouriteForumGroupState extends State<FavouriteForumGroupPage> {
  final _bloc = FavouriteForumGroupBloc();

  @override
  void initState() {
    super.initState();
    _bloc.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: _FavouriteForumGroupWidget(),
      create: (context) => _bloc,
    );
  }

  @override
  void deactivate() {
    _bloc.onChanged();
    super.deactivate();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}

class _FavouriteForumGroupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = 96;
    final double itemWidth = size.width / 3;

    return BlocBuilder(
      bloc: BlocProvider.of<FavouriteForumGroupBloc>(context),
      builder: (context, FavouriteForumGroupState state) {
        return GridView.count(
          crossAxisCount: 3,
          childAspectRatio: itemWidth / itemHeight,
          children: state.forumList
              .map((forum) => ForumGridItemWidget(forum))
              .toList(),
        );
      },
    );
  }
}
