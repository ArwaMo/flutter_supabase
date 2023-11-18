class Task {
  int? id;
  String? title;
  String? subTitle;
  bool? selected;

  Task({this.id, this.title, this.subTitle, this.selected});

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    selected = json['selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['selected'] = this.selected;
    return data;
  }
}