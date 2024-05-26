
import 'package:nuritopia2d/app/models/parents/model.dart';

class VoteBottomAvatarModel extends Model {
  String? image;
  bool? isSelected;
  Function()? ontap;

  VoteBottomAvatarModel(
      {this.image, this.isSelected,this.ontap});

  VoteBottomAvatarModel.fromJson(Map<String, dynamic> json) {
    image = this.stringFromJson(json, 'image');
    isSelected = this.boolFromJson(json, 'isSubtitle');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image == null ? null : this.image;
    data['isExpanded'] =
    this.isSelected == null ? null : this.isSelected;
    return data;
  }
}
