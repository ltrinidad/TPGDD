USE [GD1C2017]
GO

/****** Object:  Schema [LOS_CHATADROIDES]    Script Date: 04/06/2017 17:53:35 ******/
CREATE SCHEMA [LOS_CHATADROIDES] AUTHORIZATION [gd]
GO
/*
//DROP TABLE LOS_CHATADROIDES.Administrador;
//DROP TABLE LOS_CHATADROIDES.Automovil;
//DROP TABLE LOS_CHATADROIDES.Chofer;
//DROP TABLE LOS_CHATADROIDES.Cliente;
//DROP TABLE LOS_CHATADROIDES.Domicilio;
//DROP TABLE LOS_CHATADROIDES.Factura;
//DROP TABLE LOS_CHATADROIDES.Funcionalidad;
//DROP TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol;
//DROP TABLE LOS_CHATADROIDES.Rol;
//DROP TABLE LOS_CHATADROIDES.Rol_X_Usuario;
//DROP TABLE LOS_CHATADROIDES.Turno;
//DROP TABLE LOS_CHATADROIDES.Usuario;
//DROP TABLE LOS_CHATADROIDES.Auto_X_Turno;
//DROP TABLE LOS_CHATADROIDES.Viaje;
//DROP TABLE LOS_CHATADROIDES.Rendicion;
*/


CREATE TABLE LOS_CHATADROIDES.Domicilio
(
	localidad VARCHAR(20) DEFAULT 'Sin Especificar',
	direccion VARCHAR(255),
	nro_piso SMALLINT,
	depto VARCHAR(3),
	PRIMARY KEY (localidad, direccion)
);

CREATE TABLE LOS_CHATADROIDES.Turno
(
	hora_inicio_turno NUMERIC(18,0),
	hora_fin_turno NUMERIC(18,0),
	descripcion VARCHAR(255) NOT NULL,
	valor_del_kilometro NUMERIC(18,2) NOT NULL,
	precio_base NUMERIC(18,2) NOT NULL,
	habilitado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (hora_inicio_turno, hora_fin_turno)
);

CREATE TABLE LOS_CHATADROIDES.Rol
(
	nombre_del_rol VARCHAR(25) PRIMARY KEY,
	habilitado BIT NOT NULL DEFAULT 1
);


CREATE TABLE LOS_CHATADROIDES.Funcionalidad
(
	codigo_funcionalidad TINYINT IDENTITY(1,1) PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);


CREATE TABLE LOS_CHATADROIDES.Cliente
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(255),
	codigo_postal SMALLINT DEFAULT 0,
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Chofer
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(50),
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Administrador
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(50),
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Usuario
(
	username VARCHAR(20) PRIMARY KEY,
	telefono_cliente NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	telefono_chofer NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	telefono_admin NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Administrador(telefono),
	password VARCHAR(30) NOT NULL,
	habilitado BIT NOT NULL DEFAULT 1
);


CREATE TABLE LOS_CHATADROIDES.Rol_X_Usuario
(
	username VARCHAR(20) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Usuario(username),
	nombre_del_rol VARCHAR(25) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rol(nombre_del_rol),
	habilitado BIT NOT NULL DEFAULT 1
	PRIMARY KEY (username, nombre_del_rol)
);


CREATE TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol
(
	nombre_del_rol VARCHAR(25) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rol(nombre_del_rol),
	codigo_funcionalidad TINYINT FOREIGN KEY REFERENCES LOS_CHATADROIDES.Funcionalidad(codigo_funcionalidad), 
	PRIMARY KEY (nombre_del_rol, codigo_funcionalidad)
);



CREATE TABLE LOS_CHATADROIDES.Factura
(
	id_factura NUMERIC(18,0) PRIMARY KEY,
	telefono_cliente NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	fecha_facturacion DATETIME,
	fecha_inicio DATETIME,
	fecha_fin DATETIME,
	importe_total FLOAT
);



