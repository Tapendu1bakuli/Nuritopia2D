import 'package:nuritopia2d/app/models/parents/model.dart';

class DrawerListWidgetModel extends Model {
  String? title;
  String? icon;
  bool? isColoured;
  Function()? ontap;

  DrawerListWidgetModel(
      {this.title, this.icon,  this.ontap, this.isColoured});

  DrawerListWidgetModel.fromJson(Map<String, dynamic> json) {
    title = this.stringFromJson(json, 'title');
    icon = this.stringFromJson(json, 'icon');
    isColoured = this.boolFromJson(json, 'isColoured');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title == null ? null : this.title;
    data['secondTitle'] =
    this.icon == null ? null : this.icon;
    return data;
  }
}
