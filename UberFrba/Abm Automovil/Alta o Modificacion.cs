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
    public partial class Alta_o_Modificacion : Form
    {

        private bool puedeDarDeAlta;
        private string textoDelBoton;
        private string username;
        private string rol;

        public Alta_o_Modificacion(string textoDelBoton, bool puedeDarDeAlta, string username, string rol)
        {
            InitializeComponent();
            button1.Text = textoDelBoton;
            this.puedeDarDeAlta = puedeDarDeAlta;
            if (puedeDarDeAlta)
            {
                this.Text = "Alta de Automoviles";
            }
            else this.Text = "Modificacion de Automoviles";
            this.username = username;
            this.rol = rol;
        }


        private void limpiar_Click(object sender, EventArgs e)
        {
            this.marca.ResetText();
            this.turno.ResetText();
            this.modelo.ResetText();
            this.patente.ResetText();
            this.numeroChofer.ResetText();
        }

        private void turno_TextChanged(object sender, EventArgs e){
        
        }

        private void marca_TextChanged(object sender, EventArgs e)
        {
        }

     
        private void numeroChofer_TextChanged(object sender, EventArgs e)
        {
            if (System.Text.RegularExpressions.Regex.IsMatch(numeroChofer.Text, "[^0-9]"))
            {
                MessageBox.Show("Por favor, solo ingrese numeros");
                numeroChofer.Text = numeroChofer.Text.Remove(numeroChofer.Text.Length - 1);
            }
        }

        private void cargar_guardar_Click(object sender, EventArgs e)
        {
            if (!puedeDarDeAlta) { /* hacer update */}
            else { /*hacer insert*/ }
        }

        private void Alta_o_Modificacion_Load(object sender, EventArgs e)
        {

        }

        private void button3_Click(object sender, EventArgs e)
        {
            Form menu = new Menu.Menu(this.username, this.rol);
            menu.Show();
            this.Close();
        }

      
    }
}
