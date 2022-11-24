import { Injectable } from '@angular/core';
import {HttpClient } from '@angular/common/http';
import { DetachedRouteHandle } from '@angular/router';
import { Venta } from '../models/venta';
import { Observable } from 'rxjs';
import { Filtro } from '../models/Filtro';

@Injectable({
  providedIn: 'root'
})
export class FacturaService {

  constructor(private http: HttpClient){}

  Url='http://localhost:8080/';

  getList(){
    return this.http.get<Venta[]>(this.Url);
  }



}
