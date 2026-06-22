import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/style/color_style.dart';
import 'package:portfolio/style/font_style.dart';

class NavbarStyle extends StatefulWidget {
  final String routeName;
  final VoidCallback path;
  final int num;
  final bool showTopBar;
  const NavbarStyle({
    super.key,
    required this.routeName,
    required this.path,
    required this.num,
    required this.showTopBar,
  });

  @override
  State<NavbarStyle> createState() => _NavbarStyleState();
}

class _NavbarStyleState extends State<NavbarStyle> {
  RxBool isHovering = false.obs;
  RxBool isActive = false.obs;
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.onSurface;
    final hoverColor = Colors.red;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,

      highlightColor: Colors.transparent,

      onHover: (value) {
        isHovering.value = value;
      },
      onTap: () {
        isActive.value = true;
        Future.delayed(Duration(milliseconds: 150), () => Get.back());
        widget.path();
      },
      child: Obx(
        () => widget.showTopBar
            ? forTopBar(activeColor, hoverColor)
            : forBottomBar(activeColor, hoverColor),
      ),
    );
  }

  Widget forTopBar(Color activeColor, Color hoverColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          widget.num.toString().padLeft(2, '0'),
          style: Fontstyle.navBarFont(
            18,
            isHovering.value ? hoverColor : activeColor.withAlpha(150),
            FontWeight.bold,
          ),
        ),
        Text(
          "// ${widget.routeName}",
          style: Fontstyle.navBarFont(
            22,
            isHovering.value ? hoverColor : activeColor,
            FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget forBottomBar(Color activeColor, Color hoverColor) {
    return Row(
      spacing: 10,
      children: [
        Text(
          widget.num.toString().padLeft(2, '0'),
          style: Fontstyle.navBarFont(
            22,
            isActive.value ? hoverColor : activeColor,
            FontWeight.bold,
          ),
        ),
        Text(
          "// ${widget.routeName}",
          style: Fontstyle.navBarFont(
            22,
            isActive.value ? hoverColor : activeColor,
            FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
