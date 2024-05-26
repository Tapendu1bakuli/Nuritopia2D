import 'package:nuritopia2d/app/models/parents/model.dart';

class FilterListModel extends Model {
  String? title;

  Function()? ontap;

  FilterListModel(
      {this.title,  this.ontap, });

  FilterListModel.fromJson(Map<String, dynamic> json) {
    title = this.stringFromJson(json, 'title');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title == null ? null : this.title;
    return data;
  }
}

class Types {
  Types({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  Types.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    return _data;
  }
}
