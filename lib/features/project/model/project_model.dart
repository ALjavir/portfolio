class ProjectRowModel {
  final String name;
  final String subName;
  final String description;
  final String thumbImage;
  final Map<String, dynamic> tech;
  final Map<String, dynamic> pageImage;
  final String video;
  ProjectRowModel({
    required this.name,
    required this.description,
    required this.tech,
    required this.pageImage,
    required this.video,
    required this.subName,
    required this.thumbImage,
  });
  factory ProjectRowModel.fromJson(Map<String, dynamic> data) =>
      ProjectRowModel(
        name: data["name"] ?? "",
        description: data["description"] ?? "",
        thumbImage: data["thumbImage"] ?? "",
        tech: data["tech"] ?? {},
        pageImage: data["page"] ?? {},
        video: data["video"] ?? "",
        subName: data["subName"] ?? "",
      );
}

class ProjectModel {
  final List<ProjectRowModel> projectRowModel;
  ProjectModel({required this.projectRowModel});
}

class Page {
  final String pageName;
  final String image;
  final String text;

  Page({required this.pageName, required this.image, required this.text});

  factory Page.fromJson(String name, Map<String, dynamic> json) {
    return Page(
      pageName: name,
      image: json["image"] ?? "",
      text: json["text"] ?? "",
    );
  }
}
