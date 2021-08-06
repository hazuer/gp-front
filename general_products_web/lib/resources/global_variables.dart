import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';

class RxVariables{
  
  static LoginResponse loginResponse = LoginResponse();
  static List<Plant> plantsAvailables = [];
  static List<Customer> customerAvailables = [];
  static String errorMessage="";
  
        
  

  //STREAMS

  //final listWorkZonesSelected = BehaviorSubject<List<WorkZone>>();
  //Stream<List<WorkZone>> get listWorkZonesSelectedStream => listWorkZonesSelected.stream;

 


  static final RxVariables _bloc = new RxVariables._internal();

  factory RxVariables() {
    return _bloc;
  }

  RxVariables._internal();

  void dispose(){
    //listWorkZonesSelected?.close();
  }
}
final rxVariables = RxVariables();
