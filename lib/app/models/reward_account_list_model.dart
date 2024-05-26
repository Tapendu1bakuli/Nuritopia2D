
import 'package:nuritopia2d/app/models/parents/model.dart';

class RewardAccountListModel extends Model {
  String? image;
  String? title;
  String? subtitle;
  String? hintText;
  bool? isExpanded;
  bool? isSubtitle;
  Function()? ontap;

  RewardAccountListModel(
      {this.image, this.title, this.subtitle,this.isExpanded,this.isSubtitle,this.hintText, this.ontap});

  RewardAccountListModel.fromJson(Map<String, dynamic> json) {
    image = this.stringFromJson(json, 'image');
    title = this.stringFromJson(json, 'title');
    subtitle = this.stringFromJson(json, 'subtitle');
    isExpanded = this.boolFromJson(json, 'isExpanded');
    isSubtitle = this.boolFromJson(json, 'isSubtitle');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image == null ? null : this.image;
    data['title'] = this.title == null ? null : this.title;
    data['subtitle'] = this.subtitle == null ? null : this.subtitle;
    data['isExpanded'] =
    this.isExpanded == null ? null : this.isExpanded;
    data['isSubtitle'] =
    this.isSubtitle == null ? null : this.isSubtitle;
    return data;
  }
}
