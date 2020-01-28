import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nga/ui/page/user_info/user_info_page.dart';
import 'package:flutter_nga/utils/code_utils.dart' as codeUtils;
import 'package:flutter_nga/utils/route.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget(this.avatar, {this.size = 48, this.username, Key key})
      : super(key: key);

  final String avatar;
  final double size;
  final String username;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: codeUtils.isStringEmpty(username)
          ? _getAvatarImage()
          : Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () =>
                    Routes.navigateTo(context, "${Routes.USER}?name=$username"),
                child: _getAvatarImage(),
              ),
            ),
    );
  }

  Widget _getAvatarImage() {
    return avatar != null
        ? CachedNetworkImage(
            width: size,
            height: size,
            fit: BoxFit.cover,
            imageUrl: avatar,
            placeholder: (context, url) => Image.asset(
              'images/default_forum_icon.png',
              width: size,
              height: size,
            ),
            errorWidget: (context, url, err) => Image.asset(
              'images/default_forum_icon.png',
              width: size,
              height: size,
            ),
          )
        : Image.asset(
            'images/default_forum_icon.png',
            width: size,
            height: size,
          );
  }
}
