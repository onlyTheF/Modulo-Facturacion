import { Component, OnInit } from '@angular/core';
import { Filtro } from 'src/app/models/filtro';
import { Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];
  filtro: Filtro = {
    id_venta: 0,
    id_usuario: 0,
    total_venta: 0,
    estado: 0
  }

  constructor(
    private facturaService: FacturaService
  ) { }

  ngOnInit(): void {
    this.getList();
  }

  getList(){
    this.facturaService.getList().subscribe(data => this.ventas = data);
  }

  clearFilter(){
    //this.filtro.id_venta = null;
    this.getList();
  }
  
  onDelete(id: number){
    this.facturaService.delete(id).subscribe(() => {
      this.facturaService.getList().subscribe(data => this.ventas = data);
    });
  }

}
