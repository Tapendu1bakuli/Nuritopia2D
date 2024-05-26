class ReceivedNotificationModel {
  ReceivedNotificationModel({
     this.notificationFor,
     this.id,
     this.notifiedBy,
     this.notificationText,
     this.notificationType,
     this.notificationTitle,
     this.appointmentId,
     this.notificationSound,
  });
   var notificationFor;
   var id;
   var notifiedBy;
   String? notificationText;
   String? notificationType;
   String? notificationTitle;
   var appointmentId;
   NotificationSound? notificationSound;

  ReceivedNotificationModel.fromJson(Map<String, dynamic> json){
    notificationFor = json['notificationFor'];
    id = json['id'];
    notifiedBy = json['notifiedBy'];
    notificationText = json['notificationText'];
    notificationType = json['notificationType'];
    notificationTitle = json['notificationTitle'];
    appointmentId = json['appointmentId'];
    //notificationSound = json['notificationSound'] == null ? NotificationSound() : NotificationSound.fromJson(json['notificationSound']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['notificationFor'] = notificationFor;
    _data['id'] = id;
    _data['notifiedBy'] = notifiedBy;
    _data['notificationText'] = notificationText;
    _data['notificationType'] = notificationType;
    _data['notificationTitle'] = notificationTitle;
    _data['appointmentId'] = appointmentId;
    _data['notificationSound'] = notificationSound?.toJson();
    return _data;
  }
}

class NotificationSound {
  NotificationSound({
     this.flag,
    this.customSound,
    this.defaultSound,
     this.notificationPriority,
  });
   String? flag;
   Null customSound;
   Null defaultSound;
   var notificationPriority;

  NotificationSound.fromJson(Map<String, dynamic> json){
    flag = json['flag'];
    // customSound = null;
    // defaultSound = null;
    notificationPriority = json['notificationPriority'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['flag'] = flag;
    _data['customSound'] = customSound;
    _data['defaultSound'] = defaultSound;
    _data['notificationPriority'] = notificationPriority;
    return _data;
  }
}