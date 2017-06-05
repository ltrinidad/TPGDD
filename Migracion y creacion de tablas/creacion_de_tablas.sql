USE [GD1C2017]
GO

/****** Object:  Schema [LOS_CHATADROIDES]    Script Date: 04/06/2017 17:53:35 ******/
CREATE SCHEMA [LOS_CHATADROIDES]
GO

DROP TABLE LOS_CHATADROIDES.Administrador;
DROP TABLE LOS_CHATADROIDES.Automovil;
DROP TABLE LOS_CHATADROIDES.Chofer;
DROP TABLE LOS_CHATADROIDES.Cliente;
DROP TABLE LOS_CHATADROIDES.Domicilio;
DROP TABLE LOS_CHATADROIDES.Factura;
DROP TABLE LOS_CHATADROIDES.Funcionalidad;
DROP TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol;
DROP TABLE LOS_CHATADROIDES.Rol;
DROP TABLE LOS_CHATADROIDES.Rol_X_Usuario;
DROP TABLE LOS_CHATADROIDES.Turno;
DROP TABLE LOS_CHATADROIDES.Usuario;

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
);

CREATE TABLE LOS_CHATADROIDES.Chofer
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20),
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
	localidad VARCHAR(20),
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(50),
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
); 

CREATE TABLE LOS_CHATADROIDES.Domicilio
(
	localidad VARCHAR(20),
	direccion VARCHAR(255),
	nro_piso SMALLINT,
	depto VARCHAR(3),
	PRIMARY KEY (localidad, direccion)
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

CREATE TABLE LOS_CHATADROIDES.Rol
(
	nombre_del_rol VARCHAR(25) PRIMARY KEY,
	habilitado BIT NOT NULL DEFAULT 1
);

CREATE TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol
(
	nombre_del_rol VARCHAR(25) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rol(nombre_del_rol),
	codigo_funcionalidad TINYINT FOREIGN KEY REFERENCES LOS_CHATADROIDES.Funcionalidad(codigo_funcionalidad), 
	PRIMARY KEY (nombre_del_rol, codigo_funcionalidad)
);

CREATE TABLE LOS_CHATADROIDES.Funcionalidad
(
	codigo_funcionalidad TINYINT PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
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

CREATE TABLE LOS_CHATADROIDES.Viaje
(
	numero_viaje INTEGER IDENTITY(1,1) PRIMARY KEY,
	telefono_chofer NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	patente VARCHAR(10) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Automovil(patente),
	id_factura NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Factura(id_factura),
	telefono_cliente NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	hora_inicio_turno NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Turno(hora_inicio_turno),
	hora_fin_turno NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Turno(hora_fin_turno),
	fecha_y_hora_inicio_viaje DATETIME,
	fecha_y_hora_fin_viaje DATETIME,
	kilometros_del_viaje NUMERIC(18,0)
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

CREATE TABLE LOS_CHATADROIDES.Auto_X_Turno
(
	hora_inicio_turno NUMERIC(18,0),
	hora_fin_turno NUMERIC(18,0),
	patente VARCHAR(10) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Automovil(patente),
	FOREIGN KEY (hora_inicio_turno, hora_fin_turno) REFERENCES LOS_CHATADROIDES.Turno(hora_inicio_turno, hora_fin_turno),
	PRIMARY KEY (hora_inicio_turno, hora_fin_turno, patente)
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