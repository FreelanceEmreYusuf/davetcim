import 'package:davetcim/shared/sessions/application_session.dart';

class HomeModel {

  String getUserName() {
    if (ApplicationSession.userSession != null) {
      return ApplicationSession.userSession.username;
    }
    return "";
  }

}