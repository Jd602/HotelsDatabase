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
    CompraArticulo_id INTEGER NOT NULL ,
    nombre            VARCHAR2 (20 CHAR) NOT NULL ,
    tipo              VARCHAR2 (20 CHAR) NOT NULL ,
    descripcion       VARCHAR2 (25 CHAR)
  ) ;
ALTER TABLE Articulo ADD CONSTRAINT Articulo_PK PRIMARY KEY ( id ) ;


CREATE TABLE Ciudad
  (
    id              INTEGER NOT NULL ,
    Departamento_id INTEGER NOT NULL ,
    nombre          VARCHAR2 (30 CHAR) NOT NULL
  ) ;
ALTER TABLE Ciudad ADD CONSTRAINT Ciudad_PK PRIMARY KEY ( id ) ;


CREATE TABLE CompraArticulo
  (
    id                INTEGER NOT NULL ,
    Factura_idFactura INTEGER NOT NULL ,
    fecha             DATE NOT NULL ,
    cantidad          INTEGER NOT NULL ,
    subtotal FLOAT (10) NOT NULL
  ) ;
ALTER TABLE CompraArticulo ADD CONSTRAINT CompraArticulo_PK PRIMARY KEY ( id ) ;


CREATE TABLE CompraPaquete
  (
    id                INTEGER NOT NULL ,
    Paquete_id        INTEGER NOT NULL ,
    Factura_idFactura INTEGER NOT NULL ,
    fecha             DATE NOT NULL ,
    estado            VARCHAR2 (12) NOT NULL
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
    idFactura  INTEGER NOT NULL ,
    Persona_id INTEGER NOT NULL ,
    valorTotal FLOAT (10) NOT NULL ,
    nota VARCHAR2 (30 CHAR)
  ) ;
ALTER TABLE Factura ADD CONSTRAINT Factura_PK PRIMARY KEY ( idFactura ) ;


CREATE TABLE Habitacion
  (
    id           VARCHAR2 (5 CHAR) NOT NULL ,
    Hospedaje_id INTEGER NOT NULL ,
    nivel        VARCHAR2 (20 CHAR) NOT NULL ,
    precioNoche FLOAT (10) NOT NULL ,
    estado VARCHAR2 (20 CHAR) NOT NULL
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
    Hospedaje_id INTEGER NOT NULL ,
    nombre       VARCHAR2 (30 CHAR) NOT NULL ,
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
    Ciudad_id INTEGER NOT NULL ,
    nombre    VARCHAR2 (20 CHAR) NOT NULL ,
    apellido  VARCHAR2 (20 CHAR) NOT NULL ,
    direccion VARCHAR2 (50 CHAR) NOT NULL ,
    correo    VARCHAR2 (30 CHAR)
  ) ;
ALTER TABLE Persona ADD CONSTRAINT Persona_PK PRIMARY KEY ( cedula ) ;


CREATE TABLE Regimen
  (
    id           INTEGER NOT NULL ,
    Hospedaje_id INTEGER NOT NULL ,
    descripcion  VARCHAR2 (150 CHAR) NOT NULL
  ) ;
ALTER TABLE Regimen ADD CONSTRAINT Regimen_PK PRIMARY KEY ( id ) ;


CREATE TABLE ResHabita
  (
    id            INTEGER NOT NULL ,
    Reserva_id    INTEGER NOT NULL ,
    Habitacion_id VARCHAR2 (5 CHAR) NOT NULL
  ) ;
ALTER TABLE ResHabita ADD CONSTRAINT ReservaHabitacion_PK PRIMARY KEY ( id ) ;


CREATE TABLE Reserva
  (
    id                INTEGER NOT NULL ,
    Factura_idFactura INTEGER NOT NULL ,
    fecha             DATE NOT NULL ,
    fechaInicio       DATE NOT NULL ,
    estado            VARCHAR2 (12 CHAR) NOT NULL ,
    cantidadNoche     INTEGER NOT NULL ,
    valor FLOAT (11) NOT NULL
  ) ;
ALTER TABLE Reserva ADD CONSTRAINT Reserva_PK PRIMARY KEY ( id ) ;


CREATE TABLE ReservaVeh
  (
    id                INTEGER NOT NULL ,
    Vehiculo_placa    VARCHAR2 (10 CHAR) NOT NULL ,
    Factura_idFactura INTEGER NOT NULL ,
    costo FLOAT (10) NOT NULL ,
    fechaInicio          DATE NOT NULL ,
    fechaDevolucion      DATE NOT NULL ,
    ServicioAdicional_id INTEGER
  ) ;
ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVehiculo_PK PRIMARY KEY ( id ) ;


CREATE TABLE Telefono
  (
    id             INTEGER NOT NULL ,
    Persona_cedula INTEGER ,
    tipo           VARCHAR2 (30 CHAR) NOT NULL
  ) ;
ALTER TABLE Telefono ADD CONSTRAINT Telefono_PK PRIMARY KEY ( id ) ;


