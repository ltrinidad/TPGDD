namespace UberFrba.Abm_Automovil
{
    partial class Alta_o_Modificacion
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.modelo = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.patente = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.turno = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.numeroChofer = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.marca = new System.Windows.Forms.TextBox();
            this.button3 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 21);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(43, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Marca :";
            // 
            // modelo
            // 
            this.modelo.Location = new System.Drawing.Point(44, 105);
            this.modelo.Name = "modelo";
            this.modelo.Size = new System.Drawing.Size(100, 20);
            this.modelo.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(28, 80);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(48, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Modelo :";
            // 
            // patente
            // 
            this.patente.Location = new System.Drawing.Point(44, 165);
            this.patente.Name = "patente";
            this.patente.Size = new System.Drawing.Size(100, 20);
            this.patente.TabIndex = 5;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(28, 140);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(50, 13);
            this.label3.TabIndex = 4;
            this.label3.Text = "Patente :";
            // 
            // turno
            // 
            this.turno.Location = new System.Drawing.Point(199, 46);
            this.turno.Name = "turno";
            this.turno.Size = new System.Drawing.Size(100, 20);
            this.turno.TabIndex = 15;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(183, 21);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(41, 13);
            this.label4.TabIndex = 6;
            this.label4.Text = "Turno :";
            // 
            // numeroChofer
            // 
            this.numeroChofer.Location = new System.Drawing.Point(199, 105);
            this.numeroChofer.Name = "numeroChofer";
            this.numeroChofer.Size = new System.Drawing.Size(100, 20);
            this.numeroChofer.TabIndex = 11;
            this.numeroChofer.TextChanged += new System.EventHandler(this.numeroChofer_TextChanged);
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(183, 80);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(98, 13);
            this.label6.TabIndex = 10;
            this.label6.Text = "Número de chofer :";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(190, 153);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(109, 32);
            this.button1.TabIndex = 12;
            this.button1.Text = "Cargar automóvil";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.cargar_guardar_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(190, 207);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(109, 32);
            this.button2.TabIndex = 13;
            this.button2.Text = "Limpiar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.limpiar_Click);
            // 
            // marca
            // 
            this.marca.Location = new System.Drawing.Point(44, 46);
            this.marca.Name = "marca";
            this.marca.Size = new System.Drawing.Size(100, 20);
            this.marca.TabIndex = 14;
            this.marca.TextChanged += new System.EventHandler(this.marca_TextChanged);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(35, 207);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(109, 32);
            this.button3.TabIndex = 16;
            this.button3.Text = "Limpiar";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // Alta_o_Modificacion
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(338, 268);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.marca);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.numeroChofer);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.turno);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.patente);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.modelo);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Alta_o_Modificacion";
            this.Text = "Alta de automóvil";
            this.Load += new System.EventHandler(this.Alta_o_Modificacion_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox modelo;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox patente;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox turno;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox numeroChofer;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.TextBox marca;
        private System.Windows.Forms.Button button3;
    }
}