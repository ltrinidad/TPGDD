using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UberFrba.Menu
{
    public partial class Menu : Form
    {
        public Menu()
        {
            InitializeComponent();
           
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
            this.Close();
            Form seleccionarRol = new Login_Usuario.Seleccionar_Rol();
            seleccionarRol.Show();
        }
    }
}
