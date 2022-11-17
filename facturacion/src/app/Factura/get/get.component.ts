import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatTableDataSource } from '@angular/material/table';
import { Filtro } from 'src/app/models/filtro';
import { Venta } from 'src/app/models/venta';
import { FacturaService } from 'src/app/service/factura.service';
import { DialogComponent } from './dialog/dialog.component';

@Component({
  selector: 'app-get',
  templateUrl: './get.component.html',
  styleUrls: ['./get.component.css']
})
export class GetComponent implements OnInit {

  ventas: Venta[] = [];

  displayedColumns = ['id_venta', 'id_user', 'fecha_venta', 'total_venta', 'estado', 'fecha_actualizacion', 'fecha_registro', 'realizar_accion'];

  dataSource: MatTableDataSource<Venta> = new MatTableDataSource;
  constructor(
    public dialog: MatDialog,
    private facturaService: FacturaService
  ) { }

  ngOnInit(): void {
    this.getList();
  }

  getList(){
    this.facturaService.getList().subscribe(data => {
      this.dataSource = new MatTableDataSource(data);
    });
  }

  clearFilter(){
    this.getList();
  }
  
  onDelete(id: number){
    /*let dialogConfirm = this.dialog.open(DialogComponent, {
      disableClose: true,
    });
    dialogConfirm.afterClosed().subscribe(status => {
      if(status){
        
      }
    });*/

    this.facturaService.delete(id).subscribe(() => {
      this.getList();
    });

  }

  filter(valor: Event){
    this.dataSource.filter = (valor.target as HTMLInputElement).value.trim().toLowerCase();
  }

}
