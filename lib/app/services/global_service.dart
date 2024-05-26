import 'package:get/get.dart';

import '../../common/helper.dart';
import '../models/global_model.dart';

class GlobalService extends GetxService {
  final global = Global().obs;

  Future<GlobalService> init() async {
    var response = await Helper.getJsonFile('config/global.json');
    global.value = Global.fromJson(response);
    return this;
  }

  String get baseUrl => global.value.laravelBaseUrl!;
  String get iosAppLink => Helper.toUrl(global.value.iosAppLink!);
  String get androidAppLink => Helper.toUrl(global.value.androidAppLink!);
}
