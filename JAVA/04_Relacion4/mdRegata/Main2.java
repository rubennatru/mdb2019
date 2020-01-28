package org.uma.mbd.mdRegata;

import org.uma.mbd.mdRegata.regata.Barco;
import org.uma.mbd.mdRegata.regata.Posicion;
import org.uma.mbd.mdRegata.regata.Regata;
import org.uma.mbd.mdRegata.regata.Velero;

public class Main2 {
	public static void main(String [] args) {
		Barco[] barcos = {
				new Barco("alisa", new Posicion(3,  359), 80, 20),
				new Velero("veraVela", new Posicion(3, 2), 20, 14),
				new Barco("kamira", new Posicion(-2, 354), 230, 33),
				new Barco("gamonal", new Posicion(0, -2), 0, 24),
		};
		
		Regata regata = new Regata();
		for(Barco barco : barcos) {
			regata.agrega(barco);
		}

		System.out.println(regata.getParticipantes());
		regata.avanzaTodos(10);
		System.out.println(regata.getParticipantes());
		System.out.println(regata.hayBarcoSinArrancada());
		System.out.println(regata.dentroDelCirculo(new Posicion(0, 0), 200));
		System.out.println(regata.barcosPorVelocidad());
		
	}
}
