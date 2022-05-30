-- Generado por Oracle SQL Developer Data Modeler 4.1.3.901
--   en:        2022-05-30 17:59:51 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g




CREATE TABLE Adicional
  (
    id          INTEGER NOT NULL ,
    descripcion VARCHAR2 (30 CHAR) NOT NULL ,
    numSeguro   VARCHAR2 (20 CHAR) ,
    costoSeguro FLOAT (10) ,
    costoGps FLOAT (10)
  ) ;
ALTER TABLE Adicional ADD CONSTRAINT ServicioAdicional_PK PRIMARY KEY ( id ) ;


CREATE TABLE Articulo
  (
    id                INTEGER NOT NULL ,
    nombre            VARCHAR2 (20 CHAR) NOT NULL ,
    tipo              VARCHAR2 (20 CHAR) NOT NULL ,
    CompraArticulo_id INTEGER NOT NULL ,
    descripcion       VARCHAR2 (25 CHAR)
  ) ;
ALTER TABLE Articulo ADD CONSTRAINT Articulo_PK PRIMARY KEY ( id ) ;


CREATE TABLE Ciudad
  (
    id              INTEGER NOT NULL ,
    nombre          VARCHAR2 (30 CHAR) NOT NULL ,
    Departamento_id INTEGER NOT NULL
  ) ;
ALTER TABLE Ciudad ADD CONSTRAINT Ciudad_PK PRIMARY KEY ( id ) ;


CREATE TABLE CompraArticulo
  (
    id       INTEGER NOT NULL ,
    fecha    DATE NOT NULL ,
    cantidad INTEGER NOT NULL ,
    subtotal FLOAT (10) NOT NULL ,
    Factura_idFactura INTEGER NOT NULL
  ) ;
ALTER TABLE CompraArticulo ADD CONSTRAINT CompraArticulo_PK PRIMARY KEY ( id ) ;


CREATE TABLE CompraPaquete
  (
    id                INTEGER NOT NULL ,
    fecha             DATE NOT NULL ,
    estado            VARCHAR2 (12) NOT NULL ,
    Paquete_id        INTEGER NOT NULL ,
    Factura_idFactura INTEGER NOT NULL
  ) ;
ALTER TABLE CompraPaquete ADD CONSTRAINT CompraPaquete_PK PRIMARY KEY ( id ) ;


CREATE TABLE Departamento
  (
    id     INTEGER NOT NULL ,
    nombre VARCHAR2 (30 CHAR) NOT NULL
  ) ;
ALTER TABLE Departamento ADD CONSTRAINT Departamento_PK PRIMARY KEY ( id ) ;


CREATE TABLE Factura
  (
    idFactura INTEGER NOT NULL ,
    valorTotal FLOAT (10) NOT NULL ,
    Persona_id INTEGER NOT NULL ,
    nota       VARCHAR2 (30 CHAR)
  ) ;
ALTER TABLE Factura ADD CONSTRAINT Factura_PK PRIMARY KEY ( idFactura ) ;


CREATE TABLE Habitacion
  (
    id    VARCHAR2 (5 CHAR) NOT NULL ,
    nivel VARCHAR2 (20 CHAR) NOT NULL ,
    precioNoche FLOAT (10) NOT NULL ,
    estado       VARCHAR2 (20 CHAR) NOT NULL ,
    Hospedaje_id INTEGER NOT NULL
  ) ;
ALTER TABLE Habitacion ADD CONSTRAINT Habitacion_PK PRIMARY KEY ( id ) ;


CREATE TABLE Hospedaje
  (
    id            INTEGER NOT NULL ,
    nombre        VARCHAR2 (30 CHAR) NOT NULL ,
    cancelaciones VARCHAR2 (50 CHAR)
  ) ;
ALTER TABLE Hospedaje ADD CONSTRAINT Hospedaje_PK PRIMARY KEY ( id ) ;


CREATE TABLE Instalacion
  (
    id           INTEGER NOT NULL ,
    nombre       VARCHAR2 (30 CHAR) NOT NULL ,
    Hospedaje_id INTEGER NOT NULL ,
    estado       VARCHAR2 (20 CHAR)
  ) ;
ALTER TABLE Instalacion ADD CONSTRAINT Instalacion_PK PRIMARY KEY ( id ) ;


CREATE TABLE Log
  (
    id          INTEGER NOT NULL ,
    fecha       DATE NOT NULL ,
    descripcion VARCHAR2 (100 CHAR) NOT NULL
  ) ;
ALTER TABLE Log ADD CONSTRAINT Log_PK PRIMARY KEY ( id ) ;


CREATE TABLE Paquete
  (
    id          INTEGER NOT NULL ,
    descripcion VARCHAR2 (50 CHAR) NOT NULL ,
    precio      INTEGER NOT NULL
  ) ;
ALTER TABLE Paquete ADD CONSTRAINT Paquete_PK PRIMARY KEY ( id ) ;


CREATE TABLE Persona
  (
    cedula    INTEGER NOT NULL ,
    nombre    VARCHAR2 (20 CHAR) NOT NULL ,
    apellido  VARCHAR2 (20 CHAR) NOT NULL ,
    direccion VARCHAR2 (50 CHAR) NOT NULL ,
    Ciudad_id INTEGER NOT NULL ,
    correo    VARCHAR2 (30 CHAR)
  ) ;
ALTER TABLE Persona ADD CONSTRAINT Persona_PK PRIMARY KEY ( cedula ) ;


CREATE TABLE Regimen
  (
    id           INTEGER NOT NULL ,
    descripcion  VARCHAR2 (150 CHAR) NOT NULL ,
    Hospedaje_id INTEGER NOT NULL
  ) ;
ALTER TABLE Regimen ADD CONSTRAINT Regimen_PK PRIMARY KEY ( id ) ;


