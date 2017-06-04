using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UberFrba.Login_Usuario
{
    public partial class Seleccionar_Rol : Form
    {

        public Seleccionar_Rol()
        {
            InitializeComponent();
        }

        private void Seleccionar_Rol_Load(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form menu = new Menu.Menu(/*PASARLE EL ROL QUE SELECCIONO*/);
            menu.Show();
            this.Close();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

       
    }
}
