import 'dart:async';
import 'dart:math';
import 'package:facturacion/Models/factura.dart';
import 'package:facturacion/controllers/controlador.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../navigation_bar/nav_bar.dart';

class ListSales extends StatefulWidget {
 //ListSales({Key? key}) : super(key: key);

 ListSales():super();

 final title = 'Lista de Facturas';

  @override
  State <ListSales> createState() =>  ListSalesState();
}

class Debouncer {
  final int milliseconds;
  late VoidCallback action;
  late Timer _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer
          .cancel(); // when the user is continuosly typing, this cancels the timer
    }
    // then we will start a new timer looking for the user to stop
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}



class  ListSalesState extends State <ListSales> {

  late List<String> listRequest;
  late Random random;
  late GlobalKey<RefreshIndicatorState> refreshListKey;

  late List<Factura> listItems;
  late List<Factura> filterItem;
  late GlobalKey<ScaffoldState> scaffoldKey;

  late TextEditingController totalController;
  late Factura selectedItem;
  late bool result;
  late String titleResult;
  final debouncer = Debouncer(milliseconds: 2000);


  

  @override
  void initState() {
    super.initState();

    listItems = [];
    result = false;
    titleResult = widget.title;
    scaffoldKey = GlobalKey();
    totalController = TextEditingController();

    refreshListKey = new GlobalKey<RefreshIndicatorState>();
    random = Random();
    listRequest = List.empty(growable: true);
    addRequest();
    getList();
  }

  clearText(){
    totalController.text = "";
  }

  showMessage(String message) {
    setState(() {
      titleResult = message;
    });
  }

  showMessageSnackBar(context, message){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        /*action: SnackBarAction(
          label: "NO REMOVER SOLICITUD",
          onPressed: (){
            undoDelete(index, item);
          }
        ),*/
      )
    );
  }


  createTable()
  {
    titleResult = "Tabla creada";
    Controlador.createTable().then((value){

      if('success' == value){
        showMessageSnackBar(context, value);
      }
    });
  }

  getList()
  {
    showMessage('Lista de registros');
    Controlador.getList().then((facturas){
      setState(() {
        listItems = facturas;
        filterItem = facturas;
      });

      showMessage(widget.title);
    });
  }

  addRegister()
  {
    if(totalController.text.isEmpty){
      print('No debe estar vacio');
      return;
    }

    Controlador.addRegister(totalController.text).then((value){

      if('success' == value){
        getList();
        showMessageSnackBar(context, value);
      }
      clearText();
    });
  }

  updateRegister(Factura factura)
  {

    Controlador.updateRegister(factura.id, totalController.text).then((value){

      if('success' == value){
        getList();
        showMessageSnackBar(context, value);
        clearText();
      }
    });
  }

  deleteRegister(Factura factura)
  {
    Controlador.deleteRegister(factura.id).then((value){
      if('success' == value){
        getList();
        showMessageSnackBar(context, value);
      }
    });
  }

  

  addRequest(){
      listRequest.add("Carlos");
      listRequest.add("Diego");
      listRequest.add("Santiago");
      listRequest.add("Hernan");
      listRequest.add("Luis");
      listRequest.add("Fernando");
      listRequest.add("Jaime");
      listRequest.add("Paul");
  }

  Widget showList(){
      return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: listRequest.length,
        itemBuilder: (BuildContext context, int index){
          return rowItem(context, index);
        }
      );
  }

  Widget rowItem(context, index){
      return Dismissible(
        key: Key(listRequest[index]),
        onDismissed: (direction){
          var item = listRequest[index];
          showSnackBar(context, item, index);
          //removeItem(index);
        },
        background: deleteItem(),
        child: Card(
          child:ListTile(
            title: Text(listRequest[index]),
          ),
        ),
      );
  }

  showSnackBar(context, item, index){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$item removido de la lista'),
        action: SnackBarAction(
          label: "NO REMOVER SOLICITUD",
          onPressed: (){
            undoDelete(index, item);
          }
        ),
      )
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    addRandomItem();
    return null;
  }

  addRandomItem(){
    int nextItem = random.nextInt(200);
    setState(() {
      listRequest.add("$nextItem");
    });
  }

  undoDelete(index, item){
    setState(() {
      listRequest.insert(index, item);
    });
  }

  removeItem(index){
    setState((){
      listRequest.removeAt(index);
    });
  }

  Widget deleteItem(){
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Colors.blue,
      child: Icon(Icons.delete, color: Colors.white),

    );
  }

  SingleChildScrollView gridDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('N Factura'),
            ),
            DataColumn(
              label: Text('Fecha'),
            ),
            DataColumn(
              label: Text('Total Bs.'),
            ),
            DataColumn(
              label: Text('ELIMINAR'),
            ),
            DataColumn(
              label: Text('DETALLE'),
            ),
          ],

          rows: filterItem
              .map(
                (factura) => DataRow(cells: [
                  DataCell(
                    Text(factura.id.toString()),
                    
                    /*onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },*/
                  ),
                  DataCell(
                    Text(
                      factura.fecha.toString(),
                    ),
                    /*onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      // Set flag updating to true to indicate in Update Mode
                      setState(() {
                        _isUpdating = true;
                      });
                    },*/
                  ),
                  DataCell(
                    Text(
                      factura.total.toString(),
                    ),
                    /*onTap: () {
                      _showValues(employee);
                      // Set the Selected employee to Update
                      _selectedEmployee = employee;
                      setState(() {
                        _isUpdating = true;
                      });
                    },*/
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteRegister(factura);
                    },
                  )),
                  DataCell(IconButton(
                    icon: Icon(Icons.info_rounded),
                    onPressed: () {
                      
                    },
                  )),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double maxWith = width > 1200 ? 1200 : width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Color.fromARGB(255, 248, 248, 248),
          width: maxWith,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NavBar(),
              Expanded(
                child: Container(
                  child: RefreshIndicator(
                    key: refreshListKey,
                    child: gridDataTable(),
                    onRefresh: () async {
                      await refreshList();
                    },
                  ),
                ),
              
              ),
            ],
          ),
        ),

      )
    );
  }
}