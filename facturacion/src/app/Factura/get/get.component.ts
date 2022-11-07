import { Component, OnInit } from '@angular/core';
import { Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];

  constructor(private facturaService: FacturaService) { }

  ngOnInit(): void {

    this.facturaService.getList().subscribe(data => this.ventas = data);
  }

}
