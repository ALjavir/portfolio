import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/features/home/model/skill_model.dart';

class HomepageController {
  late Future<List<skillModelHome>> logoData;

  // late List<skillModelHome> emptyList;
  //   late  List<skillModelHome> fullList;

  //   skillPagecont(){

  //   }

  HomepageController() {
    logoData = Future.delayed(
      const Duration(milliseconds: 1500),
      () => fetchSkillData(),
    );
  }

  Future<List<skillModelHome>> fetchSkillData() async {
    try {
      final skillDataPath = FirebaseFirestore.instance
          .collection('skill')
          .doc("main");

      final getResult = await skillDataPath.get();

      final finalResult = getResult.data();

      if (finalResult == null) {
        return [];
      }

      final getSkilData = SkillRowModel.fromJson(finalResult);

      final Map<String, dynamic> fullDataMap = getSkilData.data;
      //  print(fullDataMap.entries);
      final List<skillModelHome> fullList = [];

      for (var i in fullDataMap.entries) {
        final data = i.value as Map<String, dynamic>;

        final singleData = skillModelHome(
          name: i.key,
          image: data["image"],
          text: data["text"],
          num: data["num"],
        );

        fullList.add(singleData);
      }

      final skills = fullList;

      // 2. Precache all SVGs over the network
      await Future.wait(
        skills.map((skill) async {
          // Note: This syntax is for flutter_svg version 2.0.0 and newer
          final loader = SvgNetworkLoader(skill.image);
          await svg.cache.putIfAbsent(
            loader.cacheKey(null),
            () => loader.loadBytes(null),
          );
        }),
      );

      return fullList;
    } catch (e) {
      throw Exception('Failed to fetch skill data: $e');
    }
  }

  static String convertToDirectLink(String link) {
    final regex = RegExp(r'd/([^/]+)/');
    final altRegex = RegExp(r'id=([^&]+)');

    String? fileId;

    if (regex.hasMatch(link)) {
      fileId = regex.firstMatch(link)?.group(1);
    } else if (altRegex.hasMatch(link)) {
      fileId = altRegex.firstMatch(link)?.group(1);
    }

    if (fileId != null) {
      return 'https://drive.google.com/thumbnail?id=$fileId&sz=w1000';
    }

    return link;
  }
}
