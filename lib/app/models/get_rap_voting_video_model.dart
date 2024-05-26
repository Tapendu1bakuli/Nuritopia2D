class GetRapVotingVideoModel {
  String? status;
  int? version;
  String? message;
  List<VotingVideoList>? votingVideoList;
  String? maxVote;

  GetRapVotingVideoModel(
      {this.status,
        this.version,
        this.message,
        this.votingVideoList,
        this.maxVote});

  GetRapVotingVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    message = json['message'];
    if (json['voting_video_list'] != null) {
      votingVideoList = <VotingVideoList>[];
      json['voting_video_list'].forEach((v) {
        votingVideoList!.add(new VotingVideoList.fromJson(v));
      });
    }
    maxVote = json['max_vote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['message'] = this.message;
    if (this.votingVideoList != null) {
      data['voting_video_list'] =
          this.votingVideoList!.map((v) => v.toJson()).toList();
    }
    data['max_vote'] = this.maxVote;
    return data;
  }
}

class VotingVideoList {
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
  String? imageFileNuritopia;
  String? performarEmail;
  String? performarNuritopiaNickname;
  int? tos;
  String? imagePathBanner;
  String? imageUniqueNameNanner;
  bool? isSelected;
  Function()? ontap;

  VotingVideoList(
      {this.id,
        this.videoName,
        this.isSelected = true,
        this.ontap,
        this.uniqueName,
        this.path,
        this.imageUniqueName,
        this.imagePath,
        this.beatName,
        this.stageName,
        this.votingScore,
        this.imageUniqueName3,
        this.imageFileNuritopia,
        this.performarEmail,
        this.performarNuritopiaNickname,
        this.tos,
        this.imagePathBanner,
        this.imageUniqueNameNanner});

  VotingVideoList.fromJson(Map<String, dynamic> json) {
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
    imageFileNuritopia = json['image_file_nuritopia'];
    performarEmail = json['performar_email'];
    performarNuritopiaNickname = json['performar_nuritopia_nickname'];
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
    data['image_file_nuritopia'] = this.imageFileNuritopia;
    data['performar_email'] = this.performarEmail;
    data['performar_nuritopia_nickname'] = this.performarNuritopiaNickname;
    data['tos'] = this.tos;
    data['image_path_banner'] = this.imagePathBanner;
    data['image_uniqueName_nanner'] = this.imageUniqueNameNanner;
    data['isSelected'] = this.isSelected;
    return data;
  }
}
