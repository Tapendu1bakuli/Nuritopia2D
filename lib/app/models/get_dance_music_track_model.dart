class GetDanceMusicTrackModel {
  String? status;
  Data? data;
  String? message;

  GetDanceMusicTrackModel({this.status, this.data, this.message});

  GetDanceMusicTrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? musicId;
  String? musicName;
  String? musicPath;
  String? danceYoutubeLink;
  String? musicCreatedAt;
  String? videoCreatedAt;
  int? videoType;
  String? videoUrl;
  String? youtubeChannelLink;

  Data(
      {this.musicId,
        this.musicName,
        this.musicPath,
        this.danceYoutubeLink,
        this.musicCreatedAt,
        this.videoCreatedAt,
        this.videoType,
        this.videoUrl,
        this.youtubeChannelLink});

  Data.fromJson(Map<String, dynamic> json) {
    musicId = json['musicId'];
    musicName = json['musicName'];
    musicPath = json['musicPath'];
    danceYoutubeLink = json['DanceYoutubeLink'];
    musicCreatedAt = json['music_created_at'];
    videoCreatedAt = json['video_created_at'];
    videoType = json['videoType'];
    videoUrl = json['videoUrl'];
    youtubeChannelLink = json['youtubeChannelLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musicId'] = this.musicId;
    data['musicName'] = this.musicName;
    data['musicPath'] = this.musicPath;
    data['DanceYoutubeLink'] = this.danceYoutubeLink;
    data['music_created_at'] = this.musicCreatedAt;
    data['video_created_at'] = this.videoCreatedAt;
    data['videoType'] = this.videoType;
    data['videoUrl'] = this.videoUrl;
    data['youtubeChannelLink'] = this.youtubeChannelLink;
    return data;
  }
}
