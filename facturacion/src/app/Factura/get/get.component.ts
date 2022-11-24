import { Component, OnInit } from '@angular/core';
import { Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';
import { Filtro } from 'src/app/models/Filtro';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];

  elemento: Venta[] = [];
  constructor(private facturaService: FacturaService, private router: Router, private datepipe: DatePipe) { }
  

  ngOnInit(): void {

    this.getList();
  }

  getList(): void {
    this.facturaService.getList().subscribe(
      data => {
        this.ventas = data;
        this.elemento = this.ventas;
        console.log(this.ventas);
      },

    )

  }

  getFilterNumber() {
    const soloeste = (document.getElementById('id_venta') as HTMLInputElement).value
    /*this.ventas.forEach(element => {
      if(element.id_venta == parseInt(soloeste)){
        console.log(element)

      }
    });*/
    this.elemento = this.ventas.filter((item) => item.id_venta == parseInt(soloeste))
    console.log('esto es ventas', this.ventas)
    console.log('estos es elemeto', this.elemento)
  }

  getFilterDate() {
    const soloeste = (document.getElementById('fechaR') as HTMLInputElement).value
    this.elemento = this.ventas.filter((item) =>  this.datepipe.transform(item.fecha_venta, 'yyyy-MM-dd')  == String(soloeste))
    console.log(soloeste)
    console.log('esto es ventas', this.ventas)
    console.log('estos es elemeto', this.elemento)
  }

  ventasDetalles() {
    this.router.navigate(['detallefactura']);
  }


}
