import 'package:get/get.dart';
import 'package:portfolio/features/home/controller/homePage_controller.dart';
import 'package:portfolio/features/skill/model/skill_model.dart';

class SkillpageController extends GetxController {
  final HomepageController homepageController = Get.find<HomepageController>();

  final skillPageList = <SkillPageModel>[].obs;
  final isLoading = true.obs;

  Future<void> getSkillpageData() async {
    await homepageController.logoData;
    final data = homepageController.skillPageData;

    print("From contoller ------------------------");
    //print(homepageController.skillPageData);
    final List<SkillPageModel> fullList = [];

    for (var i in data!.entries) {
      final data = i.value as Map<String, dynamic>;

      final singleData = SkillPageModel.fromJson(data);

      fullList.add(singleData);

      fullList.sort((a, b) => a.index.compareTo(b.index));

      skillPageList.value = fullList;
    }
    print(skillPageList);
  }
}
