import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:portfolio/features/contract/page/contractPage_main.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';
import 'package:portfolio/features/home/page/home_page_main.dart';
import 'package:portfolio/features/project/controller/projectPage_controller.dart';
import 'package:portfolio/features/project/page/project_main.dart';
import 'package:portfolio/features/skill/page/skillPage_main.dart';
import 'package:portfolio/firebase_options.dart';
import 'package:portfolio/navigation/top_bar/navBar_route.dart';
import 'package:portfolio/theme/theme_mode_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(ThemeModeController(), permanent: true);
  Get.put(HomepageController(), permanent: true);

  ProjectpageController projectpageController = ProjectpageController();
  projectpageController.fecthProjectData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeModeController themeModeController =
      Get.find<ThemeModeController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,

      home: const mainPage(),
    );
  }
}

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final ScrollController scrollController = ScrollController();

  final homeKey = GlobalKey();
  final skillKey = GlobalKey();
  final projectKey = GlobalKey();
  final contactKey = GlobalKey();

  void scrollTo(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavbarRoute(
        globalKeyHome: () => scrollTo(homeKey),
        globalKeySkill: () => scrollTo(skillKey),
        globalKeyProject: () => scrollTo(projectKey),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              key: homeKey,
              height: MediaQuery.of(context).size.height,
              child: const HomePageMain(),
            ),
            Container(
              key: skillKey,
              height: MediaQuery.of(context).size.height * 2,
              child: const SkillpageMain(),
            ),

            Container(key: projectKey, child: const ProjectMain()),

            SizedBox(
              key: contactKey,
              height: MediaQuery.of(context).size.height,
              child: const ContractpageMain(),
            ),
          ],
        ),
      ),
    );
  }
}
