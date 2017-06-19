using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using UberFrba.Conexion;

namespace UberFrba.Login_Usuario
{
    public partial class Seleccionar_Rol : Form
    {

        private String username;

        public Seleccionar_Rol(String username)
        {
            InitializeComponent();
            this.username = username;            
            this.cargarRoles();
        }

        private void Seleccionar_Rol_Load(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void aceptar_Click(object sender, EventArgs e)
        {
            if (selectorRol.SelectedItem == null)
            {
                MessageBox.Show("Debe seleccionar un rol para seguir");
            }
            else
            {
                Form menu = new Menu.Menu(selectorRol.SelectedItem.ToString(), username);
                menu.Show();
                this.Close();
            }
        }

        private void selectorRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
       
        private void cargarRoles()
        {
            SqlDataReader roles = this.leerRoles();

            while (roles.Read())
                this.selectorRol.Items.Add(roles.GetString(0));

            roles.Close();
        }
        
        private SqlDataReader leerRoles()
        {
            return DBConexion.ResolverConsulta("SELECT nombre_del_rol FROM LOS_CHATADROIDES.Rol_X_Usuario WHERE username = '" + username + "'");
        }
    }
}