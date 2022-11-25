import { DetalleVenta } from "./detalle_venta";

export class Venta{
    id_venta!: number;
    id_user!: number;
    fecha_venta!: Date;
    total_venta!: number;
    estado!: number;
    fecha_actualizacion!: Date;
    fecha_registro!: Date;
    detalleventa!: DetalleVenta[];
}

