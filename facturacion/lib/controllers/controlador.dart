import 'package:facturacion/Models/factura.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Controlador{

  static const dynamic ROOT = 'http://localhost/web/factura.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const String _ADD_FACT_ACTION = 'ADD_FACT';
  static const String _UPDATE_FACT_ACTION = 'UPDATE_FACT';
  static const String _DELETE_FACT_ACTION = 'DELETE_FACT';

  //crear la tabla factura
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      if (kDebugMode) {
        print('Create Table Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //mostrar la lista de facturas de la tabla factura
  static Future<List<Factura>> getList() async {
    try {
      var map = <String, dynamic>{};
      map["action"] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      if (kDebugMode) {
        print("mostrarFacturas >> Response:: ${response.body}");
      }
      if (response.statusCode == 200) {
        List<Factura> list = parseResponse(response.body);
        return list;
      } else {
        throw List<Factura>.empty(growable: true);
      }
    } 
    catch (e) {
      return List<Factura>.empty(growable: true);
    }
  }

  //decodificar el objeto json
  static List<Factura> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Factura>((json) => Factura.fromJson(json)).toList();
  }

  //agregar un nuevo registro
  static Future<String> addRegister(dynamic total) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_FACT_ACTION;
      map['total'] = total;
      final response = await http.post(ROOT, body: map);
      if (kDebugMode) {
        print('addRegister Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //actualizar un registro existente
  static Future<String> updateRegister(int id, dynamic total) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_FACT_ACTION;
      map['id'] = id;
      map['total'] = total;
      final response = await http.post(ROOT, body: map);
      if (kDebugMode) {
        print('updateRegister Response: ${response.body}');
      }
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //eliminar un registro
  static Future<String> deleteRegister(dynamic id) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_FACT_ACTION;
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('deleteRegister Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }






  
}



