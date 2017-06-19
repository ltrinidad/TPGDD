using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace UberFrba.Menu
{
    public static class Funcionalidades
    {
        private static List<Funcionalidad> ventanas = new List<Funcionalidad> { 
            new Funcionalidad(1, "ABM de Rol", new Menu_ABM()),
            new Funcionalidad(3, "ABM de Cliente", new Menu_ABM()),
            new Funcionalidad(4, "ABM de Automovil", new Menu_ABM()),
            new Funcionalidad(5, "ABM de Chofer", new Menu_ABM()),
            new Funcionalidad(2, "Registro de Usuario", new Alta_de_Usuario.Alta_de_Usuario()),
            new Funcionalidad(6, "Registro de Viajes", new Registro_Viajes.Registro_Viajes()),
            new Funcionalidad(7, "Rendicion de cuenta del Chofer", new Rendicion_Al_Chofer.Rendicion_Al_Chofer()),
            new Funcionalidad(8, "Listado Estadistico", new Facturacion_Cliente.Listado_Estadistico()),
            new Funcionalidad(9, "Facturacion a Cliente", new Facturacion_Cliente.Facturacion_Cliente())
        };

        public static Funcionalidad ObtenerFuncionalidad(short codigo)
        { 
            return ventanas.Find(func => func.codigo == codigo);
        }
    }
}
