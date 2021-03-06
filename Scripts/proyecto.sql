create tablespace ts_transacciones datafile
'D:\Documentos\Universidad\Semestre_7\Bases de Datos II\Proyecto final\Datafile_1\transacciones.dbf' size 10M;
alter table reserva move tablespace ts_transacciones;
alter table reservaveh move tablespace ts_transacciones;
alter table comprapaquete move tablespace ts_transacciones;
alter table compraarticulo move tablespace ts_transacciones;
alter table hospedajeregimen move tablespace ts_transacciones;
alter table factura move tablespace ts_transacciones;
alter table log move tablespace ts_transacciones;

create tablespace ts_modelo datafile
'D:\Documentos\Universidad\Semestre_7\Bases de Datos II\Proyecto final\Datafile_1\modelo.dbf' size 10M;
alter table persona move tablespace ts_modelo;
alter table articulo move tablespace ts_modelo;
alter table vehiculo move tablespace ts_modelo;
alter table paquete move tablespace ts_modelo;
alter table adicional move tablespace ts_modelo;
alter table reshabita move tablespace ts_modelo;
alter table habitacion move tablespace ts_modelo;
alter table regimen move tablespace ts_modelo;
alter table hospedaje move tablespace ts_modelo;
alter table tipohospedaje move tablespace ts_modelo;
alter table instalacion move tablespace ts_modelo;

create tablespace ts_bajas datafile
'D:\Documentos\Universidad\Semestre_7\Bases de Datos II\Proyecto final\Datafile_1\bajas.dbf' size 4M;
alter table telefono move tablespace ts_bajas;
alter table departamento move tablespace ts_bajas;
alter table ciudad move tablespace ts_bajas;

create tablespace ts_indices datafile
'D:\Documentos\Universidad\Semestre_7\Bases de Datos II\Proyecto final\Datafile_1\indices.dbf' size 3M;
