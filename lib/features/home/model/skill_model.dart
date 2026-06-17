class SkillRowModel {
  final Map<String, dynamic> data;

  SkillRowModel({required this.data});

  factory SkillRowModel.fromJson(Map<String, dynamic> data) =>
      SkillRowModel(data: data['data'] ?? {});
}

class skillModelHome {
  final String name;
  final String image;
  final String text;
  final int num;
  skillModelHome({
    required this.name,
    required this.image,
    required this.text,
    required this.num,
  });
}
