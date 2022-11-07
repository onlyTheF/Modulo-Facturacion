import { Component, OnInit } from '@angular/core';
import { Filtro, Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];
  filtro: Filtro = {
    id_venta: null,
    fecha_venta: null
  }

  constructor(private facturaService: FacturaService) { }

  ngOnInit(): void {

    this.getList();
  }

  getList(){
    this.facturaService.getList().subscribe(data => this.ventas = data);
  }

  clearFilter(){
    this.filtro.id_venta = null;
    this.getList();
  }

}
