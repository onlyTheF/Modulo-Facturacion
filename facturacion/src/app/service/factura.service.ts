import { Injectable } from '@angular/core';
import {HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { DetachedRouteHandle } from '@angular/router';
import { Venta } from '../models/venta';
import { Filtro } from '../models/filtro';
import { Observable } from 'rxjs/internal/Observable';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  constructor(private http: HttpClient){}

  Url='http://localhost:8080/';

  getList(){
    return this.http.get<Venta[]>(this.Url+'ventas');
  }

  delete(id: number){
    return this.http.delete(this.Url+'ventas/'+id);
  }

  /*delete(id: number, estado: number){

    const headers = new HttpHeaders().append(
      'Content-Type',
      'application/x-www-form-urlencoded'
    );
    const body = {};

    const params = new HttpParams()
          .append('id_venta', id)
          .append('estado', estado);
    let object = {id, estado}
    return this.http.put(this.Url+'/'+id, object);
  }*/

  getRegister(id: number){
    return this.http.get<Venta>(this.Url+'/'+id);
  }


}
