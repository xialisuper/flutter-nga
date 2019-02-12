import 'package:cached_network_image/cached_network_image.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nga/ui/content/content_details.dart';
import 'package:flutter_nga/ui/widget/collapse_widget.dart';
import 'package:flutter_nga/utils/constant.dart';
import 'package:flutter_nga/utils/dimen.dart';
import 'package:flutter_nga/utils/palette.dart';
import 'package:html/dom.dart' as dom;

ngaRenderer() {
  return (dom.Node node, List<Widget> children) {
    if (node is dom.Element) {
      switch (node.localName) {
        case "td":
          int colSpan = 1;
          if (node.attributes['colspan'] != null) {
            colSpan = int.tryParse(node.attributes['colspan']);
          }
          // TODO: 因为可能会展示不全，所以需要添加点击事件跳转页面显示全部内容
          return Expanded(
            flex: colSpan,
            child: Material(
              color: Palette.colorBackground,
              child: Builder(
                builder: (context) => InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ContentDetailsPage(children))),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Palette.colorDivider),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(children: children),
                        ),
                      ),
                    ),
              ),
            ),
          );
        case "tr":
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Palette.colorDivider),
              ),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: children,
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          );
        case "table":
          return Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: Palette.colorDivider),
                top: BorderSide(color: Palette.colorDivider),
              ),
            ),
            child: Column(
              children: children,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        case "li":
          String type = node.parent.localName; // Parent type; usually ol or ul
          const EdgeInsets markPadding = EdgeInsets.only(right: 8.0);
          if (type == "ul") {
            IconData iconData;
            if (node.parent.localName == "ul" &&
                (node.parent.parent.localName != "ul" ||
                    node.parent.parent == null)) {
              // 一层
              iconData = CommunityMaterialIcons.circle;
            } else if (node.parent.parent.localName == "ul" &&
                (node.parent.parent.parent.localName != "ul" ||
                    node.parent.parent.parent == null)) {
              // 两层
              iconData = CommunityMaterialIcons.circle_outline;
            } else if (node.parent.parent.parent.localName == "ul" &&
                (node.parent.parent.parent.parent.localName != "ul" ||
                    node.parent.parent.parent.parent == null)) {
              // 三层最多了
              iconData = CommunityMaterialIcons.square;
            }
            Widget mark =
                Padding(child: Icon(iconData, size: 6), padding: markPadding);
            List<Widget> widgets = [];
            widgets.add(mark);
            widgets.addAll(children);
            return Container(
              width: double.infinity,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: widgets,
              ),
            );
          }
          break;
        // 列表要有层进
        case "ul":
          return Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              children: children,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          );
        // 标题
        case "h3":
          return DefaultTextStyle.merge(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(children: children),
                  Divider(height: 1),
                ],
              ),
            ),
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          );
          break;
        // 对齐
        case "div":
          if (node.attributes['align'] != null) {
            final align = node.attributes['align'];
            var alignment = WrapAlignment.start;
            if (align == "left") {
              alignment = WrapAlignment.start;
            } else if (align == "right") {
              alignment = WrapAlignment.end;
            } else if (align == "center") {
              alignment = WrapAlignment.center;
            }
            return Container(
              width: double.infinity,
              child: Wrap(
                children: children,
                alignment: alignment,
              ),
            );
          }
          break;
        // 字体大小
        case "span":
          if (node.attributes['font-size'] != null) {
            final fontSize = node.attributes['font-size'];
            if (fontSize.endsWith("%")) {
              final multiple =
                  int.parse(fontSize.substring(0, fontSize.length - 1)) / 100;
              return DefaultTextStyle.merge(
                child: Wrap(children: children),
                style: TextStyle(fontSize: Dimen.body * multiple),
              );
            }
          }
          break;
        // 字体颜色
        case "font":
          if (node.attributes['color'] != null) {
            String color = node.attributes['color'];
            return DefaultTextStyle.merge(
              child: Wrap(children: children),
              style: TextStyle(
                color: TEXT_COLOR_MAP[color],
                decorationColor: TEXT_COLOR_MAP[color],
              ),
            );
          } else {
            return DefaultTextStyle.merge(child: Wrap(children: children));
          }
          break;
        // 收起展开
        case "collapse":
          if (node.attributes['title'] != null) {
            return CollapseWidget.fromNodes(
              title: node.attributes['title'],
              children: children,
            );
          } else {
            return CollapseWidget.fromNodes(children: children);
          }
          break;
        // 图片
        case "img":
          if (node.attributes['src'] != null) {
            return CachedNetworkImage(imageUrl: node.attributes['src']);
          } else if (node.attributes['alt'] != null) {
            //Temp fix for https://github.com/flutter/flutter/issues/736
            if (node.attributes['alt'].endsWith(" ")) {
              return Container(
                  padding: EdgeInsets.only(right: 2.0),
                  child: Text(node.attributes['alt']));
            } else {
              return Text(node.attributes['alt']);
            }
          }
          return Container();
        // 引用
        case "blockquote":
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Palette.colorQuoteBackground,
              border: Border.all(color: Palette.colorDivider),
            ),
            child: Wrap(
              // TODO: 在 WrapCrossAlignment 有 baseline 之后需要替换为 baseline
              crossAxisAlignment: WrapCrossAlignment.center,
              children: children,
            ),
          );
        // 相册
        case "album":
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Palette.colorAlbumBackground,
              border: Border.all(color: Palette.colorAlbumBorder),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: children,
            ),
          );
          break;
      }
    }
    return null;
  };
}
