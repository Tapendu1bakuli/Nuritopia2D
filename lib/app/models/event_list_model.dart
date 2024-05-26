class EventsModel {
  String? status;
  String? message;
  List<Data>? data;

  EventsModel({this.status, this.message, this.data});

  EventsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? eventStatus;
  String? thumbnailImage;
  String? eventName;
  String? eventPlace;
  String? dateTime;
  String? linkForTheEvent;

  Data(
      {this.eventStatus,
        this.thumbnailImage,
        this.eventName,
        this.eventPlace,
        this.dateTime,
        this.linkForTheEvent});

  Data.fromJson(Map<String, dynamic> json) {
    eventStatus = json['eventStatus'];
    thumbnailImage = json['thumbnailImage'];
    eventName = json['eventName'];
    eventPlace = json['eventPlace'];
    dateTime = json['date&time'];
    linkForTheEvent = json['linkForTheEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventStatus'] = this.eventStatus;
    data['thumbnailImage'] = this.thumbnailImage;
    data['eventName'] = this.eventName;
    data['eventPlace'] = this.eventPlace;
    data['date&time'] = this.dateTime;
    data['linkForTheEvent'] = this.linkForTheEvent;
    return data;
  }
}
