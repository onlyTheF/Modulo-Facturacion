import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { Venta } from './models/venta';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})

export class AppComponent {
  title = 'facturacion';

  constructor(private router: Router){}
}
