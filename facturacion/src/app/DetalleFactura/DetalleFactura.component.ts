import { Component, ElementRef, OnInit, ViewChild } from '@angular/core';
import jsPDF from 'jspdf';

@Component({
  selector: 'app-DetalleFactura',
  templateUrl: './DetalleFactura.component.html',
  styleUrls: ['./DetalleFactura.component.css']
})
export class DetalleFacturaComponent implements OnInit {

  constructor() { }

  @ViewChild('factura', {static:true}) el!: ElementRef

  ngOnInit() {
  }

  imprimir(){
    const doc = new jsPDF('l', 'mm', [1150, 1300]);
    doc.html(this.el.nativeElement,{
      callback: (pdf) => {
        pdf.save("Factura.pdf");
      }
    })
  }

}
