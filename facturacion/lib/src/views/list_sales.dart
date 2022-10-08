import 'dart:async';
import 'dart:math';
import 'package:facturacion/controllers/controlador.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../models/factura.dart';
import '../navigation_bar/nav_bar.dart';

class ListSales extends StatefulWidget {
 //ListSales({Key? key}) : super(key: key);

 ListSales():super();

 final title = "";

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
  late List<Factura> listElements;
  late GlobalKey<ScaffoldState> scaffoldKey;

  late TextEditingController totalController;
  late Factura selectedItem;
  late bool result;
  late String titleResult;
  final debouncer = Debouncer(milliseconds: 2000);


  

  @override
  void initState() {
    super.initState();

    listItems = Factura.getItems();
    result = false;
    titleResult = widget.title;
    scaffoldKey = GlobalKey();
    totalController = TextEditingController();
    listElements = List.empty(growable: true);

    refreshListKey = new GlobalKey<RefreshIndicatorState>();
    random = Random();
    listRequest = List.empty(growable: true);
    addRequest();
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
      )
    );
  }
  /*
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
        listElements = facturas;
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
  }*/

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

  onSortColumn(index, ascending){
    if(index == 0){
      if(ascending){
        listItems.sort(((a, b) => a.id.compareTo(b.id)));
      }
      else{
        listItems.sort(((a, b) => b.id.compareTo(a.id)));
      }
    }
  }

  onSelectRow(selected, item){
    setState(() {
      if(selected){
        listElements.add(item);

      }
      else{
        listElements.remove(item);
      }
    });
    
  }

  SingleChildScrollView gridDataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          sortAscending: result,
          sortColumnIndex: 0,
          columns: [
            DataColumn(
              label: Text('N# FACTURA'),
              onSort: ((columnIndex, ascending) {
                setState(() {
                  result = !result;
                });

                onSortColumn(columnIndex, ascending);
              })
            ),
            DataColumn(
              label: Text('FECHA'),
            ),
            DataColumn(
              label: Text('TOTAL BS'),
            ),
             DataColumn(
              label: Text('DETALLE'),
            ),
            DataColumn(
              label: Text('ELIMINAR'),
            ),
          ],

          rows: listItems
              .map(
                (factura) => DataRow(
                  selected: listElements.contains(factura),
                  onSelectChanged: (value) {
                    onSelectRow(value, factura);
                  },
                  cells: [
                  DataCell(
                    Text(factura.id),
                    onTap: () {
                      showMessageSnackBar(context, factura.id);
                    },
                    
                  ),
                  DataCell(
                    Text(
                      factura.fecha,
                    ),
                    onTap: () {
                      showMessageSnackBar(context, factura.fecha);
                    },
                  ),
                  DataCell(
                    Text(
                      factura.total,
                    ),
                    onTap: () {
                      showMessageSnackBar(context, factura.total);
                    },
                  ),

                  DataCell(IconButton(
                    icon: Icon(Icons.info_rounded),
                    onPressed: () {
                      
                    },
                  )),

                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        listItems.remove(factura);
                      });
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
              SizedBox(height: 20,),
              Text("FACTURAS", textAlign: TextAlign.center,),
              SizedBox(height:20),
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