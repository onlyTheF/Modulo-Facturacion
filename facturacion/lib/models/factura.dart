class Factura{
  int id;
  DateTime fecha;
  dynamic total;

  Factura({required this.id, required this.fecha, this.total});

  factory Factura.fromJson(Map<String, dynamic> jscon){

    return Factura(

      id: jscon['id'] as int,
      fecha: jscon['fecha'] as DateTime,
      total: jscon['total'] as dynamic,

    );
  }



}