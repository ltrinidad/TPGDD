using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace UberFrba.Menu
{
    public class Funcionalidades
    {
        private String username;
        private String rol;
        private List<Funcionalidad> ventanas;

        public Funcionalidades(String username, String rol)
        {
            this.rol = rol;
            this.username = username;
            this.ventanas = new List<Funcionalidad> { 
            new Funcionalidad(1, "ABM de Rol", new Menu_ABM( this.username, this.rol, new FuncionalidadABM( new Abm_Rol.Alta(), new Abm_Rol.Baja_Rol() , new Abm_Rol.Modificacion() ) ) ), // TODO en vez de Alta es AltaOModificacion
            new Funcionalidad(3, "ABM de Cliente", new Menu_ABM(this.username, this.rol, new FuncionalidadABM( new Abm_Cliente.Alta(), new Abm_Cliente.Baja(), new Abm_Cliente.Modificacion() ) ) ), // TODO en vez de Alta es AltaOModificacion
            new Funcionalidad(4, "ABM de Automovil", new Menu_ABM( this.username, this.rol, new FuncionalidadABM( new  Abm_Automovil.Alta_o_Modificacion("Carga de Automovil", true) , new Abm_Automovil.Baja_y_Modificacion(), new Abm_Automovil.Alta_o_Modificacion("Modificar Automovil", false) ) ) ), 
            new Funcionalidad(5, "ABM de Chofer", new Menu_ABM( this.username, this.rol, new FuncionalidadABM(new Abm_Chofer.Alta(), new Abm_Chofer.Baja_y_Modificacion(), new Abm_Chofer.Modificacion() ) ) ),
            new Funcionalidad(2, "Registro de Usuario", new Alta_de_Usuario.Alta_de_Usuario(this.username, this.rol)),
            new Funcionalidad(6, "Registro de Viajes", new Registro_Viajes.Registro_Viajes(this.username, this.rol)),
            new Funcionalidad(7, "Rendicion de cuenta del Chofer", new Rendicion_Al_Chofer.Rendicion_Al_Chofer(this.username, this.rol)),
            new Funcionalidad(8, "Listado Estadistico", new Facturacion_Cliente.Listado_Estadistico(this.username, this.rol)),
            new Funcionalidad(9, "Facturacion a Cliente", new Facturacion_Cliente.Facturacion_Cliente(this.username, this.rol))
            };
        }

 
        public Funcionalidad obtenerFuncionalidad(short codigo)
        { 
            return this.ventanas.Find(func => func.codigo == codigo);
        }
    }
}



