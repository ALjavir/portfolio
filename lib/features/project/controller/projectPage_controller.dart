import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portfolio/features/project/model/project_model.dart';

class ProjectpageController {
  Future<List<ProjectRowModel>> fecthProjectData() async {
    try {
      final projectDataPath = FirebaseFirestore.instance.collection('project');

      final getResult = await projectDataPath.get();

      final List<ProjectRowModel> finalResult = [];
      for (var doc in getResult.docs) {
        finalResult.add(ProjectRowModel.fromJson(doc.data()));
      }
      return finalResult;
    } catch (e) {
      throw Exception('Failed to fetch project data: $e');
    }
  }
}
