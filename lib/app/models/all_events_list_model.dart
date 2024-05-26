
import 'package:nuritopia2d/app/models/parents/model.dart';

class AllEventsListModel extends Model {
  String? image;
  String? month;
  String? date;
  String? eventName;
  String? day;
  String? time;
  String? place;
  bool? isSold;
  bool? isUpcoming;
  Function()? ontap;

  AllEventsListModel(
      {this.image,this.date,this.time,this.day,this.eventName,this.isSold,this.month,this.place, this.isUpcoming,this.ontap});

  AllEventsListModel.fromJson(Map<String, dynamic> json) {
    image = this.stringFromJson(json, 'image');
    date = this.stringFromJson(json, 'date');
    time = this.stringFromJson(json, 'time');
    day = this.stringFromJson(json, 'day');
    eventName = this.stringFromJson(json, 'eventName');
    isSold = this.boolFromJson(json, 'isSold');
    isUpcoming = this.boolFromJson(json, 'isUpcoming');
    month = this.stringFromJson(json, 'month');
    place = this.stringFromJson(json, 'place');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image == null ? null : this.image;
    data['date'] =
    this.date == null ? null : this.date;
    data['time'] = this.time == null ? null : this.time;
    data['eventName'] = this.eventName == null ? null : this.eventName;
    data['day'] = this.day == null ? null : this.day;
    data['isSold'] = this.isSold == null ? null : this.isSold;
    data['isSold'] = this.isUpcoming == null ? null : this.isUpcoming;
    data['month'] = this.month == null ? null : this.month;
    data['place'] = this.place == null ? null : this.place;
    return data;
  }
}
