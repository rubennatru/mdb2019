package org.uma.mbd.mdJarrasMezcla;

import org.uma.mbd.mdJarrasMezcla.jarrasMezcla.JarraMezcla;
import org.uma.mbd.mdJarras.jarras.Jarra;

public class Main {
    public static void main(String [] args) {
        JarraMezcla ja = new JarraMezcla(4);
        JarraMezcla jb = new JarraMezcla(4);
        ja.llena();
        jb.llenaVino();
        Jarra jTemp = new Jarra(2);
        jTemp.llenaDesde(ja);
        jTemp.vacia();
        jTemp.llenaDesde(jb);
        // Las dos jarras estan con 2 litros
        JarraMezcla ji = new JarraMezcla(1);
        for (int i = 0 ; i < 1000; i++) {
            ji.llenaDesde(ja);
            jb.llenaDesde(ji);
            ji.llenaDesde(jb);
            ja.llenaDesde(ji);
            System.out.println(i + " "+ ja + " " + jb);
        }
    }
}