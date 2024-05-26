class WinnerDanceListModel {
  String? status;
  String? message;
  List<VotingVideoList>? votingVideoList;
  int? totalVideo;

  WinnerDanceListModel(
      {this.status, this.message, this.votingVideoList, this.totalVideo});

  WinnerDanceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['voting_video_list'] != null) {
      votingVideoList = <VotingVideoList>[];
      json['voting_video_list'].forEach((v) {
        votingVideoList!.add(new VotingVideoList.fromJson(v));
      });
    }
    totalVideo = json['total_video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.votingVideoList != null) {
      data['voting_video_list'] =
          this.votingVideoList!.map((v) => v.toJson()).toList();
    }
    data['total_video'] = this.totalVideo;
    return data;
  }
}

class VotingVideoList {
  int? id;
  String? beatName;
  String? stageName;
  String? uniqueName;
  String? path;
  String? createdAt;
  String? imageUniqueName;
  String? imagePath;
  String? performerEmail;
  String? performerNickName;
  int? videoType;
  int? tos;

  VotingVideoList(
      {this.id,
        this.beatName,
        this.stageName,
        this.uniqueName,
        this.path,
        this.createdAt,
        this.imageUniqueName,
        this.imagePath,
        this.performerEmail,
        this.performerNickName,
        this.videoType,
        this.tos});

  VotingVideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beatName = json['beat_name'];
    stageName = json['stage_name'];
    uniqueName = json['uniqueName'];
    path = json['path'];
    createdAt = json['created_at'];
    imageUniqueName = json['image_uniqueName'];
    imagePath = json['image_path'];
    performerEmail = json['performar_email'] ?? "Example";
    performerNickName = json['performar_nuritopia_nickname'] ?? "Example";
    videoType = json['video_type'];
    tos = json['tos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beat_name'] = this.beatName;
    data['stage_name'] = this.stageName;
    data['uniqueName'] = this.uniqueName;
    data['path'] = this.path;
    data['created_at'] = this.createdAt;
    data['image_uniqueName'] = this.imageUniqueName;
    data['image_path'] = this.imagePath;
    data['performar_email'] = this.performerEmail;
    data['performar_nuritopia_nickname'] = this.performerNickName;
    data['video_type'] = this.videoType;
    data['tos'] = this.tos;
    return data;
  }
}
