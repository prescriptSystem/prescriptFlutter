import 'package:get_it/get_it.dart';
import 'package:prescript/controller/autenthicationService.dart';
import 'package:prescript/controller/medicineService.dart';

void injector() {
  var i = GetIt.instance;

  i.registerFactory(() => MedicineService());

  i.registerFactory(() => AuthenticationService());
}
