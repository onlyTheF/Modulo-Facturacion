import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DetalleFacturaComponent } from './DetalleFactura/DetalleFactura.component';
import { GetComponent } from './Factura/get/get.component';

const routes: Routes = [
  {path: 'get', component:GetComponent},
  {path: '**', component:GetComponent},
  {path: 'detallefactura', component:DetalleFacturaComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
