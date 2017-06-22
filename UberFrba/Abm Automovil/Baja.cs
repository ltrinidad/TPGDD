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
        public Baja_y_Modificacion()
        {
            InitializeComponent();
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
            Form modificar = new Alta_o_Modificacion("Guardar cambios", false);
            modificar.Show();
        }
    }
}
