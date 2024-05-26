
import 'package:nuritopia2d/app/models/parents/model.dart';

class WinnerListModel extends Model {
  String? image;
  String? songName;
  String? beat;
  String? date;
  Function()? ontap;

  WinnerListModel(
      {this.image, this.songName, this.beat,this.date, this.ontap});

  WinnerListModel.fromJson(Map<String, dynamic> json) {
    image = this.stringFromJson(json, 'image');
    songName = this.stringFromJson(json, 'songName');
    date = this.stringFromJson(json, 'date');
    beat = this.stringFromJson(json, 'beat');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image == null ? null : this.image;
    data['date'] = this.date == null ? null : this.date;
    data['beat'] = this.beat == null ? null : this.beat;
    data['songName'] =
    this.songName == null ? null : this.songName;
    return data;
  }
}