CREATE TABLE TipoHospedaje
  (
    id           INTEGER NOT NULL ,
    Hospedaje_id INTEGER NOT NULL ,
    nombre       VARCHAR2 (30 CHAR) NOT NULL
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

ALTER TABLE ResHabita ADD CONSTRAINT ResHabita_Reserva_FK FOREIGN KEY ( Reserva_id ) REFERENCES Reserva ( id ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Adicional_FK FOREIGN KEY ( ServicioAdicional_id ) REFERENCES Adicional ( id ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE ReservaVeh ADD CONSTRAINT ReservaVeh_Vehiculo_FK FOREIGN KEY ( Vehiculo_placa ) REFERENCES Vehiculo ( placa ) ;

ALTER TABLE Reserva ADD CONSTRAINT Reserva_Factura_FK FOREIGN KEY ( Factura_idFactura ) REFERENCES Factura ( idFactura ) ;

ALTER TABLE Telefono ADD CONSTRAINT Telefono_Persona_FK FOREIGN KEY ( Persona_cedula ) REFERENCES Persona ( cedula ) ;

ALTER TABLE TipoHospedaje ADD CONSTRAINT TipoHospedaje_Hospedaje_FK FOREIGN KEY ( Hospedaje_id ) REFERENCES Hospedaje ( id ) ;



---inserts---

---Tabla Departamento---
insert into Departamento values(1,'Valle del cauca');
insert into Departamento values(2,'Santander');
insert into Departamento values(3,'Caldas');
insert into Departamento values(4,'Caquetá');
insert into Departamento values(5,'Huila');
insert into Departamento values(6,'Sucre');
insert into Departamento values(7,'Meta');
insert into Departamento values(8,'Nariño');
insert into Departamento values(9,'Caldas');
insert into Departamento values(10,'Putumayo');
insert into Departamento values(11,'Amazonas');
insert into Departamento values(12,'Magdalena');
insert into Departamento values(13,'Arauca');
insert into Departamento values(14,'Atlántico');
insert into Departamento values(15,'Cauca');	
insert into Departamento values(16,'Casanare');
insert into Departamento values(17,'Cesar');
insert into Departamento values(18,'Chocó');
insert into Departamento values(19,'Córdoba');
insert into Departamento values(20,'Quindío');
insert into Departamento values(21,'Risaralda');
insert into Departamento values(22,'Tolima');
insert into Departamento values(23,'Vaupés');
insert into Departamento values(24,'Vichada');
insert into Departamento values(25,'Meta');

----Tabla Ciudad----
insert into Ciudad values (1,1,'Cali');
insert into Ciudad values(2,2,'Medellín');
insert into Ciudad values(3,2,'Bucaramanga');
insert into Ciudad values(4,4,'Florencia');
insert into Ciudad values(5,5,'Santa Marta');
insert into Ciudad values(6,5,'Barranquilla');
insert into Ciudad values (7,1,'Ibagué');
insert into Ciudad values(8,20,'Armenia');
insert into Ciudad values(9,11,'Leticia');
insert into Ciudad values(10,13,'Arauca');
insert into Ciudad values(11,12,'Bogotá');
insert into Ciudad values(12,5,'Manizales');
insert into Ciudad values (13,1,'Cúcuta');
insert into Ciudad values(14,8,'Pasto');
insert into Ciudad values(15,18,'Quibdó');
insert into Ciudad values(16,10,'Mocoa');
insert into Ciudad values(17,6,'Sincelejo');
insert into Ciudad values(18,5,'Cartagena');
insert into Ciudad values(19,5,'Huila');
insert into Ciudad values(20,5,'Pereira');
insert into Ciudad values(21,12,'Ibagué');
insert into Ciudad values(22,5,'Villavicencio');
insert into Ciudad values (23,1,'Buenaventura');
insert into Ciudad values(24,8,'Buga');
insert into Ciudad values(25,18,'Málaga');

----Tabla TipoHospedaje----
insert into TipoHospedaje values(1,'Hotel');
insert into TipoHospedaje values(2,'Finca turística');
insert into TipoHospedaje values(3,'Cabaña');
insert into TipoHospedaje values(4,'Apartamento');
insert into TipoHospedaje values(5,'Hostal');
insert into TipoHospedaje values(6,'Motel');
insert into TipoHospedaje values(7,'Camping');
insert into TipoHospedaje values(8,'Residencia');
insert into TipoHospedaje values(9,'Chalet');
insert into TipoHospedaje values(10,'Apart-hotel');

----Tabla hospedaje----
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (1,'Almería','Hasta 3 días antes sin sanción',1);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (2,'Atlantis','Hasta 1 día antes sin sanción',6);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (3,'Estelar','Hasta 3 días antes sin sanción',5);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (4,'El Misterio','Hasta 8 días antes sin sanción',4);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (5,'Dann','Hasta 3 días antes sin sanción',10);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (6,'Cielo Azul','Hasta 3 días antes sin sanción',2);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (7,'Horizonte','Hasta 3 días antes sin sanción',1);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (8,'Boston','Hasta 8 días antes sin sanción',7);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (9,'Palmas Verdes','Hasta 3 días antes sin sanción',3);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (10,'El Remanso','Hasta 3 días antes sin sanción',4);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (11,'Spiwak','Hasta 3 días antes sin sanción',9);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (12,'Renacer','Hasta 1 día antes sin sanción',8);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (13,'Turín','Hasta 3 días antes sin sanción',2);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (14,'Bacatá','Hasta 1 día antes sin sanción',9);
insert into Hospedaje (id,nombre,cancelaciones,tipoHospedaje_id) values (15,'Zuldemayda','Hasta 3 días antes sin sanción',10);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (16,'París',1);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (17,'El Rey',6);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (18,'Amanecer',1);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (19,'Studio 5',3);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (20,'El Coyote',2);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (21,'Buró 43',7);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (22,'Movich',8);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (23,'Buenos Aires',1);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (24,'Brillo de la mañana',6);
insert into Hospedaje (id,nombre,tipoHospedaje_id) values (25,'Joven despertar',4);

----Tabla Persona----
INSERT INTO Persona VALUES (110, 14, 'Glynnis', 'Gonthier', 'Cra 2 # 21 14', 'glynnisgonthier@gmail.com');
INSERT INTO Persona VALUES (111, 15, 'Florida', 'Morang', 'Cra 10 # 21 16', 'floridamorang@gmail.com');
INSERT INTO Persona VALUES (112, 19, 'Starla', 'Friedline', 'Cra 3 # 13 13', 'starlafriedline@gmail.com');
INSERT INTO Persona VALUES (113, 17, 'Joni', 'Doviak', 'Cra 18 # 15N 16', 'jonidoviak@gmail.com');
INSERT INTO Persona VALUES (114, 5, 'Dido', 'Tofel', 'Cra 15 # 26N 8', 'didotofel@gmail.com');
INSERT INTO Persona VALUES (115, 6, 'Fredelia', 'Bultron', 'Cra 7 # 23 19', 'fredeliabultron@gmail.com');
INSERT INTO Persona VALUES (116, 4, 'Pier', 'Conerly', 'Cra 8 # 26 14', 'pierconerly@gmail.com');
INSERT INTO Persona VALUES (117, 18, 'Carroll', 'Minger', 'Cra 2 # 6 1', 'carrollminger@gmail.com');
INSERT INTO Persona VALUES (118, 13, 'Rivkah', 'Plombon', 'Cra 2 # 19 5', 'rivkahplombon@gmail.com');
INSERT INTO Persona VALUES (119, 2, 'Janela', 'Ausby', 'Cra 10 # 2N 22', 'janelaausby@gmail.com');
INSERT INTO Persona VALUES (120, 7, 'Mariette', 'Schniers', 'Cra 2 # 1 3', 'marietteschniers@gmail.com');
INSERT INTO Persona VALUES (121, 17, 'Cassi', 'Iaccino', 'Cra 6 # 3N 1', 'cassiiaccino@gmail.com');
INSERT INTO Persona VALUES (122, 6, 'Leola', 'Gatian', 'Cra 13 # 6 6', 'leolagatian@gmail.com');
INSERT INTO Persona VALUES (123, 16, 'Marcelia', 'Morata', 'Cra 8 # 24 10', 'marceliamorata@gmail.com');
INSERT INTO Persona VALUES (124, 14, 'Fleurette', 'Hildahl', 'Cra 19 # 6N 21', 'fleurettehildahl@gmail.com');
INSERT INTO Persona VALUES (125, 8, 'Eleni', 'Zhinin', 'Cra 19 # 23 29', 'elenizhinin@gmail.com');
INSERT INTO Persona VALUES (126, 1, 'Alexandra', 'Deedrick', 'Cra 12 # 22 20', 'alexandradeedrick@gmail.com');
INSERT INTO Persona VALUES (127, 14, 'Maddie', 'Metzger', 'Cra 4 # 15 29', 'maddiemetzger@gmail.com');
INSERT INTO Persona VALUES (128, 16, 'Eloisa', 'Aptaker', 'Cra 11 # 16N 13', 'eloisaaptaker@gmail.com');
INSERT INTO Persona VALUES (129, 12, 'Erminie', 'Sloboda', 'Cra 1 # 7 6', 'erminiesloboda@gmail.com');
INSERT INTO Persona VALUES (130, 1, 'Jeanne', 'Pabellon', 'Cra 8 # 13 19', 'jeannepabellon@gmail.com');
INSERT INTO Persona VALUES (131, 6, 'Adriane', 'Barlass', 'Cra 12 # 17N 14', 'adrianebarlass@gmail.com');
INSERT INTO Persona VALUES (132, 4, 'Margo', 'Hever', 'Cra 18 # 2 23', 'margohever@gmail.com');
INSERT INTO Persona VALUES (133, 6, 'Georgianna', 'Scholfield', 'Cra 8 # 28 29', 'georgiannascholfield@gmail.com');
INSERT INTO Persona VALUES (134, 5, 'Francene', 'Maffioli', 'Cra 4 # 18 13', 'francenemaffioli@gmail.com');

----Tabla Telefono----
insert into telefono(id,persona_cedula,tipo) values (110,110,'fijo');
insert into telefono(id,persona_cedula,tipo) values (111,111,'fijo');
insert into telefono(id,persona_cedula,tipo) values (112,112,'celular');
insert into telefono(id,persona_cedula,tipo) values (113,113,'fijo');
insert into telefono(id,persona_cedula,tipo) values (114,114,'celular');
insert into telefono(id,persona_cedula,tipo) values (115,115,'fijo');
insert into telefono(id,persona_cedula,tipo) values (116,116,'celular');
insert into telefono(id,persona_cedula,tipo) values (117,117,'fijo');
insert into telefono(id,persona_cedula,tipo) values (118,118,'fijo');
insert into telefono(id,persona_cedula,tipo) values (119,119,'celular');
insert into telefono(id,persona_cedula,tipo) values (120,120,'celular');
insert into telefono(id,persona_cedula,tipo) values (121,121,'fijo');
insert into telefono(id,persona_cedula,tipo) values (122,122,'celular');
insert into telefono(id,persona_cedula,tipo) values (123,123,'fijo');
insert into telefono(id,persona_cedula,tipo) values (124,124,'celular');
insert into telefono(id,persona_cedula,tipo) values (125,125,'fijo');
insert into telefono(id,persona_cedula,tipo) values (126,126,'fijo');
insert into telefono(id,persona_cedula,tipo) values (127,127,'celular');
insert into telefono(id,persona_cedula,tipo) values (128,128,'celular');
insert into telefono(id,persona_cedula,tipo) values (129,129,'fijo');
insert into telefono(id,persona_cedula,tipo) values (130,130,'fijo');
insert into telefono(id,persona_cedula,tipo) values (131,131,'fijo');
insert into telefono(id,persona_cedula,tipo) values (132,132,'celular');
insert into telefono(id,persona_cedula,tipo) values (133,133,'celular');
insert into telefono(id,persona_cedula,tipo) values (134,134,'fijo');

----Tabla Regimen----
INSERT INTO Regimen VALUES (1, 'Todo Incluido');
INSERT INTO Regimen VALUES (2, 'Solo Desayuno');
INSERT INTO Regimen VALUES (3, 'Solo Almuerzo');
INSERT INTO Regimen VALUES (4, 'Solo Cena');
INSERT INTO Regimen VALUES (5, 'Desayuno y Almuerzo');
INSERT INTO Regimen VALUES (6, 'Almuerzo y Cena');
INSERT INTO Regimen VALUES (7, 'Desayuno y Cena');
INSERT INTO Regimen VALUES (8, 'Solo Hospedaje');

----Tabla HospedajeRegimen----
insert into HospedajeRegimen values(1,1);
insert into HospedajeRegimen values(2,2);
insert into HospedajeRegimen values(3,3);
insert into HospedajeRegimen values(4,4);
insert into HospedajeRegimen values(5,5);
insert into HospedajeRegimen values(6,6);
insert into HospedajeRegimen values(7,7);
insert into HospedajeRegimen values(8,8);
insert into HospedajeRegimen values(9,1);
insert into HospedajeRegimen values(10,2);
insert into HospedajeRegimen values(11,3);
insert into HospedajeRegimen values(12,4);
insert into HospedajeRegimen values(13,5);
insert into HospedajeRegimen values(14,6);
insert into HospedajeRegimen values(15,7);
insert into HospedajeRegimen values(16,8);
insert into HospedajeRegimen values(17,1);
insert into HospedajeRegimen values(18,2);
insert into HospedajeRegimen values(19,3);
insert into HospedajeRegimen values(20,4);
insert into HospedajeRegimen values(21,5);
insert into HospedajeRegimen values(22,6);
insert into HospedajeRegimen values(23,1);
insert into HospedajeRegimen values(24,7);
insert into HospedajeRegimen values(25,8);
insert into HospedajeRegimen values(1,1);
insert into HospedajeRegimen values(2,1);
insert into HospedajeRegimen values(3,2);
insert into HospedajeRegimen values(4,3);
insert into HospedajeRegimen values(5,4);
insert into HospedajeRegimen values(10,5);
insert into HospedajeRegimen values(3,6);
insert into HospedajeRegimen values(1,7);
insert into HospedajeRegimen values(4,8);
insert into HospedajeRegimen values(17,1);

----Tabla Paquete----
insert into Paquete values(1,'Parques temáticos, todo el día, precio por persona', 100000);
insert into Paquete values(2,'Excursiones, todo el día, precio por persona', 50000);
insert into Paquete values(3,'CityTours, todo el día, precio por persona', 40000);
insert into Paquete values(4,'Guía turístico, hasta 4 horas, para 4 personas', 50000);
insert into Paquete values(5,'Alimentos y bebidas, oferta por persona', 50000);
insert into Paquete values(6,'Planes culturales, todo el día, precio por persona', 30000);

----Tabla Factura----
insert into Factura values(1, 110, 1300000,'Con tarjeta de crédito');
insert into Factura values(2, 111, 200000,'Pendiente de pago');
insert into Factura values(3, 112, 450000,null);
insert into Factura values(4, 113, 390000,'Precios en oferta');
insert into Factura values(5, 114, 501000,null);
insert into Factura values(6, 115, 234000,'Paga en efectivo');
insert into Factura values(7, 116, 120000,'Pendiente de pago');
insert into Factura values(8, 117, 350000,'Cancelado');
insert into Factura values(9, 118, 323000,null);
insert into Factura values(10, 119, 49000,'Cancelado');
insert into Factura values(11, 120, 230000,'Pendiente de pago');
insert into Factura values(12, 120, 230000,null);
insert into Factura values(13, 121, 540000,'Paga en efectivo');
insert into Factura values(14, 122, 308000,'Cancelado');
insert into Factura values(15, 123, 800000,null);
insert into Factura values(16, 124, 60000,'Paquete Guía');
insert into Factura values(17, 125, 73000,'Pendiente de pago');
insert into Factura values(18, 126, 108000,'No cancelado');
insert into Factura values(19, 127, 27000,'Paga en efectivo');
insert into Factura values(20, 128, 300000,'Descuento por mal servicio');
insert into Factura values(21, 129, 50000,'Cancelado');
insert into Factura values(22, 130, 45000,'Descuento por aniversario');
insert into Factura values(23, 131, 90000,null);
insert into Factura values(24, 132, 80000,'Cancelado');
insert into Factura values(25, 133, 300000,'Pendiente de pago');

----Tabla Adicional----
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro,costoGps) values(1,'seguro y gps',200000.00,'S001',150000.00,50000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro,costoGps) values(2,'seguro y gps',200000.00,'S001',150000.00,50000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro,costoGps) values(3,'seguro y gps',200000.00,'S001',150000.00,50000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro,costoGps) values(4,'seguro y gps',200000.00,'S001',150000.00,50000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro,costoGps) values(5,'seguro y gps',200000.00,'S001',150000.00,50000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(6,'seguro',150000.00,'S007',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(7,'seguro',150000.00,'S008',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(8,'seguro',150000.00,'S009',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(9,'seguro',150000.00,'S010',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(10,'seguro',150000.00,'S011',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(11,'seguro',150000.00,'S012',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(12,'seguro',150000.00,'S013',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(13,'seguro',150000.00,'S014',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(14,'seguro',150000.00,'S015',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(15,'seguro',150000.00,'S016',150000.00);
insert into Adicional(id,descripcion,total,numSeguro,costoSeguro) values(16,'seguro',150000.00,'S017',150000.00);
insert into Adicional(id,descripcion,total,costoGps) values(17,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(18,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(19,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(20,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(21,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(22,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(23,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(24,'gps',50000.00,50000.00);
insert into Adicional(id,descripcion,total,costoGps) values(25,'gps',50000.00,50000.00);

----Tabla Vehiculo----
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a001','Peugeot','sedán',5,100000,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a002','Toyota','camioneta',5,100000,'alta',null);
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a003','Suzuki','SUV',5,100000,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a004','Lamborghini','Deportivo',2,200000,'alta','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a005','Suzuki','SUV',5,100000,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a006','Renault','camioneta',7,100000,'media','sin placa');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a007','Chevrolet','sedán',5,100000,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a008','Hummer','SUV',4,200000.00,'alta','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a009','Toyota','camioneta',5,100000.00,'media','taller');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a010','Volkswagen','van',5,180000.00,'alta',null);
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a011','Ford','camioneta',7,100000.00,null,'disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a012','Bmw','camioneta',5,100000.00,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a013','Honda','sedán',5,100000.00,null,'disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a014','Peugeot','camioneta',5,100000.00,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a015','Nissan','van',9,100000.00,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a016','Suzuki','van',11,100000.00,'media','taller');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a017','Toyota','camioneta',5,130000.00,'media','taller');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a018','Alfa Romeo','deportivo',4,200000.00,'media','taller');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a019','Bmw','sedán',5,100000.00,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a020','Lexus','sedán',5,100000.00,'alta','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a021','Toyota','camioneta',5,130000.00,null,'taller');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a022','Volkswagen','van',9,130000.00,'media','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a023','Ford','camioneta',5,130000.00,'media',null);
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a024','Bmw','camioneta',7,200000.00,'alta','disponible');
insert into Vehiculo (placa, marca, tipo, capacidad, valorDia, gama, estado) values ('a025','Renault','sedán',5,100000.00,'media','disponible');

----Tabla CompraArticulo----
insert into CompraArticulo values(1,1,DATE'2022-12-01', 3, 10000);
insert into CompraArticulo values(2,2,DATE'2022-12-04', 13, 50000);
insert into CompraArticulo values(3,3,DATE'2018-10-01', 2, 40000);
insert into CompraArticulo values(4,4,DATE'2010-10-01', 23, 50000);
insert into CompraArticulo values(5,5,DATE'2020-12-01', 4, 50000);
insert into CompraArticulo values(6,6,DATE'2021-12-01', 2, 30000);
insert into CompraArticulo values(7,7,DATE'2022-12-01', 3, 10000);
insert into CompraArticulo values(8,8,DATE'2022-12-04', 13, 70000);
insert into CompraArticulo values(9,9,DATE'2018-10-01', 4, 45000);
insert into CompraArticulo values(10,10,DATE'2010-10-01', 3, 90000);
insert into CompraArticulo values(11,11,DATE'2020-12-01', 4, 50000);
insert into CompraArticulo values(12,12,DATE'2021-12-01', 2, 30000);
insert into CompraArticulo values(13,13,DATE'2021-12-01', 2, 30000);
insert into CompraArticulo values(14,14,DATE'2022-12-01', 1, 10000);
insert into CompraArticulo values(15,15,DATE'2022-12-04', 23, 70000);
insert into CompraArticulo values(16,16,DATE'2018-10-01', 4, 45000);
insert into CompraArticulo values(17,17,DATE'2010-10-01', 3, 96000);
insert into CompraArticulo values(18,18,DATE'2020-12-01', 4, 50900);
insert into CompraArticulo values(19,19,DATE'2021-12-01', 2, 34000);
insert into CompraArticulo values(20,20,DATE'2020-10-01', 3, 90000);
insert into CompraArticulo values(21,21,DATE'2022-12-01', 4, 50000);
insert into CompraArticulo values(22,22,DATE'2019-12-01', 5, 303300);
insert into CompraArticulo values(23,23,DATE'2021-12-01', 2, 80000);
insert into CompraArticulo values(24,24,DATE'2018-10-01', 4, 45000);
insert into CompraArticulo values(25,25,DATE'2010-10-01', 3, 96000);

----Tabla Articulo----
insert into Articulo values(1,1,'Jarrón','Artesanías', 'Alfarería');
insert into Articulo values(2,2,'Mochilas','Artesanías','Artesanías emblemáticas');
insert into Articulo values(3,3,'Sombrero','Artesanías','Artesanías emblemáticas');
insert into Articulo values(4,4,'Gorro','Artesanías', 'Bordado');
insert into Articulo values(5,5,'Bolso','Artesanías', 'Artesanías en cuero');
insert into Articulo values(6,6,'Foto','Recordatorios','Digital y físico');
insert into Articulo values(7,7,'Imágenes Religiosas','Recordatorios', 'En yeso');
insert into Articulo values(8,1,'Jarrón','Artesanías', 'Alfarería');
insert into Articulo values(9,2,'Mochilas','Artesanías','Artesanías emblemáticas');
insert into Articulo values(10,3,'Sombrero','Artesanías','Artesanías emblemáticas');
insert into Articulo values(11,4,'Gorro','Artesanías', 'Bordado');
insert into Articulo values(12,5,'Bolso','Artesanías', 'Artesanías en cuero');
insert into Articulo values(13,6,'Foto','Recordatorios',null);
insert into Articulo values(14,7,'Imágenes Religiosas','Recordatorios', 'En madera');
insert into Articulo values(15,1,'Jarrón','Artesanías', 'Alfarería');
insert into Articulo values(16,2,'Mochilas','Artesanías','Artesanías emblemáticas');
insert into Articulo values(17,3,'Sombrero','Artesanías',null);
insert into Articulo values(18,4,'Gorro','Artesanías', 'Bordado');
insert into Articulo values(19,5,'Bolso','Artesanías', 'Artesanías en cuero');
insert into Articulo values(20,6,'Foto','Recordatorios',null);
insert into Articulo values(21,7,'Imágenes Religiosas','Recordatorios', 'En madera');
insert into Articulo values(22,2,'Pectoral','Artesanías','Artesanías emblemáticas');
insert into Articulo values(23,3,'Sombrero','Artesanías','Artesanías emblemáticas');
insert into Articulo values(24,4,'Chal','Artesanías', 'Bordado');
insert into Articulo values(25,5,'Bolso','Artesanías', 'Artesanías en cuero');

----Tabla ReservaVeh----
insert into ReservaVeh values(1,'a001',1,10000,DATE'2022-12-01',DATE'2022-12-06',1);
insert into ReservaVeh values(2,'a002',2,10500,DATE'2022-10-01',DATE'2022-10-07',2);
insert into ReservaVeh values(3,'a003',3,14000,DATE'2022-02-01',DATE'2022-02-09',3);
insert into ReservaVeh values(4,'a004',4,10000,DATE'2022-06-01',DATE'2022-06-06',4);
insert into ReservaVeh values(5,'a005',5,10000,DATE'2022-12-01',DATE'2022-12-03',5);
insert into ReservaVeh values(6,'a006',6,5000,DATE'2022-06-01',DATE'2022-07-06',6);
insert into ReservaVeh values(7,'a007',7,3000,DATE'2022-09-01',DATE'2022-09-06',2);
insert into ReservaVeh values(8,'a008',8,10000,DATE'2022-12-01',DATE'2022-12-06',1);
insert into ReservaVeh values(9,'a009',9,10000,DATE'2022-03-01',DATE'2022-03-06',2);
insert into ReservaVeh values(10,'a010',10,10000,DATE'2022-11-01',DATE'2022-12-06',3);
insert into ReservaVeh values(11,'a011',11,70000,DATE'2022-02-01',DATE'2022-02-06',4);
insert into ReservaVeh values(12,'a012',12,16700,DATE'2022-11-01',DATE'2022-11-06',5);
insert into ReservaVeh values(13,'a013',13,15000,DATE'2022-12-01',DATE'2022-12-06',1);
insert into ReservaVeh values(14,'a014',14,10000,DATE'2022-03-01',DATE'2022-03-06',2);
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(15,'a015',15,10000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(16,'a016',16,10000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(17,'a017',17,10000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(18,'a018',18,10000,DATE'2022-08-01',DATE'2022-08-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(19,'a019',19,18000,DATE'2022-09-01',DATE'2022-10-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(20,'a020',20,810000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(21,'a021',21,90000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(22,'a022',22,109000,DATE'2022-04-01',DATE'2022-05-09');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(23,'a023',23,80000,DATE'2022-12-01',DATE'2022-12-06');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(24,'a024',24,40000,DATE'2022-05-01',DATE'2022-06-02');
insert into ReservaVeh (id,vehiculo_placa, factura_idfactura, costo, fechaInicio, fechaDevolucion)
values(25,'a025',25,30000,DATE'2022-12-01',DATE'2022-12-06');

----Tabla Instalacion----
insert into Instalacion values(1,1,'piscina','funcional');
insert into Instalacion values(2,2,'cancha golf',null);
insert into Instalacion values(3,2,'acuario','en mantenimiento');
insert into Instalacion values(4,3,'jacuzzi','funcional');
insert into Instalacion values(5,4,'sauna',null);
insert into Instalacion values(6,5,'piscina','funcional');
insert into Instalacion values(7,6,'piscina','en mantenimiento');
insert into Instalacion values(8,7,'cancha fútbol','funcional');
insert into Instalacion values(9,1,'sauna','funcional');
insert into Instalacion values(10,11,'piscina','funcional');
insert into Instalacion values(11,3,'karts','funcional');
insert into Instalacion values(12,9,'piscina','funcional');
insert into Instalacion values(13,10,'piscina','estado');
insert into Instalacion values(14,1,'gym','funcional');
insert into Instalacion values(15,22,'piscina','funcional');
insert into Instalacion values(16,13,'spa',null);
insert into Instalacion values(17,8,'piscina','en mantenimiento');
insert into Instalacion values(18,4,'piscina',null);
insert into Instalacion values(19,24,'gym','en mantenimiento');
insert into Instalacion values(20,6,'cancha tennis','funcional');
insert into Instalacion values(21,17,'piscina','funcional');
insert into Instalacion values(22,25,'spa','funcional');
insert into Instalacion values(23,2,'spa','en mantenimiento');
insert into Instalacion values(24,15,'piscina','funcional');
insert into Instalacion values(25,20,'piscina','funcional');

----Tabla Habitacion----
insert into Habitacion values (1,1,'alto',120000.00,'disponible');
insert into Habitacion values (2,1,'medio',90000.00,'disponible');
insert into Habitacion values (3,2,'alto',120000.00,'disponible');
insert into Habitacion values (4,2,'alto',120000.00,'disponible');
insert into Habitacion values (5,3,'medio',90000.00,'disponible');
insert into Habitacion values (6,4,'alto',120000.00,'ocupada');
insert into Habitacion values (7,5,'medio',90000.00,'disponible');
insert into Habitacion values (8,6,'medio',90000.00,'disponible');
insert into Habitacion values (9,7,'alto',120000.00,'disponible');
insert into Habitacion values (10,7,'alto',120000.00,'disponible');
insert into Habitacion values (11,8,'medio',90000.00,'reservada');
insert into Habitacion values (12,9,'alto',120000.00,'ocupada');
insert into Habitacion values (13,10,'medio',90000.00,'disponible');
insert into Habitacion values (14,11,'medio',90000.00,'disponible');
insert into Habitacion values (15,11,'alto',120000.00,'disponible');
insert into Habitacion values (16,12,'medio',90000.00,'ocupada');
insert into Habitacion values (17,13,'bajo',50000.00,'disponible');
insert into Habitacion values (18,14,'alto',120000.00,'disponible');
insert into Habitacion values (19,5,'medio',90000.00,'reservada');
insert into Habitacion values (20,3,'alto',120000.00,'disponible');
insert into Habitacion values (21,15,'medio',90000.00,'ocupada');
insert into Habitacion values (22,16,'bajo',50000.00,'disponible');
insert into Habitacion values (23,17,'alto',120000.00,'disponible');
insert into Habitacion values (24,18,'medio',90000.00,'ocupada');
insert into Habitacion values (25,19,'medio',90000.00,'disponible');

----Tabla CompraPaquete----
insert into CompraPaquete (id, paquete_id, factura_idFactura, fecha, estado)
values (1,1,1,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (2,1,2,DATE'2022-05-01','confirmada');
insert into CompraPaquete values (3,2,3,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (4,3,4,DATE'2021-05-02','cancelada');
insert into CompraPaquete values (5,4,5,DATE'2022-01-06','en trámite');
insert into CompraPaquete values (6,5,6,DATE'2022-05-05','confirmada');
insert into CompraPaquete values (7,6,7,DATE'2021-02-06','confirmada');
insert into CompraPaquete values (8,1,8,DATE'2022-05-07','en trámite');
insert into CompraPaquete values (9,2,9,DATE'2022-05-06','cancelada');
insert into CompraPaquete values (10,3,10,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (11,4,11,DATE'2021-04-09','confirmadae');
insert into CompraPaquete values (12,5,12,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (13,6,13,DATE'2022-01-06','en trámite');
insert into CompraPaquete values (14,1,14,DATE'2022-05-12','en trámite');
insert into CompraPaquete values (15,2,15,DATE'2021-05-06','cancelada');
insert into CompraPaquete values (16,3,16,DATE'2022-05-06','confirmada');
insert into CompraPaquete values (17,4,17,DATE'2022-02-11','en trámite');
insert into CompraPaquete values (18,5,18,DATE'2022-05-06','cancelada');
insert into CompraPaquete values (19,6,19,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (20,1,20,DATE'2022-04-06','cancelada');
insert into CompraPaquete values (21,2,21,DATE'2021-05-01','confirmada');
insert into CompraPaquete values (22,3,22,DATE'2022-05-06','confirmada');
insert into CompraPaquete values (23,4,23,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (24,5,25,DATE'2022-02-06','cancelada');
insert into CompraPaquete values (25,6,24,DATE'2021-05-11','cancelada');
insert into CompraPaquete values (26,1,1,DATE'2022-03-06','confirmada');
insert into CompraPaquete values (27,1,2,DATE'2022-02-15','en trámite');
insert into CompraPaquete values (28,2,3,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (29,3,4,DATE'2022-01-07','en trámite');
insert into CompraPaquete values (30,4,5,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (31,5,12,DATE'2022-04-09','confirmada');
insert into CompraPaquete values (32,6,7,DATE'2022-05-06','cancelada');
insert into CompraPaquete values (33,1,18,DATE'2022-03-04','confirmada');
insert into CompraPaquete values (34,2,21,DATE'2022-05-06','en trámite');
insert into CompraPaquete values (35,3,17,DATE'2022-03-06','cancelada');

----Table Reserva----
insert into Reserva(id, factura_idFactura, fecha, fechaInicio, estado, cantidadNoche, valor)
values(1,1,DATE'2022-03-06',DATE'2022-03-06','reservada',2,250000.00);
insert into Reserva values(2,2,DATE'2021-03-06',DATE'2022-04-07','reservada',2,250000.00);
insert into Reserva values(3,3,DATE'2022-03-06',DATE'2022-04-06','cancelada',4,500000.00);
insert into Reserva values(4,4,DATE'2022-03-06',DATE'2022-05-06','reservada',2,250000.00);
insert into Reserva values(5,5,DATE'2021-03-06',DATE'2022-04-08','cancelada',3,750000.00);
insert into Reserva values(6,6,DATE'2022-03-06',DATE'2022-05-06','pendiente',2,250000.00);
insert into Reserva values(7,7,DATE'2022-03-06',DATE'2022-05-06','reservada',2,250000.00);
insert into Reserva values(8,8,DATE'2021-03-06',DATE'2022-04-06','cancelada',3,750000.00);
insert into Reserva values(9,9,DATE'2022-03-05',DATE'2022-04-06','reservada',2,250000.00);
insert into Reserva values(10,10,DATE'2022-03-06',DATE'2022-04-06','reservada',4,500000.00);
insert into Reserva values(11,11,DATE'2021-03-06',DATE'2022-04-06','reservada',2,250000.00);
insert into Reserva values(12,12,DATE'2022-03-06',DATE'2022-04-06','reservada',2,250000.00);
insert into Reserva values(13,13,DATE'2022-03-06',DATE'2022-04-06','cancelada',1,125000.00);
insert into Reserva values(14,14,DATE'2022-03-05',DATE'2022-04-08','reservada',2,250000.00);
insert into Reserva values(15,15,DATE'2021-03-06',DATE'2022-04-06','reservada',5,1250000.00);
insert into Reserva values(16,16,DATE'2022-03-06',DATE'2022-04-08','reservada',2,250000.00);
insert into Reserva values(17,17,DATE'2022-03-09',DATE'2022-04-07','cancelada',1,125000.00);
insert into Reserva values(18,18,DATE'2022-03-06',DATE'2022-04-06','pendiente',2,250000.00);
insert into Reserva values(19,19,DATE'2021-03-06',DATE'2022-04-08','reservada',2,250000.00);
insert into Reserva values(20,20,DATE'2022-03-06',DATE'2022-04-07','cancelada',2,250000.00);
insert into Reserva values(21,21,DATE'2022-03-06',DATE'2022-04-06','reservada',3,750000.00);
insert into Reserva values(22,22,DATE'2021-03-08',DATE'2022-04-06','pendiente',2,250000.00);
insert into Reserva values(23,23,DATE'2022-03-02',DATE'2022-04-09','reservada',2,250000.00);
insert into Reserva values(24,24,DATE'2022-03-06',DATE'2022-04-06','cancelada',1,125000.00);
insert into Reserva values(25,25,DATE'2022-03-07',DATE'2022-04-06','reservada',2,250000.00);

----Tabla ResHabita----
insert into ResHabita values (1,1,20);
insert into ResHabita values (2,2,21);
insert into ResHabita values (3,3,22);
insert into ResHabita values (4,4,23);
insert into ResHabita values (5,5,24);
insert into ResHabita values (6,6,1);
insert into ResHabita values (7,7,2);
insert into ResHabita values (8,8,3);
insert into ResHabita values (9,9,4);
insert into ResHabita values (10,10,5);
insert into ResHabita values (11,11,6);
insert into ResHabita values (12,12,25);
insert into ResHabita values (13,13,1);
insert into ResHabita values (14,14,2);
insert into ResHabita values (15,15,3);
insert into ResHabita values (16,16,4);
insert into ResHabita values (17,17,5);
insert into ResHabita values (18,18,6);
insert into ResHabita values (19,19,7);
insert into ResHabita values (20,20,8);
insert into ResHabita values (21,21,9);
insert into ResHabita values (22,22,10);
insert into ResHabita values (23,23,11);
insert into ResHabita values (24,24,12);
insert into ResHabita values (25,25,13);
insert into ResHabita values (26,1,14);
insert into ResHabita values (27,2,15);
insert into ResHabita values (28,3,16);
insert into ResHabita values (29,4,17);
insert into ResHabita values (30,5,6);
insert into ResHabita values (31,6,7);
insert into ResHabita values (32,7,8);
insert into ResHabita values (33,8,9);
insert into ResHabita values (34,9,18);
insert into ResHabita values (35,10,19);
