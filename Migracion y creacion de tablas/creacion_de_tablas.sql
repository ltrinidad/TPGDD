/*
DROP TABLE LOS_CHATADROIDES.Administrador;
DROP TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol;
DROP TABLE LOS_CHATADROIDES.Rol_X_Usuario;
DROP TABLE LOS_CHATADROIDES.Auto_X_Turno;
DROP TABLE LOS_CHATADROIDES.Viaje;
DROP TABLE LOS_CHATADROIDES.Automovil;
DROP TABLE LOS_CHATADROIDES.Rendicion;
DROP TABLE LOS_CHATADROIDES.Chofer;
DROP TABLE LOS_CHATADROIDES.Factura;
DROP TABLE LOS_CHATADROIDES.Cliente;
DROP TABLE LOS_CHATADROIDES.Domicilio;
DROP TABLE LOS_CHATADROIDES.Funcionalidad;
DROP TABLE LOS_CHATADROIDES.Rol;
DROP TABLE LOS_CHATADROIDES.Turno;
DROP TABLE LOS_CHATADROIDES.Usuario;
*/

-----------------------DROP PROCEDURES
/*
DROP PROCEDURE Migrar_Domicilios;
DROP PROCEDURE Migrar_Turnos;
DROP PROCEDURE Cargar_Funcionalidades_X_Rol;
DROP PROCEDURE Migrar_Clientes;
DROP PROCEDURE Migrar_Choferes;
DROP PROCEDURE Asignar_Roles_A_Usuarios; 
*/

CREATE TABLE LOS_CHATADROIDES.Usuario--
(
	username VARCHAR(50) PRIMARY KEY,
	password VARCHAR(50) NOT NULL,
	habilitado BIT NOT NULL DEFAULT 1
);


CREATE TABLE LOS_CHATADROIDES.Domicilio--
(
	localidad VARCHAR(20),
	direccion VARCHAR(255),
	nro_piso SMALLINT,
	depto VARCHAR(3),
	PRIMARY KEY (localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Turno--
(
	hora_inicio_turno NUMERIC(18,0),
	hora_fin_turno NUMERIC(18,0),
	descripcion VARCHAR(255) NOT NULL,
	valor_del_kilometro NUMERIC(18,2) NOT NULL,
	precio_base NUMERIC(18,2) NOT NULL,
	habilitado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (hora_inicio_turno, hora_fin_turno)
);

CREATE TABLE LOS_CHATADROIDES.Rol--
(
	nombre_del_rol VARCHAR(25) PRIMARY KEY,
	habilitado BIT NOT NULL DEFAULT 1
);


CREATE TABLE LOS_CHATADROIDES.Funcionalidad--
(
	codigo_funcionalidad TINYINT IDENTITY(1,1) PRIMARY KEY,
	descripcion VARCHAR(50) NOT NULL
);


CREATE TABLE LOS_CHATADROIDES.Funcionalidad_X_Rol--
(
	nombre_del_rol VARCHAR(25) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rol(nombre_del_rol),
	codigo_funcionalidad TINYINT FOREIGN KEY REFERENCES LOS_CHATADROIDES.Funcionalidad(codigo_funcionalidad), 
	PRIMARY KEY (nombre_del_rol, codigo_funcionalidad)
);


CREATE TABLE LOS_CHATADROIDES.Cliente--
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) NOT NULL DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(255),
	codigo_postal SMALLINT NOT NULL DEFAULT 0,
	username VARCHAR(50) UNIQUE NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Usuario(username),
	habilitado BIT NOT NULL DEFAULT 1,
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Chofer--
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) NOT NULL DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(50),
	username VARCHAR(50) UNIQUE NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Usuario(username),
	habilitado BIT NOT NULL DEFAULT 1,
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Administrador--
(
	telefono NUMERIC(18,0) PRIMARY KEY,
	localidad VARCHAR(20) NOT NULL DEFAULT 'Sin Especificar',
	direccion VARCHAR(255) NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido VARCHAR(255) NOT NULL,
	dni NUMERIC(18,0) NOT NULL,
	fecha_de_nacimiento DATETIME NOT NULL,
	mail VARCHAR(50),
	username VARCHAR(50) UNIQUE NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Usuario(username),
	habilitado BIT NOT NULL DEFAULT 1,
	FOREIGN KEY (localidad, direccion) REFERENCES LOS_CHATADROIDES.Domicilio(localidad, direccion)
);


