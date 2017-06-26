using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UberFrba.Abm_Automovil
{
    public partial class Baja_y_Modificacion : Form 
    {
        private string username;
        private string rol;

        public Baja_y_Modificacion(string p1, string p2)
        {
            InitializeComponent();
            this.username = p1;
            this.rol = p2;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            

        }

        private void baja_Click(object sender, EventArgs e)
        {
            
        }

        private void modificar_Click(object sender, EventArgs e)
        {
            Form modificar = new Alta_o_Modificacion("Guardar cambios", false, this.username, this.rol);
            modificar.Show();
        }

        private void volver_Click(object sender, EventArgs e)
        {
            Form menu = new Menu.Menu(this.username, this.rol);
            menu.Show();
            this.Close();
        }
    }
}
