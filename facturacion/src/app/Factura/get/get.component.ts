import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatTableDataSource } from '@angular/material/table';
import { Filtro } from 'src/app/models/filtro';
import { Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';
import { DialogComponent } from './dialog/dialog.component';
import { Router } from '@angular/router';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];
  coleccion: Venta[] = [];
  venta: Venta = new Venta();

  displayedColumns = ['id_venta', 'id_user', 'fecha_venta', 'total_venta', 'estado', 'fecha_actualizacion', 'fecha_registro', 'realizar_accion'];

  dataSource: MatTableDataSource<Venta> = new MatTableDataSource;
  constructor(
    public dialog: MatDialog,
    private facturaService: FacturaService,
    private router: Router, 
    private datepipe: DatePipe
  ) { }

  ngOnInit(): void {
    this.getList();
  }

  getList(){
    this.facturaService.getList().subscribe(data => {
      this.ventas = data;
      this.coleccion = this.ventas;
    });
  }
  
  onDelete(id: number){
    let dialogConfirm = this.dialog.open(DialogComponent, {
      disableClose: true,
    });
    dialogConfirm.afterClosed().subscribe(status => {
      if(status){
        this.facturaService.delete(id).subscribe(() => {
          this.getList();
        });
      }
    });
    
  }

  filterId(valor: Event){
    var id = (valor.target as HTMLInputElement).value.trim().toLowerCase();
    if(id == "")
    {
      this.getList();
    }
    this.coleccion = this.ventas.filter((item) => item.id_venta == parseInt(id));

  }

  filterTotalSale(valor: Event){
    var totalSale = (valor.target as HTMLInputElement).value.trim().toLowerCase();
    if(totalSale == "")
    {
      this.getList();
    }
    this.coleccion = this.ventas.filter((item) => item.total_venta.toString() == totalSale);
  }

  filterDateSale(){
    var fechaVenta = (document.getElementById('fecha_venta') as HTMLInputElement).value;
    if(fechaVenta == "")
    {
      this.getList();
    }
    this.coleccion = this.ventas.filter((item) =>  this.datepipe.transform(item.fecha_venta, 'yyyy-MM-dd')  == String(fechaVenta));
  }

  ventasDetalles() {
    this.router.navigate(['detallefactura']);
  }

}
