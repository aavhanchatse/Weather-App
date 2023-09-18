import 'package:get_storage/get_storage.dart';

class StorageManager {
  final box = GetStorage();

  String SPLASH = 'splash';
  String TOKEN = 'token';
  String USER_PROFILE_PHOTO = 'profile_image';
  String EMPLOYER_DATA = 'employer_data';
  String EMPLOYER_ID = 'employer_id';
  String CURRENT_PLAN_ID = 'current_plan_id';
  String NOTIFICATION_LIST = 'notification_list';

  void setInroScreenValue() {
    setData(SPLASH, true);
  }

  bool? getIntoScreenValue() {
    bool? value = getData(SPLASH);
    return value;
  }

  void setToken(String token) {
    setData(TOKEN, token);
  }

  String? getToken() {
    String token = getData(TOKEN);
    return token;
  }

  void setNotificationList(List<int> list) {
    setData(NOTIFICATION_LIST, list);
  }

  List? getNotificationList() {
    final list = getData(NOTIFICATION_LIST);

    return list;
  }

  // void setEmployerData(EmployerData employerData) {
  //   setData(EMPLOYER_DATA, employerData.toJson());
  //   setEmployerId(employerData.id!);
  // }

  // EmployerData? getEmployerData() {
  //   var data = getData(EMPLOYER_DATA);
  //   if (data != null) {
  //     return EmployerData.fromJson(data);
  //   } else {
  //     return null;
  //   }
  // }

  void setEmployerId(int id) {
    setData(EMPLOYER_ID, id);
  }

  int getEmployerId() {
    int id = getData(EMPLOYER_ID);
    return id;
  }

  void setCurrentPlanId(int id) {
    setData(CURRENT_PLAN_ID, id);
  }

  int getCurrentPlanId() {
    int id = getData(CURRENT_PLAN_ID);
    return id;
  }

  // --------- default functions ---------
  void setData(String key, dynamic value) {
    box.write(key, value);
    box.save();
  }

  dynamic getData(String key) {
    return box.read(key);
  }

  dynamic clearData() {
    box.erase();
  }

  void eraseStorage() async {
    await box.erase();
  }
}
