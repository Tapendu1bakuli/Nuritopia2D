class CheckWinnerModel {
  String? status;
  String? message;
  List<Data>? data;

  CheckWinnerModel({this.status, this.message, this.data});

  CheckWinnerModel.fromJson(Map<String, dynamic> json) {
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
  String? songName;
  String? thubnailImagePath;
  String? danceYoutubeLink;
  String? performerId;
  String? beatName;
  String? dataTime;

  Data(
      {this.songName,
        this.thubnailImagePath,
        this.danceYoutubeLink,
        this.performerId,
        this.beatName,
        this.dataTime});

  Data.fromJson(Map<String, dynamic> json) {
    songName = json['song_name'];
    thubnailImagePath = json['thubnailImagePath'];
    danceYoutubeLink = json['DanceYoutubeLink'];
    performerId = json['performerId'];
    beatName = json['beatName'];
    dataTime = json['dataTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['song_name'] = this.songName;
    data['thubnailImagePath'] = this.thubnailImagePath;
    data['DanceYoutubeLink'] = this.danceYoutubeLink;
    data['performerId'] = this.performerId;
    data['beatName'] = this.beatName;
    data['dataTime'] = this.dataTime;
    return data;
  }
}
