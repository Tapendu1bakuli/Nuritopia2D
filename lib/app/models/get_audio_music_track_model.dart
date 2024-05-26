class GetAudioMusicTrackModel {
  String? status;
  GetMusicTrackData? getMusicTrackData;

  GetAudioMusicTrackModel({this.status, this.getMusicTrackData});

  GetAudioMusicTrackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    getMusicTrackData = json['getMusicTrackData'] != null
        ? new GetMusicTrackData.fromJson(json['getMusicTrackData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.getMusicTrackData != null) {
      data['getMusicTrackData'] = this.getMusicTrackData!.toJson();
    }
    return data;
  }
}

class GetMusicTrackData {
  int? musicId;
  String? musicName;
  String? musicPath;
  String? musicCreatedAt;
  String? videoCreatedAt;
  int? videoType;
  String? videoUrl;
  String? youtubeChannelLink;
  String? message;

  GetMusicTrackData(
      {this.musicId,
        this.musicName,
        this.musicPath,
        this.musicCreatedAt,
        this.videoCreatedAt,
        this.videoType,
        this.videoUrl,
        this.youtubeChannelLink,
        this.message});

  GetMusicTrackData.fromJson(Map<String, dynamic> json) {
    musicId = json['musicId'];
    musicName = json['musicName'];
    musicPath = json['musicPath'];
    musicCreatedAt = json['music_created_at'];
    videoCreatedAt = json['video_created_at'];
    videoType = json['videoType'];
    videoUrl = json['videoUrl'];
    youtubeChannelLink = json['youtubeChannelLink'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musicId'] = this.musicId;
    data['musicName'] = this.musicName;
    data['musicPath'] = this.musicPath;
    data['music_created_at'] = this.musicCreatedAt;
    data['video_created_at'] = this.videoCreatedAt;
    data['videoType'] = this.videoType;
    data['videoUrl'] = this.videoUrl;
    data['youtubeChannelLink'] = this.youtubeChannelLink;
    data['message'] = this.message;
    return data;
  }
}
