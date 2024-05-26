class DanceVotingVideoModel {
  String? status;
  int? version;
  String? message;
  List<GetDanceVotingVideoData>? getDanceVotingVideoData;
  String? maxVote;

  DanceVotingVideoModel(
      {this.status,
        this.version,
        this.message,
        this.getDanceVotingVideoData,
        this.maxVote});

  DanceVotingVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    message = json['message'];
    if (json['getDanceVotingVideoData'] != null) {
      getDanceVotingVideoData = <GetDanceVotingVideoData>[];
      json['getDanceVotingVideoData'].forEach((v) {
        getDanceVotingVideoData!.add(new GetDanceVotingVideoData.fromJson(v));
      });
    }
    maxVote = json['max_vote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['message'] = this.message;
    if (this.getDanceVotingVideoData != null) {
      data['getDanceVotingVideoData'] =
          this.getDanceVotingVideoData!.map((v) => v.toJson()).toList();
    }
    data['max_vote'] = this.maxVote;
    return data;
  }
}

class GetDanceVotingVideoData {
  int? id;
  String? videoName;
  String? uniqueName;
  String? path;
  String? imageUniqueName;
  String? imagePath;
  String? beatName;
  String? stageName;
  int? votingScore;
  String? imageUniqueName3;
  String? performerNickName;
  String? performerEmail;
  String? nuritopiaProfileImage;
  int? tos;
  String? imagePathBanner;
  String? imageUniqueNameNanner;
  bool? isSelected;
  Function()? ontap;

  GetDanceVotingVideoData(
      {this.id,
        this.videoName,
        this.uniqueName,
        this.path,
        this.isSelected = true,
        this.ontap,
        this.imageUniqueName,
        this.imagePath,
        this.beatName,
        this.stageName,
        this.votingScore,
        this.imageUniqueName3,
        this.performerNickName,
        this.performerEmail,
        this.nuritopiaProfileImage,
        this.tos,
        this.imagePathBanner,
        this.imageUniqueNameNanner});

  GetDanceVotingVideoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoName = json['video_name'];
    uniqueName = json['uniqueName'];
    path = json['path'];
    imageUniqueName = json['image_uniqueName'];
    imagePath = json['image_path'];
    beatName = json['beat_name'];
    stageName = json['stage_name'];
    votingScore = json['voting_score'];
    imageUniqueName3 = json['image_uniqueName3'];
    performerNickName = json['performar_nuritopia_nickname'];
    performerEmail = json['performar_email'];
    nuritopiaProfileImage = json['image_file_nuritopia'];
    tos = json['tos'];
    imagePathBanner = json['image_path_banner'];
    imageUniqueNameNanner = json['image_uniqueName_nanner'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video_name'] = this.videoName;
    data['uniqueName'] = this.uniqueName;
    data['path'] = this.path;
    data['image_uniqueName'] = this.imageUniqueName;
    data['image_path'] = this.imagePath;
    data['beat_name'] = this.beatName;
    data['stage_name'] = this.stageName;
    data['voting_score'] = this.votingScore;
    data['image_uniqueName3'] = this.imageUniqueName3;
    data['performar_email'] = this.performerEmail;
    data['performar_nuritopia_nickname'] = this.performerNickName;
    data['image_file_nuritopia'] = this.nuritopiaProfileImage;
    data['tos'] = this.tos;
    data['image_path_banner'] = this.imagePathBanner;
    data['image_uniqueName_nanner'] = this.imageUniqueNameNanner;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
