import 'package:dio/dio.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catCustomersOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catInksOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/dtDesignsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catMachinesOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catOperatorsOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catStatusOEModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/catalogsFieldsModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/listOrdenesEntregaModel.dart';
import 'package:general_products_web/models/ordenes_de_trabajo/registrar_recursos/registrarRecursosModel.dart';
import 'package:general_products_web/provider/routes_provider.dart';
import 'package:general_products_web/resources/global_variables.dart';

class OrdenEntregaProvider {
  RoutesProvider routes = RoutesProvider();
  final Options headerWithToken = new Options(headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': "XMLHttpRequest",
    "Authorization": "Bearer ${RxVariables.token}"
  });

  Future getOrdenesDeEntrega() async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    ListOrdenesDeEntregaModel listOEModel =
        ListOrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listarOE;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = ListOrdenesDeEntregaModel.fromJson(resp.data);
      RxVariables.listOrdenesEntrega = listOEModel;
      listOEModel.deliveryOrdersList.forEach((element) {
        if (element.estatusOt!.toLowerCase() == 'nuevo') {
          listOE.add(element);
        }
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getOrdenesDeEntregaWithFilters(String path) async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    ListOrdenesDeEntregaModel listOEModel =
        ListOrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listarOE + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = ListOrdenesDeEntregaModel.fromJson(resp.data);
      RxVariables.listOrdenesEntrega = listOEModel;
      listOEModel.deliveryOrdersList.forEach((element) {
        listOE.add(element);
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getTintas(int idDesign) async {
    RxVariables.errorMessage = '';
    List<InksList> listTintas = [];
    CatInksOEModel listCatInks = CatInksOEModel(inksList: []);
    String url =
        routes.urlBase + routes.listarTintasOE + '?id_cat_diseno=$idDesign';

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listCatInks = CatInksOEModel.fromJson(resp.data);
      RxVariables.listInksOEModel = listCatInks;
      listCatInks.inksList.forEach((element) {
        listTintas.add(element);
      });
      rxVariables.listInksFilter.sink.add(listTintas);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getFields() async {
    List<CatOperatorsOEModel> listOperators = [];
    List<CatCustomersOEModel> listCustomers = [];
    List<CatStatusOEModel> listStatus = [];
    List<CatMachinesOEModel> listMachines = [];
    List<DtDesignsOEModel> listDesings = [];
    RxVariables.errorMessage = '';
    CatalogsFieldsModel listCatalogsModel = CatalogsFieldsModel(
      operatorsList: [],
      customersList: [],
      statusOwList: [],
      machinesList: [],
      designsList: [],
    );
    String url = routes.urlBase + routes.listarCatalogosOE;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listCatalogsModel = CatalogsFieldsModel.fromJson(resp.data);
      RxVariables.gvListCatalogsFields = listCatalogsModel;
      listCatalogsModel.operatorsList.forEach((element) {
        listOperators.add(element);
      });
      listCatalogsModel.customersList.forEach((element) {
        listCustomers.add(element);
      });
      listCatalogsModel.statusOwList.forEach((element) {
        listStatus.add(element);
      });
      listCatalogsModel.machinesList.forEach((element) {
        listMachines.add(element);
      });
      listCatalogsModel.designsList.forEach((element) {
        listDesings.add(element);
      });

      rxVariables.gvSubListOperators.sink.add(listOperators);
      rxVariables.gvSubListCustomers.sink.add(listCustomers);
      rxVariables.gvSubListStatus.sink.add(listStatus);
      rxVariables.gvSubListMachines.sink.add(listMachines);
      rxVariables.gvSubListDesigns.sink.add(listDesings);

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getFieldsRegistros() async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.listarCatalogosOE;

    List<ShiftsList> listShifts = [];
    List<ReasonsList> listReasons = [];

    RegistrarRecursosModel listRecursosModel = RegistrarRecursosModel(
      shiftsList: [],
      reasonsList: [],
    );

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listRecursosModel = RegistrarRecursosModel.fromJson(resp.data);
      RxVariables.gvListRecursosFields = listRecursosModel;
      listRecursosModel.reasonsList.forEach((element) {
        listReasons.add(element);
      });
      listRecursosModel.shiftsList.forEach((element) {
        listShifts.add(element);
      });

      rxVariables.gvSubListReasons.sink.add(listReasons);
      rxVariables.gvSubListShifts.sink.add(listShifts);

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future createOrdenEntrega(
    String ordenFabricacion,
    // int idOpResponsable,
    // int idCliente,
    // int idStatus,
    int idMaquina,
    int idDesign,
    int cantidadProgramada,
    double pesoTotal,
    int turno, // Debe ser un Id
    int linea, // Debe ser un int
    // String folio,
    // String fechaCierre,
    List<dynamic> tintas,
  ) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.crearOE;

    try {
      final dio = Dio();
      final data = {
        'orden_trabajo_of': ordenFabricacion,
        // 'fecha_creacion': fechaCreacion,
        'id_cat_maquina': idMaquina,
        'id_cat_diseno': idDesign,
        'cantidad_programado': cantidadProgramada,
        'peso_total': pesoTotal,
        'id_cat_turno': turno,
        'linea': linea,
        // 'fecha_cierre': fechaCierre,
        'tintas': tintas,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getOrdenesDeEntrega();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }

  Future editOrdenEntrega(
      String ordenFabricacion,
      String fechaCreacion,
      int idOpResponsable,
      int idCliente,
      int idStatus,
      int idMaquina,
      String folio,
      int idDesign) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.editarOE;

    try {
      final dio = Dio();
      final data = {
        'orden_de_fabricacion': ordenFabricacion,
        'fecha_creacion': fechaCreacion,
        'id_cat_op_responsable': idOpResponsable,
        'id_cat_cliente': idCliente,
        'id_cat_status': idStatus,
        'id_cat_maquina': idMaquina,
        'folio': folio,
        'diseno': idDesign,
      };

      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getOrdenesDeEntrega();
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(
          "Ocurrio un error, intenta más tarde " + RxVariables.errorMessage);
      return null;
    }
  }

  Future changeStatusOEProvider(int idOrdenTrabajo, int idCatEstatus) async {
    RxVariables.errorMessage = '';
    String url = routes.urlBase + routes.changeEstatusOE;

    try {
      final dio = Dio();
      final data = {
        'id_orden_trabajo': idOrdenTrabajo,
        'id_cat_estatus_ot': idCatEstatus
      };
      final resp = await dio.post(url, data: data, options: headerWithToken);
      await getFields();
      RxVariables.errorMessage = resp.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      return null;
    }
  }

  // Ordenes de entrega Recepción

  Future getOrdenesDeEntregaRecepcion() async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    ListOrdenesDeEntregaModel listOEModel =
        ListOrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listOERecepcion;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = ListOrdenesDeEntregaModel.fromJson(resp.data);
      listOEModel.deliveryOrdersList.forEach((element) {
        listOE.add(element);
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  Future getOrdenesDeEntregaRecepcionWithFilters(String path) async {
    List<DeliveryOrdersList> listOE = [];
    RxVariables.errorMessage = '';
    ListOrdenesDeEntregaModel listOEModel =
        ListOrdenesDeEntregaModel(deliveryOrdersList: []);

    String url = routes.urlBase + routes.listOERecepcion + path;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listOEModel = ListOrdenesDeEntregaModel.fromJson(resp.data);
      listOEModel.deliveryOrdersList.forEach((element) {
        listOE.add(element);
      });
      rxVariables.listOrdersFilter.sink.add(listOE);
      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }

  // Este hay que actualizarlo con los campos del postman final de Ernesto
  Future getFieldsRecepcion() async {
    List<CatOperatorsOEModel> listOperators = [];
    List<CatCustomersOEModel> listCustomers = [];
    List<CatStatusOEModel> listStatus = [];
    List<CatMachinesOEModel> listMachines = [];
    List<DtDesignsOEModel> listDesings = [];
    RxVariables.errorMessage = '';
    CatalogsFieldsModel listCatalogsModel = CatalogsFieldsModel(
      operatorsList: [],
      customersList: [],
      statusOwList: [],
      machinesList: [],
      designsList: [],
    );
    String url = routes.urlBase + routes.listarCatalogosOERecepcion;

    try {
      final dio = Dio();

      final resp = await dio.get(url, options: headerWithToken);
      listCatalogsModel = CatalogsFieldsModel.fromJson(resp.data);
      RxVariables.gvListCatalogsFields = listCatalogsModel;
      listCatalogsModel.operatorsList.forEach((element) {
        listOperators.add(element);
      });
      listCatalogsModel.customersList.forEach((element) {
        listCustomers.add(element);
      });
      listCatalogsModel.statusOwList.forEach((element) {
        listStatus.add(element);
      });
      listCatalogsModel.machinesList.forEach((element) {
        listMachines.add(element);
      });
      listCatalogsModel.designsList.forEach((element) {
        listDesings.add(element);
      });

      rxVariables.gvSubListOperators.sink.add(listOperators);
      rxVariables.gvSubListCustomers.sink.add(listCustomers);
      rxVariables.gvSubListStatus.sink.add(listStatus);
      rxVariables.gvSubListMachines.sink.add(listMachines);
      rxVariables.gvSubListDesigns.sink.add(listDesings);

      return resp.data;
    } on DioError catch (e) {
      RxVariables.errorMessage = e.response!.data["message"]
          .toString()
          .replaceAll("{", "")
          .replaceAll("[", "")
          .replaceAll("}", "")
          .replaceAll("]", "");
      rxVariables.listOrdersFilter.sink.addError(RxVariables.errorMessage +
          " Por favor contacta con el administrador");
      return null;
    }
  }
}
