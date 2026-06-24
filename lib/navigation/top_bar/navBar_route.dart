import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/navigation/top_bar/navBar_style.dart';
import 'package:portfolio/style/font_style.dart';
import 'package:portfolio/style/icon_style.dart';

class NavbarRoute extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback globalKeyHome;
  final VoidCallback globalKeySkill;
  final VoidCallback globalKeyProject;

  const NavbarRoute({
    super.key,
    required this.globalKeyHome,
    required this.globalKeyProject,
    required this.globalKeySkill,
  });

  @override
  State<NavbarRoute> createState() => _NavbarRouteState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NavbarRouteState extends State<NavbarRoute> {
  RxBool isMenuOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return AppBar(
      backgroundColor: Colors.black,
      forceMaterialTransparency: true,
      surfaceTintColor: Colors.black,
      shadowColor: Colors.black,
      centerTitle: true,
      toolbarHeight: 150,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Container(
        padding: EdgeInsets.all(isMobile ? 0 : 20),
        // color: Colors.amber,
        child: ClipRRect(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Al  Javir_.',
                  style: Fontstyle.topBarFont(
                    isMobile ? 22 : 28,
                  ).copyWith(height: 1.0),
                ),
              ),

              if (!isMobile)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    NavbarStyle(
                      routeName: 'Home',
                      path: widget.globalKeyHome,
                      num: 1,
                      showTopBar: true,
                    ),
                    NavbarStyle(
                      routeName: 'Skill',
                      path: widget.globalKeySkill,
                      num: 2,
                      showTopBar: true,
                    ),
                    NavbarStyle(
                      routeName: 'Project',
                      path: widget.globalKeyProject,
                      num: 3,
                      showTopBar: true,
                    ),
                    NavbarStyle(
                      routeName: 'Contract',
                      path: widget.globalKeyHome,
                      num: 4,
                      showTopBar: true,
                    ),
                  ],
                ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isMobile)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: menuButton(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuButton() {
    return Obx(
      () => IconButton(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,

        highlightColor: Colors.transparent,
        onPressed: () {
          isMenuOpen.value = !isMenuOpen.value;
          showMenu();
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: SizedBox(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: SvgPicture.asset(
              isMenuOpen.value ? IconStyle.menuClose() : IconStyle.menuOpen(),
              key: ValueKey(isMenuOpen.value),
              width: 30,
              height: 30,
              colorFilter: ColorFilter.mode(
                Theme.of(Get.context!).iconTheme.color!,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavbarStyle(
                routeName: 'Home',
                path: widget.globalKeyHome,
                num: 1,
                showTopBar: false,
              ),
              NavbarStyle(
                routeName: 'Skill',
                path: widget.globalKeySkill,
                num: 2,
                showTopBar: false,
              ),
              NavbarStyle(
                routeName: 'Project',
                path: widget.globalKeyProject,
                num: 3,
                showTopBar: false,
              ),

              NavbarStyle(
                routeName: 'Contract',
                path: widget.globalKeyHome,
                num: 4,
                showTopBar: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
