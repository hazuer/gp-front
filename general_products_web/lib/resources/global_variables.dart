import 'package:general_products_web/models/customer_model.dart';
import 'package:general_products_web/models/login_response.dart';
import 'package:general_products_web/models/plant_model.dart';

class RxVariables{
  
  static LoginResponse loginResponse = LoginResponse();
  static List<Plant> plantsAvailables = [];
  static List<Customer> customerAvailables = [];
  static String errorMessage="";
  static String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiZDFiMzIxYTA1ZWVkZTg0ZGU5MTg1OTgyMTA0ZmY5MGI3ZmZlODlkYTM2MDQxNWMxOTkxMzM1ZDNhY2FmNjAwZDVjMjA5OGJlMTk2ZjljNjYiLCJpYXQiOjE2Mjg3MDcxOTIsIm5iZiI6MTYyODcwNzE5MiwiZXhwIjoxNjI4NzkzNTkyLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.sSsX9G_nIg8uG35qQlXfM2V4Kh5n0-E2irtH7PmFEj7jVjeXz__WALXCBivBZyK9oIHfEEi8bQrOlvAtS0a4yNkE1EXm4IGfTEA_NCPlaYBI-pRzGL2wvMP4LkTmo62rDvGRWQhcGwZQTGeCgvr4wG-gtpf-pf6YY64Wqvr8llUmfOnFPYJhDU0TK6G9_QvVZImKhNZfiZukjbgq-07NZQMY4_5bb6qDxdkIUz1hEBPeHzdI3-fdRS39leeBwIR8XVYYfQ4LKwzUCYsrgMrNJTuOtueDgpPUUjTtUJJltR9cnhVTaHLgsvC60u79C4QAg9-Pes_2J8NJ_5k4Ev_GdKbYJ8bRRRzGWYAtkW_dclGk7MICA9M9eI3atyZlIpyR6zpdMV81zBtFJ_HYLcCBLoQr6O4hwqwKKM74PBPK-VbHbJdbjJTsvKc0ymBQruNRikWghyaeLIb-D4VAKAtYc4F_giyoNH1TUt69uMHx1tdr_Pbw8O66Nl-mjIpXFoetAjJoog4lA9009dmLOV46JcWMajBxC7PAnREMxCH067o-VXnTeFSxf1O8FPiGhlJylqej6KENoFgNBLWkSAtXD-79dRx7yeqZGMn0UPkfSZLbcULmG5yOvrezh6TsYQnFE8cPHGbuUBiF0ql9YZ7t0TnnfJpyAH6eQCjBv4DA-P0";
  
        
  

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
