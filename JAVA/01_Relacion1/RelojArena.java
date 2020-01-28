package org.uma.mbd.mdRelojArena;

import org.uma.mbd.mdRelojArena.reloj.RelojArena;

public class Main {
    public static void main(String[] args) {
        RelojArena r1 = new RelojArena(7);
        RelojArena r2 = new RelojArena(5);
        System.out.println(r1 + " " + r2);
        r1.gira();			// r1=R(7/0)
        System.out.println(r1 + " " + r2);
        r2.gira();  		// r2=R(5/0)
        System.out.println(r1 + " " + r2);
        r1.pasaTiempo(r2);	// r1=R(2/5) r2=R(0/5). Tiempo = 5
        System.out.println(r1 + " " + r2);
        r2.gira();			// r2=R(5/0)
        System.out.println(r1 + " " + r2);
        r2.pasaTiempo(r1);	// r2=R(3/2) r1=(0/7). Tiempo = 5+2
        System.out.println(r1 + " " + r2);
        r2.gira();			// r2=R(2/3)
        System.out.println(r1 + " " + r2);
        r2.pasaTiempo();		// r2=R(0/5) Tiempo = 5+2+2
        System.out.println(r1 + " " + r2);
    }
}
