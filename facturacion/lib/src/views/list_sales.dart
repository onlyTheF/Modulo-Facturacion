import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../navigation_bar/nav_bar.dart';

class ListSales extends StatefulWidget {
 ListSales({Key? key}) : super(key: key);

  @override
  State <ListSales> createState() =>  ListSalesState();
}

class  ListSalesState extends State <ListSales> {

  late List<String> listRequest;
  late Random random;
  late GlobalKey<RefreshIndicatorState> refreshListKey;
  

  @override
  void initState() {
    super.initState();

    // ignore: unnecessary_new
    refreshListKey = new GlobalKey<RefreshIndicatorState>();
    random = Random();
    listRequest = List.empty(growable: true);
    addRequest();
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
                    backgroundColor: Colors.blueAccent,
                    color: Colors.blue,
                    key: refreshListKey,
                    child: showList(),
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