CREATE TABLE LOS_CHATADROIDES.Automovil
(
	patente VARCHAR(10) PRIMARY KEY,
	telefono_chofer NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	marca VARCHAR(255),
	modelo VARCHAR(255),
	licencia VARCHAR(26),
	rodado VARCHAR(10),
	habilitado BIT NOT NULL DEFAULT 1
);


CREATE TABLE LOS_CHATADROIDES.Auto_X_Turno
(
	hora_inicio_turno NUMERIC(18,0),
	hora_fin_turno NUMERIC(18,0),
	patente VARCHAR(10) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Automovil(patente),
	FOREIGN KEY (hora_inicio_turno, hora_fin_turno) REFERENCES LOS_CHATADROIDES.Turno(hora_inicio_turno, hora_fin_turno),
	PRIMARY KEY (hora_inicio_turno, hora_fin_turno, patente)
);

CREATE TABLE LOS_CHATADROIDES.Viaje
(
	numero_viaje INTEGER IDENTITY(1,1) PRIMARY KEY,
	telefono_chofer NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	patente VARCHAR(10) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Automovil(patente),
	id_factura NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Factura(id_factura),
	telefono_cliente NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	hora_inicio_turno NUMERIC(18,0),
	hora_fin_turno NUMERIC(18,0),
	fecha_y_hora_inicio_viaje DATETIME,
	fecha_y_hora_fin_viaje DATETIME,
	kilometros_del_viaje NUMERIC(18,0),
	FOREIGN KEY (hora_inicio_turno, hora_fin_turno) REFERENCES LOS_CHATADROIDES.Turno(hora_inicio_turno, hora_fin_turno)
);

CREATE TABLE LOS_CHATADROIDES.Rendicion
(
	nro_rendicion NUMERIC(18,0) PRIMARY KEY,
	fecha DATETIME,
	telefono_chofer NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	numero_viaje INTEGER FOREIGN KEY REFERENCES LOS_CHATADROIDES.Viaje(numero_viaje),
	importe_total NUMERIC(18,2),
	porcentaje_aplicado FLOAT CHECK(porcentaje_aplicado > 0 and porcentaje_aplicado <= 1)
);



/*
Intento de query para ver si un viaje tiene un registro para cuando empezo y otro para cuando termino:

SELECT M1.Chofer_Nombre, M2.Chofer_Nombre, M1.Cliente_Nombre, M2.Cliente_Nombre, M1.Viaje_Fecha, M2.Viaje_Fecha
FROM gd_esquema.Maestra M1 JOIN gd_esquema.Maestra M2
	ON(CONVERT(date, M1.Viaje_Fecha) = CONVERT(date, M2.Viaje_Fecha) 
		AND M1.Chofer_Nombre = M2.Chofer_Nombre
		AND M1.Chofer_Apellido = M2.Chofer_Apellido
		AND M1.Cliente_Nombre = M2.Cliente_Nombre
		AND M1.Cliente_Apellido = M2.Cliente_Apellido
		AND M1.Turno_Hora_Inicio = M2.Turno_Hora_Inicio
		AND M1.Auto_Patente = M2.Auto_Patente)
where CONVERT(time, M1.Viaje_Fecha) < CONVERT(time, M2.Viaje_Fecha)
ORDER BY 5, 6

*/

/*  -------------------------------------------------------- MIGRACION  --------------------------------------------------------  */

-- Cargar tabla Domicilio
CREATE PROCEDURE Migrar_Domicilio 
AS
BEGIN 
	 DECLARE direccion CURSOR FOR 
	 SELECT Cliente_Direccion as dir
		FROM gd_esquema.Maestra
     UNION
	 SELECT Chofer_Direccion
		FROM gd_esquema.Maestra
	 
	 DECLARE @direccion_x_registro VARCHAR(255);

	 OPEN direccion;
	 FETCH direccion INTO @direccion_x_registro;

	  WHILE (@@FETCH_STATUS = 0)
		BEGIN	
			INSERT INTO LOS_CHATADROIDES.Domicilio (direccion) VALUES (@direccion_x_registro);
			FETCH direccion INTO @direccion_x_registro;
		END 
	 CLOSE direccion;
	 DEALLOCATE direccion;
END

