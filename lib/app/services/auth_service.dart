import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import '../models/user_model.dart';
import 'settings_service.dart';

class AuthService extends GetxService {
  final user = Users().obs;
  // final oldUser = User().obs;
 late GetStorage _box;

  //late UserRepository _usersRepo;

  AuthService() {
   // _usersRepo = new UserRepository();
    _box = new GetStorage();
  }

  Future<AuthService> init() async {
    // user.listen((User _user) {
    //   if (Get.isRegistered<SettingsService>()) {
    //     Get.find<SettingsService>().address.value.userId = _user.id;
    //   }
    //   _box.write('current_user', _user.toJson());
    //   _box.write('current_old_user', _user.toJson());
    // });
    await getCurrentUser();
    return this;
  }

  Future getCurrentUser() async {
    // if (user.value.auth == null && _box.hasData('current_user')) {
    //   user.value = User.fromJson(await _box.read('current_user'));
    //   user.value.auth = true;
    // } else {
    //   user.value.auth = false;
    // }
  }

  Future getCurrentOldUser() async {
    // if (oldUser.value.auth == null && _box.hasData('current_old_user')) {
    //   oldUser.value = User.fromJson(await _box.read('current_old_user'));
    //   oldUser.value.auth = true;
    // } else {
    //   oldUser.value.auth = false;
    // }
    // return oldUser.value;
  }

  Future removeCurrentUser() async {
    // await _usersRepo.signOut(user.value).then((value) {
    //   if (value) user.value = User();
    //   return null;
    // });
    // await _box.remove('current_user');
  }

  Future removeCurrentOldUser() async {
    // await _usersRepo.signOut(user.value).then((value) {
    //   if (value) user.value = User();
    //   return null;
    // });
    // await _box.remove('current_old_user');
  }

 // bool get isAuth => user.value.auth ?? false;
  //
  //String? get apiToken => (user.value.auth ?? false) ? user.value.apiToken : '';
  // Salon? get salon => (user.value.salons?.isNotEmpty ?? false) ? user.value.salons?.first : Salon();
}
