package org.uma.mbd.mdKWIC;

import java.io.*;

import org.uma.mbd.mdKWIC.kwic.KWIC;

public class EjemploKWIC {
	public static void main(String[] args) {
		try {
			KWIC k = new KWIC();
			k.palabrasNoSignificativas("recursos/mdKWIC/noClaves.txt");
			k.generaIndice("recursos/mdKWIC/frases.txt");
			// Para presentar por pantalla
			// Quitar comentarios para que salga en consola
			
			PrintWriter pw = new PrintWriter(System.out, true);
			k.presentaIndice(pw);
			pw.close();
					
//			k.presentaIndice("recursos/mdKWIC/salida.txt");
	
		} catch (IOException e) {
			System.out.println("Error: " + e.getMessage());
		}
	}
}
