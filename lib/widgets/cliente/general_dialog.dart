import 'package:flutter/material.dart';
import 'package:general_products_web/models/cliente/list_clientes_model.dart';
import 'package:general_products_web/provider/cliente/clientes_provider.dart';
import 'package:general_products_web/resources/colors.dart';
import 'package:general_products_web/resources/global_variables.dart';

class GeneralDialog {
  Future showInfoDialog(
      BuildContext context, String title, String detail) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            title,
            textAlign: TextAlign.center,
          )),
          content: SingleChildScrollView(
            child: Center(
                child: Text(
              detail,
              style: TextStyle(color: Colors.black, fontSize: 17),
              textAlign: TextAlign.center,
            )),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Container(
                  width: MediaQuery.of(context).size.width < 600
                      ? MediaQuery.of(context).size.width * .5
                      : MediaQuery.of(context).size.width * .3,
                  child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Aceptar",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 2,
                          primary: GPColors.PrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                )),
          ],
        );
      },
    );
  }

  Future showEnabledCustomerDialog(
      BuildContext context, CustomersList customer) async {
    bool isLoading = false;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("¿Desea activar a ${customer.nombreCliente}?"),
              content: isLoading
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: 30,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(),
                          CircularProgressIndicator(),
                          Container()
                        ],
                      ))
                  : Container(
                      height: 30,
                    ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * .4
                        : MediaQuery.of(context).size.width * .1,
                    child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: GPColors.PrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .1,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            //await ListUsersProvider().searchUserId(user.idDatoUsuario.toString());
                            await ClientesProvider()
                                .desactivarCliente(customer.idCatCliente!, 1)
                                .then((value) {
                              if (value == null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(
                                    context,
                                    "Ocurrió un error al activar este cliente",
                                    "Error: ${RxVariables.errorMessage}");
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(context,
                                    "¡Cliente activado con exito!", "");
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            );
          },
        );
      },
    );
  }

  Future showDisabledCustomerDialog(
      BuildContext context, CustomersList customer) async {
    bool isLoading = false;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("¿Desea Deshabilitar a ${customer.nombreCliente}?"),
              content: isLoading
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: 30,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(),
                          CircularProgressIndicator(),
                          Container()
                        ],
                      ))
                  : Container(
                      height: 30,
                    ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * .4
                        : MediaQuery.of(context).size.width * .1,
                    child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: GPColors.PrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .1,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            //await ListUsersProvider().searchUserId(user.idDatoUsuario.toString());
                            await ClientesProvider()
                                .desactivarCliente(customer.idCatCliente!, 2)
                                .then((value) {
                              if (value == null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(
                                    context,
                                    "Ocurrió un error al desactivar este cliente",
                                    "Error: ${RxVariables.errorMessage}");
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(context,
                                    "¡Cliente desactivado con exito!", "");
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            );
          },
        );
      },
    );
  }

  Future showDeleteCustomerDialog(
      BuildContext context, CustomersList customer) async {
    bool isLoading = false;
    return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("¿Desea eliminar a ${customer.nombreCliente}?"),
              content: isLoading
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      width: 30,
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(),
                          CircularProgressIndicator(),
                          Container()
                        ],
                      ))
                  : Container(
                      height: 30,
                    ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width < 600
                        ? MediaQuery.of(context).size.width * .4
                        : MediaQuery.of(context).size.width * .1,
                    child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: GPColors.PrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)))),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width < 600
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .1,
                      child: ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Aceptar",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            //await ListUsersProvider().searchUserId(user.idDatoUsuario.toString());
                            await ClientesProvider()
                                .eliminarCliente(customer.idCatCliente!, 3)
                                .then((value) {
                              if (value == null) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(
                                    context,
                                    "Ocurrió un error al eliminar este cliente",
                                    "Error: ${RxVariables.errorMessage}");
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pop(context);
                                showInfoDialog(context,
                                    "¡Cliente eliminado con exito!", "");
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: GPColors.PrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
