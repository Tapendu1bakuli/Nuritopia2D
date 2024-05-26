import 'package:nuritopia2d/app/models/parents/model.dart';

class CarousalImageModel extends Model {
  String? title;
  String? subtitleLarge;
  String? subtitleMid;
  String? image;
  Function()? ontap;

  CarousalImageModel({
    this.title,
    this.subtitleLarge,
    this.subtitleMid,
    this.image,
    this.ontap
  });

  CarousalImageModel.fromJson(Map<String, dynamic> json) {
    title = this.stringFromJson(json, 'title');
    subtitleLarge = this.stringFromJson(json, 'subtitleLarge');
    subtitleMid = this.stringFromJson(json, 'subtitleMid');
    image = this.stringFromJson(json, 'image');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title == null ? null : this.title;
    data['subtitleLarge'] = this.subtitleLarge == null ? null : this.subtitleLarge;
    data['subtitleMid'] = this.subtitleMid == null ? null : this.subtitleMid;
    data['image'] = this.image == null ? null : this.image;
    return data;
  }
}