CREATE TABLE ResHabita
  (
    id                    INTEGER NOT NULL ,
    Reserva_id            INTEGER NOT NULL ,
    Reserva_cantidadNoche INTEGER NOT NULL ,
    Habitacion_id         VARCHAR2 (5 CHAR) NOT NULL
  ) ;
ALTER TABLE ResHabita ADD CONSTRAINT ReservaHabitacion_PK PRIMARY KEY ( id ) ;


CREATE TABLE Reserva
  (
    id            INTEGER NOT NULL ,
    fecha         DATE NOT NULL ,
    fechaInicio   DATE NOT NULL ,
    estado        VARCHAR2 (12 CHAR) NOT NULL ,
    cantidadNoche INTEGER NOT NULL ,
    valor FLOAT (11) NOT NULL ,
    Factura_idFactura INTEGER NOT NULL
  ) ;
ALTER TABLE Reserva ADD CONSTRAINT Reserva_PK PRIMARY KEY ( id, cantidadNoche ) ;


CREATE TABLE ReservaVeh
  (
    id INTEGER NOT NULL ,
    costo FLOAT (10) NOT NULL ,
    Vehiculo_placa       VARCHAR2 (10 CHAR) NOT NULL ,
    Factura_idFactura    INTEGER NOT NULL ,
    fechaInicio          DATE NOT NULL ,
    fechaDevolucion      DATE NOT NULL ,
    ServicioAdicional_id INTEGER
  ) ;
ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVehiculo_PK PRIMARY KEY ( id ) ;


CREATE TABLE Telefono
  (
    id             INTEGER NOT NULL ,
    tipo           VARCHAR2 (30 CHAR) NOT NULL ,
    Persona_cedula INTEGER
  ) ;
ALTER TABLE Telefono ADD CONSTRAINT Telefono_PK PRIMARY KEY ( id ) ;


CREATE TABLE TipoHospedaje
  (
    id           INTEGER NOT NULL ,
    nombre       VARCHAR2 (30 CHAR) NOT NULL ,
    Hospedaje_id INTEGER NOT NULL
  ) ;
ALTER TABLE TipoHospedaje ADD CONSTRAINT TipoHospedaje_PK PRIMARY KEY ( id ) ;


CREATE TABLE Vehiculo
  (
    placa     VARCHAR2 (10 CHAR) NOT NULL ,
    marca     VARCHAR2 (20 CHAR) NOT NULL ,
    tipo      VARCHAR2 (10 CHAR) NOT NULL ,
    capacidad INTEGER NOT NULL ,
    valorDia FLOAT (10) NOT NULL ,
    gama   VARCHAR2 (10 CHAR) ,
    estado VARCHAR2 (10 CHAR)
  ) ;
ALTER TABLE Vehiculo ADD CONSTRAINT Vehiculo_PK PRIMARY KEY ( placa ) ;


ALTER TABLE Articulo ADD CONSTRAINT Articulo_CompraArticulo_FK FOREIGN KEY ( CompraArticulo_id ) REFERENCES CompraArticulo ( id ) ;

ALTER TABLE Ciudad ADD CONSTRAINT Ciudad_Departamento_FK FOREIGN KEY ( Departamento_id ) REFERENCES Departamento ( id ) ;

ALTER TABLE CompraArticulo ADD CONSTRAINT CompraArticulo_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE CompraPaquete ADD CONSTRAINT CompraPaquete_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE CompraPaquete ADD CONSTRAINT CompraPaquete_Paquete_FK FOREIGN KEY ( Paquete_id ) REFERENCES Paquete ( id ) ;

ALTER TABLE Factura ADD CONSTRAINT Factura_Persona_FK FOREIGN KEY ( Persona_id ) REFERENCES Persona ( cedula ) ;

ALTER TABLE Habitacion ADD CONSTRAINT Habitacion_Hospedaje_FK FOREIGN KEY ( Hospedaje_id ) REFERENCES Hospedaje ( id ) ;

ALTER TABLE Instalacion ADD CONSTRAINT Instalacion_Hospedaje_FK FOREIGN KEY ( Hospedaje_id ) REFERENCES Hospedaje ( id ) ;

ALTER TABLE Persona ADD CONSTRAINT Persona_Ciudad_FK FOREIGN KEY ( Ciudad_id ) REFERENCES Ciudad ( id ) ;

ALTER TABLE Regimen ADD CONSTRAINT Regimen_Hospedaje_FK FOREIGN KEY ( Hospedaje_id ) REFERENCES Hospedaje ( id ) ;

ALTER TABLE ResHabita ADD CONSTRAINT ResHabita_Habitacion_FK FOREIGN KEY ( Habitacion_id ) REFERENCES Habitacion ( id ) ;

ALTER TABLE ResHabita ADD CONSTRAINT ResHabita_Reserva_FK FOREIGN KEY ( Reserva_id, Reserva_cantidadNoche ) REFERENCES Reserva ( id, cantidadNoche ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Adicional_FK FOREIGN KEY ( ServicioAdicional_id ) REFERENCES Adicional ( id ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Vehiculo_FK FOREIGN KEY ( Vehiculo_placa ) REFERENCES Vehiculo ( placa ) ;

ALTER TABLE Reserva ADD CONSTRAINT Reserva_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE Telefono ADD CONSTRAINT Telefono_Persona_FK FOREIGN KEY ( Persona_cedula ) REFERENCES Persona ( cedula ) ;

ALTER TABLE TipoHospedaje ADD CONSTRAINT TipoHospedaje_Hospedaje_FK FOREIGN KEY ( Hospedaje_id ) REFERENCES Hospedaje ( id ) ;


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             0
-- ALTER TABLE                             38
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
