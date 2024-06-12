import 'package:flutter/material.dart';

PreferredSizeWidget AppBarView({
  required String title,
  bool centerTitle = true,
  List<Widget>? actions,
  Widget? leading,
  Widget? flexibleSpace,
  PreferredSizeWidget? bottom,
  double? elevation,
  Color? shadowColor,
  ShapeBorder? shape,
  Color? backgroundColor,
  bool? showLeading,
}) {
  return AppBar(
    title: Text(title),
    centerTitle: centerTitle,
    actions: actions,
    leading: leading,
    flexibleSpace: flexibleSpace,
    bottom: bottom,
    elevation: elevation,
    shadowColor: shadowColor,
    shape: shape,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: showLeading ?? true,
  );
}
