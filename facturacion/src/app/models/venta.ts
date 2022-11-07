export class Venta{
    id_venta!: number;
    id_usuario!: number;
    fecha_venta!: Date;
    total_venta!: number;
    estado!: number;
    fecha_actualizacion!: Date;
    fecha_registro!: Date;
}

export class Filtro{
    id_venta!: null;
    fecha_venta!: null;
}