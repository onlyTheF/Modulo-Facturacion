import { HttpClient, HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { GetComponent } from './Factura/get/get.component';
import { FormsModule } from '@angular/forms';
import { DetalleFacturaComponent } from './DetalleFactura/DetalleFactura.component';
import { DatePipe } from '@angular/common';

@NgModule({
  declarations: [
    AppComponent,
    GetComponent,
    DetalleFacturaComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule
  ],
  providers: [DatePipe],
  bootstrap: [AppComponent]
})
export class AppModule { }
