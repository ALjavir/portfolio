class SkillRowSuperModel {
  final Map<String, dynamic> data;
  final Map<String, dynamic> skillDetail;

  SkillRowSuperModel({required this.data, required this.skillDetail});

  factory SkillRowSuperModel.fromJson(Map<String, dynamic> data) =>
      SkillRowSuperModel(
        data: data['data'] ?? {},
        skillDetail: data['skillDetail'] ?? {},
      );
}

class SkillPageModel {
  final List<dynamic> tech;
  final String text;
  final double score;
  final int index;
  final String name;
  SkillPageModel({
    required this.tech,
    required this.text,
    required this.score,
    required this.index,
    required this.name,
  });

  factory SkillPageModel.fromJson(Map<String, dynamic> data) => SkillPageModel(
    tech: data['tech'] ?? [],
    text: data['text'] ?? '',
    index: data['index'] ?? 0,
    name: data['name'] ?? '',
    score: data['score'] ?? 0.0,
  );
}
