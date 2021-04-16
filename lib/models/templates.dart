class Template {
  String image;
  String name;
  String description;

  Template({this.image,this.name, this.description});

  factory Template.fromJson(Map<String, dynamic> json){
    return Template(
      image: json['image'],
      name: json['name'],
      description: json['description']
    );
  }
}

class TemplateFile{
  List<Template> templates;
  TemplateFile({this.templates});

  factory TemplateFile.fromJson(Map<String, dynamic> json){
    var list = json['templates'] as List;
    List<Template> templatesList = list.map((templates) => Template.fromJson(templates)).toList();
    return TemplateFile(
      templates: templatesList
    );
  }
}
