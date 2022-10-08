class Factura{
  String id;
  String fecha;
  String total;

  Factura({required this.id, required this.fecha, required this.total});

  factory Factura.fromJson(Map<String, dynamic> jscon){

    return Factura(

      id: jscon['id'] as String,
      fecha: jscon['fecha'] as String,
      total: jscon['total'] as String,

    );
  }

  static List<Factura> getItems(){

    return <Factura>[
      Factura(id: "100", fecha: "08-10-2022", total: "4000"),
      Factura(id: "200", fecha: "08-10-2022", total: "10000"),
      Factura(id: "300", fecha: "08-10-2022", total: "20000"),
      Factura(id: "400", fecha: "08-10-2022", total: "40000"),
      Factura(id: "500", fecha: "08-10-2022", total: "1800"),
      Factura(id: "600", fecha: "08-10-2022", total: "7000"),
      Factura(id: "700", fecha: "07-10-2022", total: "9000"),
    ];
  }



}