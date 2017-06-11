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

namespace UberFrba
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            string connetionString = null;
            SqlConnection cnn;
            connetionString = "Server=.\\SQLSERVER2012;Initial Catalog=GD1C2017;User ID=gd;Password=gd2017; Integrated Security=true";
            cnn = new SqlConnection(connetionString);
            cnn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM [LOS_CHATADROIDES].[Turno]", cnn);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine("{0},{1},{2},{3},{4},{5}", reader.GetDecimal(0), reader.GetDecimal(1), reader.GetString(2), reader.GetDecimal(3), reader.GetDecimal(4), reader.GetBoolean(5));
            }
            reader.Close();
            cnn.Close();

            new Login_Usuario.Login().Show();
            //new Abm_Automovil.Baja_y_Modificacion().Show();
            Application.Run();


            
        }
    }
}