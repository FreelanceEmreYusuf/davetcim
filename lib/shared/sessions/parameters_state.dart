import '../models/paramters_model.dart';

class ParametersState {
  static ParametersModel parametersModel;

  static bool isPresent() {
    return parametersModel != null;
  }

  static void set(ParametersModel parametersModelInput) {
    parametersModel = parametersModelInput;
  }

  static void setAsNull() {
    parametersModel = null;
  }
}