/*
drop procedure Migrar_Domicilio;
exec Migrar_Domicilio;
delete LOS_CHATADROIDES.Domicilio;
select * from LOS_CHATADROIDES.Domicilio;
*/

-- Cargar tabla Turno
CREATE PROCEDURE Migrar_Turno
AS
BEGIN
	DECLARE turnos_cursor CURSOR FOR
	SELECT Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Descripcion, Turno_Valor_Kilometro, Turno_Precio_Base 
	FROM gd_esquema.Maestra 
	GROUP BY Turno_Hora_Inicio, Turno_Hora_Fin, Turno_Descripcion, Turno_Valor_Kilometro, Turno_Precio_Base 

	DECLARE @hora_inicio NUMERIC(18,0);
	DECLARE @hora_fin NUMERIC(18,0);
	DECLARE @descripcion VARCHAR(255);
	DECLARE @valor_km NUMERIC(18,2);
	DECLARE @precio_base NUMERIC(18,2);

	OPEN turnos_cursor;
	FETCH turnos_cursor INTO @hora_inicio, @hora_fin, @descripcion, @valor_km, @precio_base;

	WHILE (@@FETCH_STATUS = 0)
		BEGIN	
			INSERT INTO LOS_CHATADROIDES.Turno (hora_inicio_turno, hora_fin_turno, descripcion, valor_del_kilometro, precio_base) 
			VALUES (@hora_inicio, @hora_fin, @descripcion, @valor_km, @precio_base);
			FETCH turnos_cursor INTO @hora_inicio, @hora_fin, @descripcion, @valor_km, @precio_base;
		END 
	 CLOSE turnos_cursor;
	 DEALLOCATE turnos_cursor;
END
/*
EXEC Migrar_Turno;
DROP procedure Migrar_Turno;
select * from LOS_CHATADROIDES.Turno;
*/

-- Cargar tabla Rol

INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Chofer');
INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Cliente');
INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Administrador');

-- Cargar tabla Funcionalidades

INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Rol');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Login');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Registro de Usuario');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Cliente');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Automovil');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Chofer');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Registro de Viajes');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Rendicion de cuenta del Chofer');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Listado Estadistico');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Facturacion a Cliente');


-- Cargar tabla Cliente
CREATE PROCEDURE Migrar_Cliente
AS
BEGIN
	DECLARE clientes_cursor CURSOR FOR
	SELECT Cliente_Apellido, Cliente_Nombre, Cliente_Direccion, Cliente_Dni, Cliente_Mail, Cliente_Fecha_Nac,  Cliente_Telefono
	FROM gd_esquema.Maestra
	GROUP BY Cliente_Apellido, Cliente_Nombre, Cliente_Direccion, Cliente_Dni, Cliente_Mail, Cliente_Fecha_Nac,  Cliente_Telefono

	DECLARE @telefono NUMERIC(18,0);
	DECLARE @direccion VARCHAR(255);
	DECLARE @dni NUMERIC(18,0);
	DECLARE @mail VARCHAR(255);
	DECLARE @fecha_de_nac DATETIME;
	DECLARE @nombre VARCHAR(255);
	DECLARE @apellido VARCHAR(255);

	OPEN clientes_cursor
	FETCH clientes_cursor INTO @apellido, @nombre, @direccion, @dni, @mail, @fecha_de_nac, @telefono
	WHILE (@@FETCH_STATUS = 0)

		BEGIN
			INSERT INTO LOS_CHATADROIDES.Cliente (telefono, direccion, nombre, apellido, dni, fecha_de_nacimiento, mail)
				   VALUES (@telefono, @direccion, @nombre, @apellido, @dni, @fecha_de_nac, @mail);
			FETCH clientes_cursor INTO @apellido, @nombre, @direccion, @dni, @mail, @fecha_de_nac, @telefono;
		END
		CLOSE clientes_cursor;
		DEALLOCATE clientes_cursor;
END





/*
CREATE TABLE LOS_CHATADROIDES.Cliente
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20),
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(255),
	codigo_postal SMALLINT NOT NULL,
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);*/


