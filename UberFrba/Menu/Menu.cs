using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using UberFrba.Conexion;
using System.Data.SqlClient;
using UberFrba.Login_Usuario;

namespace UberFrba.Menu
{
    public partial class Menu : Form
    {   
        private String rol;
        private String username;
        public Menu(String rol, String username)
        {
            InitializeComponent();
            this.rol = rol;
            this.username = username;
            this.cargarFuncionalidades();
        }

        private void Menu_Load(object sender, EventArgs e)
        {
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // DEPENDE DE LA ACCION QUE HAYA ELEGIDO
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form seleccionarRol = new Seleccionar_Rol(username);
            seleccionarRol.Show();
            this.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
        private void cargarFuncionalidades()
        {
            SqlDataReader funcionalidades = this.leerFuncionalidades();

            while (funcionalidades.Read())
                this.comboBox1.Items.Add(funcionalidades.GetString(0));

            funcionalidades.Close();
        }

        private SqlDataReader leerFuncionalidades()
        {
            return DBConexion.ResolverConsulta("SELECT descripcion" 
                                             + " FROM LOS_CHATADROIDES.Funcionalidad_X_Rol FXR JOIN LOS_CHATADROIDES.Funcionalidad F" 
                                             + " ON(FXR.codigo_funcionalidad = F.codigo_funcionalidad)"
                                             + " WHERE FXR.nombre_del_rol = '" + rol + "'");
        }
    }
}
