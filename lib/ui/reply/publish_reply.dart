import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nga/ui/widget/expression_group_tabs_widget.dart';
import 'package:flutter_nga/utils/palette.dart';
import 'package:image_picker/image_picker.dart';

class PublishReplyPage extends StatefulWidget {
  @override
  _PublishReplyState createState() => _PublishReplyState();
}

class _PublishReplyState extends State<PublishReplyPage> {
  final _bottomData = [
    CommunityMaterialIcons.emoticon,
    CommunityMaterialIcons.format_text,
    Icons.image,
    CommunityMaterialIcons.tag_multiple,
    CommunityMaterialIcons.keyboard
  ];

  bool _hasFocus = false;
  final _editFocusNode = FocusNode();
  final _emptyFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _editFocusNode.addListener(() => _hasFocus = _editFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("回帖"),
        actions: [
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => debugPrint("回帖"),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                children: [
                  TextField(
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "标题(可选)"),
                    keyboardType: TextInputType.text,
                  ),
                  Expanded(
                    child: TextField(
                      focusNode: _editFocusNode,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "回复内容",
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Palette.colorPrimary,
            height: kToolbarHeight,
            width: double.infinity,
            child: Row(children: _getBottomBarData()),
          ),
          Container(
            width: double.infinity,
            height: 240,
            child: ExpressionGroupTabsWidget(),
          )
        ],
      ),
    );
  }

  List<Widget> _getBottomBarData() {
    return _bottomData
        .asMap()
        .map((i, iconData) {
          return MapEntry(
            i,
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    height: kToolbarHeight,
                    child: Icon(
                      iconData,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () async {
                    if (iconData == CommunityMaterialIcons.emoticon) {
                    } else if (iconData == CommunityMaterialIcons.format_text) {
                    } else if (iconData == Icons.image) {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                    } else if (iconData ==
                        CommunityMaterialIcons.tag_multiple) {
                    } else if (iconData == CommunityMaterialIcons.keyboard) {
                      if (_hasFocus) {
                        FocusScope.of(context).requestFocus(_emptyFocusNode);
                      } else {
                        FocusScope.of(context).requestFocus(_editFocusNode);
                      }
                    }
                  },
                ),
              ),
            ),
          );
        })
        .values
        .toList();
  }
}
