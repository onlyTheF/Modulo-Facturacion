import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Venta } from './models/venta';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  //templateUrl: './views/list_sales_details.html',
  styleUrls: ['./app.component.css']
})

//https://www.youtube.com/watch?v=O13X14TGtm8
//https://www.youtube.com/watch?v=lxYB79ANJM8
export class AppComponent {
  title = 'facturacion';

  constructor(private router: Router){}

  
  /*coleccion: Venta[] = [
    {id: 1, fecha:'17-10-2022', total: 1000},
    {id: 2, fecha:'19-09-2022', total: 3000},
    {id: 3, fecha:'10-10-2022', total: 50000},
    {id: 4, fecha:'14-10-2022', total: 23000},
    {id: 5, fecha:'11-10-2022', total: 14000},

  ];*/

  //coleccion: Venta[] = [];
}
