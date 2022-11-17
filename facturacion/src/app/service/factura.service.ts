import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { DetachedRouteHandle } from '@angular/router';
import { Venta } from '../models/venta';
import { Filtro } from '../models/filtro';
import { Observable } from 'rxjs/internal/Observable';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  constructor(private http: HttpClient){}

  Url='http://localhost:8080/ventas';

  getList(){
    return this.http.get<Venta[]>(this.Url);
  }

  delete(id: number){
    return this.http.delete(`${this.Url}/${id}`);
  }


}
