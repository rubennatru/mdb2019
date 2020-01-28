package org.uma.mbd.mdFiltroImagen.filtroImagen;

import java.awt.*;
import java.awt.image.BufferedImage;


public class FiltroMedia implements FiltroImagen {

	public void filtra(BufferedImage imagen) {
		int fWidth  = imagen.getWidth();
		int fHeight = imagen.getHeight();
		
		for (int x = 0; x < fWidth ; x++) {
			for (int y = 0; y < fHeight; y++) {
				Color color = new Color(imagen.getRGB(x, y));
				int rojo  = color.getRed();
				int verde = color.getGreen();
				int azul  = color.getBlue();
				int media = (rojo + verde + azul)/3;
				Color nColor = new Color(media, media, media);  
				imagen.setRGB(x, y, nColor.getRGB());
			}
		}

	}
}