CREATE TABLE LOS_CHATADROIDES.Rol_X_Usuario--
(
	username VARCHAR(50) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Usuario(username),
	nombre_del_rol VARCHAR(25) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rol(nombre_del_rol),
	habilitado BIT NOT NULL DEFAULT 1,
	PRIMARY KEY (username, nombre_del_rol)
);


CREATE TABLE LOS_CHATADROIDES.Factura--
(
	id_factura NUMERIC(18,0) PRIMARY KEY,
	telefono_cliente NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	fecha_facturacion DATETIME NOT NULL,
	fecha_inicio DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	importe_total FLOAT NOT NULL
);


CREATE TABLE LOS_CHATADROIDES.Automovil--
(
	patente VARCHAR(10) PRIMARY KEY,
	telefono_chofer NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	marca VARCHAR(255) NOT NULL,
	modelo VARCHAR(255) NOT NULL,
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


CREATE TABLE LOS_CHATADROIDES.Rendicion
(
	nro_rendicion NUMERIC(18,0) PRIMARY KEY,
	fecha DATETIME NOT NULL,
	telefono_chofer NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	importe_total NUMERIC(18,2) NOT NULL,
	porcentaje_aplicado FLOAT CHECK(porcentaje_aplicado > 0 AND porcentaje_aplicado <= 1)
);  


CREATE TABLE LOS_CHATADROIDES.Viaje
(
	numero_viaje INTEGER IDENTITY(1,1) PRIMARY KEY,
	nro_rendicion NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Rendicion(nro_rendicion),
	telefono_chofer NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Chofer(telefono),
	patente VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Automovil(patente),
	id_factura NUMERIC(18,0) FOREIGN KEY REFERENCES LOS_CHATADROIDES.Factura(id_factura),
	telefono_cliente NUMERIC(18,0) NOT NULL FOREIGN KEY REFERENCES LOS_CHATADROIDES.Cliente(telefono),
	hora_inicio_turno NUMERIC(18,0) NOT NULL,
	hora_fin_turno NUMERIC(18,0) NOT NULL,
	fecha_y_hora_inicio_viaje DATETIME NOT NULL,
	fecha_y_hora_fin_viaje DATETIME NOT NULL,
	kilometros_del_viaje NUMERIC(18,0) NOT NULL,
	FOREIGN KEY (hora_inicio_turno, hora_fin_turno) REFERENCES LOS_CHATADROIDES.Turno(hora_inicio_turno, hora_fin_turno)
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
CREATE PROCEDURE Migrar_Domicilios
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
			INSERT INTO LOS_CHATADROIDES.Domicilio (localidad, direccion) VALUES ('Sin Especificar', @direccion_x_registro);
			FETCH direccion INTO @direccion_x_registro;
		END 
	 CLOSE direccion;
	 DEALLOCATE direccion;
END

/*
drop procedure Migrar_Domicilio;
exec Migrar_Domicilios;
delete LOS_CHATADROIDES.Domicilio;
select * from LOS_CHATADROIDES.Domicilio;
*/

-- Cargar tabla Turno
CREATE PROCEDURE Migrar_Turnos
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


-- Cargar tabla Funcionalidad_X_Rol
CREATE PROCEDURE Cargar_Funcionalidades_X_Rol
AS
BEGIN
	DECLARE funcs_cursor CURSOR FOR
	SELECT codigo_funcionalidad FROM LOS_CHATADROIDES.Funcionalidad

	DECLARE @cod_func TINYINT;
	
	OPEN funcs_cursor
	FETCH funcs_cursor INTO @cod_func

	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			INSERT INTO LOS_CHATADROIDES.Funcionalidad_X_Rol 
				(nombre_del_rol, codigo_funcionalidad) VALUES ('Administrador', @cod_func);

			FETCH funcs_cursor INTO @cod_func
		END

	CLOSE funcs_cursor;
	DEALLOCATE funcs_cursor;
END

-- Cargar tabla Cliente
-- Ponerle el nombre de usuario como nombre + apellido
CREATE PROCEDURE Migrar_Clientes
AS
BEGIN
	DECLARE clientes_cursor CURSOR FOR
	SELECT Cliente_Apellido, Cliente_Nombre, Cliente_Direccion, Cliente_Dni, Cliente_Mail, Cliente_Fecha_Nac, Cliente_Telefono
	FROM gd_esquema.Maestra
	GROUP BY Cliente_Apellido, Cliente_Nombre, Cliente_Direccion, Cliente_Dni, Cliente_Mail, Cliente_Fecha_Nac, Cliente_Telefono

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
			IF( NOT EXISTS (SELECT username FROM LOS_CHATADROIDES.Usuario WHERE username = @nombre + '_' + @apellido) )
				BEGIN
					INSERT INTO LOS_CHATADROIDES.Usuario (username, password)
						VALUES (@nombre + '_' + @apellido, @nombre + '_' + @apellido);
				END;

			INSERT INTO LOS_CHATADROIDES.Cliente (telefono, direccion, nombre, apellido, dni, fecha_de_nacimiento, mail, username)
				   VALUES (@telefono, @direccion, @nombre, @apellido, @dni, @fecha_de_nac, @mail, @nombre + '_' + @apellido);
			/*

			FIXME Hay que hacer la funcion que encripte para tardar menos

			IF( NOT EXISTS (SELECT username 
								FROM LOS_CHATADROIDES.Usuario 
								WHERE username = @nombre + '_' + @apellido) )

				INSERT INTO LOS_CHATADROIDES.Usuario (username, password)
					VALUES (@nombre + '_' + @apellido, generar_contraseña(@nombre + '_' + @apellido));

			*/
			FETCH clientes_cursor INTO @apellido, @nombre, @direccion, @dni, @mail, @fecha_de_nac, @telefono;
		END
		CLOSE clientes_cursor;
		DEALLOCATE clientes_cursor;
END

CREATE PROCEDURE Migrar_Choferes
AS
BEGIN
	DECLARE choferes_cursor CURSOR FOR
	SELECT Chofer_Apellido, Chofer_Nombre, Chofer_Direccion, Chofer_Dni, Chofer_Fecha_Nac,  Chofer_Telefono, Chofer_Mail
	FROM gd_esquema.Maestra
	GROUP BY Chofer_Apellido, Chofer_Nombre, Chofer_Direccion, Chofer_Dni, Chofer_Fecha_Nac, Chofer_Telefono, Chofer_Mail

	DECLARE @telefono NUMERIC(18,0);
	DECLARE @direccion VARCHAR(255);
	DECLARE @dni NUMERIC(18,0);
	DECLARE @mail VARCHAR(255);
	DECLARE @fecha_de_nac DATETIME;
	DECLARE @nombre VARCHAR(255);
	DECLARE @apellido VARCHAR(255);
	
	OPEN choferes_cursor
	FETCH choferes_cursor INTO @apellido, @nombre, @direccion, @dni, @fecha_de_nac, @telefono, @mail
	
	WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF( NOT EXISTS (SELECT username FROM LOS_CHATADROIDES.Usuario WHERE username = @nombre + '_' + @apellido) )
				BEGIN
					INSERT INTO LOS_CHATADROIDES.Usuario (username, password)
						VALUES (@nombre + '_' + @apellido, @nombre + '_' + @apellido);
				END;

			INSERT INTO LOS_CHATADROIDES.Chofer (telefono, direccion, nombre, apellido, dni, fecha_de_nacimiento, mail, username)
				   VALUES (@telefono, @direccion, @nombre, @apellido, @dni, @fecha_de_nac, @mail, @nombre + '_' + @apellido);

			FETCH choferes_cursor INTO @apellido, @nombre, @direccion, @dni, @fecha_de_nac, @telefono, @mail;
		END
		CLOSE choferes_cursor;
		DEALLOCATE choferes_cursor;
END
		
CREATE PROCEDURE Asignar_Roles_A_Usuarios
AS
BEGIN
	INSERT INTO LOS_CHATADROIDES.Rol_X_Usuario (username, nombre_del_rol) VALUES ('admin', 'Administrador')
	
	DECLARE cliente_cursor CURSOR FOR 
	SELECT username FROM LOS_CHATADROIDES.Cliente

	DECLARE @username VARCHAR(50)

	OPEN cliente_cursor
	FETCH cliente_cursor INTO @username
	
	WHILE(@@FETCH_STATUS = 0)
		BEGIN
			INSERT INTO LOS_CHATADROIDES.Rol_X_Usuario (username, nombre_del_rol) VALUES (@username, 'Cliente')
			FETCH cliente_cursor INTO @username
		END;
	CLOSE cliente_cursor
	DEALLOCATE cliente_cursor

	DECLARE chofer_cursor CURSOR FOR
	SELECT username FROM LOS_CHATADROIDES.Chofer

	DECLARE @username2 VARCHAR(50)

	OPEN chofer_cursor
	FETCH chofer_cursor INTO @username2

	WHILE(@@FETCH_STATUS = 0) 
		BEGIN
			INSERT INTO LOS_CHATADROIDES.Rol_X_Usuario (username, nombre_del_rol) VALUES (@username2, 'Chofer')
			FETCH chofer_cursor INTO @username2
		END;

	CLOSE chofer_cursor
	DEALLOCATE chofer_cursor
END; 

CREATE PROCEDURE Migrar_Factura
AS
BEGIN
	
	DECLARE factura_cursor CURSOR FOR
	SELECT Factura_Fecha, Factura_Fecha_Fin, Factura_Fecha_Inicio, Factura_Nro, Cliente_Telefono
	FROM gd_esquema.Maestra
	GROUP BY Factura_Fecha, Factura_Fecha_Fin, Factura_Fecha_Inicio, Factura_Nro, Cliente_Telefono
	HAVING Factura_Nro IS NOT NULL

	DECLARE @factura_fecha DATETIME
	DECLARE @factura_fecha_fin DATETIME
	DECLARE @factura_fecha_inicio DATETIME
	DECLARE @factura_nro NUMERIC(18,0)
	DECLARE @cliente_telefono NUMERIC(18,0)

	OPEN factura_cursor
	FETCH factura_cursor INTO @factura_fecha, @factura_fecha_fin, @factura_fecha_inicio, @factura_nro, @cliente_telefono 

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO LOS_CHATADROIDES.Factura (fecha_facturacion, fecha_fin, fecha_inicio, id_factura, telefono_cliente, importe_total) 
			VALUES (@factura_fecha, @factura_fecha_fin, @factura_fecha_inicio, @factura_nro, @cliente_telefono, 0)

		FETCH factura_cursor INTO @factura_fecha, @factura_fecha_fin, @factura_fecha_inicio, @factura_nro, @cliente_telefono 
	END;

	CLOSE factura_cursor
	DEALLOCATE factura_cursor
	/*una vez que tengamos los viajes y el precio por turno, 
	volver y calcular el importe total*/
END;


CREATE PROCEDURE Migrar_Autos
AS
BEGIN
	DECLARE autos_cursor CURSOR FOR
	SELECT Auto_Marca, Auto_Modelo, Auto_Patente, Auto_Licencia, Auto_Rodado, Chofer_Telefono 
	FROM gd_esquema.Maestra 
	GROUP BY Auto_Marca, Auto_Modelo, Auto_Patente, Auto_Licencia, Auto_Rodado, Chofer_Telefono

	DECLARE @marca VARCHAR(255)
	DECLARE @modelo VARCHAR(255)
	DECLARE @patente VARCHAR(10)
	DECLARE @licencia VARCHAR(26)
	DECLARE @rodado VARCHAR(10)
	DECLARE @telefono_chofer NUMERIC(18,0)

	OPEN autos_cursor
	FETCH autos_cursor INTO @marca, @modelo, @patente, @licencia, @rodado, @telefono_chofer

	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO LOS_CHATADROIDES.Automovil (marca, modelo, patente, licencia, rodado, telefono_chofer)
			VALUES (@marca, @modelo, @patente, @licencia, @rodado, @telefono_chofer)

		FETCH autos_cursor INTO @marca, @modelo, @patente, @licencia, @rodado, @telefono_chofer
	END

	CLOSE autos_cursor
	DEALLOCATE autos_cursor	
END


/*  -------------------------------------------------------- SCRIPT DE MIGRACION --------------------------------------------------------  */

EXEC Migrar_Domicilios;
EXEC Migrar_Turnos;

INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Chofer');
INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Cliente');
INSERT INTO LOS_CHATADROIDES.Rol (nombre_del_rol) VALUES ('Administrador');

-- Cargar tabla Funcionalidades
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Rol');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Registro de Usuario');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Cliente');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Automovil');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('ABM de Chofer');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Registro de Viajes');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Rendicion de cuenta del Chofer');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Listado Estadistico');
INSERT INTO LOS_CHATADROIDES.Funcionalidad (descripcion) VALUES ('Facturacion a Cliente');

EXEC Cargar_Funcionalidades_X_Rol;
EXEC Migrar_Clientes;
EXEC Migrar_Choferes;

INSERT INTO LOS_CHATADROIDES.Usuario
	(username, password) VALUES ('admin', 'w23e')

INSERT INTO LOS_CHATADROIDES.Administrador 
	(telefono, direccion, nombre, apellido, dni, fecha_de_nacimiento, mail, username) VALUES
		(1, '25 de Mayo 5619', 'Quique', 'Reinosa', 1, '1966-01-01', 'chakl@hotmail.com', 'admin')
	
EXEC Asignar_Roles_A_Usuarios;--cambiar nombre a cargar roles x usuario
EXEC Migrar_Factura;
EXEC Migrar_Autos;
