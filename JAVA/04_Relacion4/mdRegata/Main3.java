package org.uma.mbd.mdRegata;

import org.uma.mbd.mdRegata.regata.Regata;

import java.io.FileNotFoundException;
import java.io.PrintWriter;

public class Main3 {
	public static void main(String [] args) {
		Regata regata = new Regata();
		try {
			regata.leeFichero("recursos/mdRegata/barcos.txt");
			PrintWriter out = new PrintWriter(System.out,true);
			regata.escribe(out);
			regata.avanzaTodos(10);
			System.out.println("Tras avanzar 10 minutos ...");
			regata.escribeFichero("recursos/mdRegata/salida.txt");
			regata.escribe(out);		
		} catch (FileNotFoundException e) {
			System.err.println("error de E/S " + e.getMessage());
		}
	}
}
