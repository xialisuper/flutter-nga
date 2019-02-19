import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nga/ui/user/user_info.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(this.avatar, {this.size = 48, this.username, Key key})
      : super(key: key);

  final String avatar;
  final double size;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => UserInfoPage(username))),
        child: avatar != null
            ? CachedNetworkImage(
                width: size,
                height: size,
                fit: BoxFit.cover,
                imageUrl: avatar,
                placeholder: Image.asset(
                  'images/default_forum_icon.png',
                  width: size,
                  height: size,
                ),
                errorWidget: Image.asset(
                  'images/default_forum_icon.png',
                  width: size,
                  height: size,
                ),
              )
            : Image.asset(
                'images/default_forum_icon.png',
                width: size,
                height: size,
              ),
      ),
    ));
  }
}
