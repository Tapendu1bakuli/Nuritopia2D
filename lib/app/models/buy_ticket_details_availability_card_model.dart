
import 'package:nuritopia2d/app/models/parents/model.dart';

class BuyTicketDetailsAvailabilityCardModel extends Model {
  String? firstTitle;
  String? secondTitle;
  String? secondSubTitle;
  Function()? ontap;

  BuyTicketDetailsAvailabilityCardModel(
      {this.secondTitle, this.firstTitle, this.secondSubTitle, this.ontap});

  BuyTicketDetailsAvailabilityCardModel.fromJson(Map<String, dynamic> json) {
    firstTitle = this.stringFromJson(json, 'firstTitle');
    secondTitle = this.stringFromJson(json, 'secondTitle');
    secondSubTitle = this.stringFromJson(json, 'secondSubTitle');
    super.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstTitle'] = this.firstTitle == null ? null : this.firstTitle;
    data['secondTitle'] =
        this.secondTitle == null ? null : this.secondTitle;
    data['secondSubTitle'] = this.secondSubTitle == null ? null : this.secondSubTitle;
    return data;
  }
}
