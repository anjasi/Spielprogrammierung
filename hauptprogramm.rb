# Hier entsteht das Hauptprogramm.

spielfeld=Array.new(10) {Array.new(10, 0)} 		# Lege ein 2D-Array an mit 10x10 und fülle es mit Nullen (Default-Wert)

10.times do |i|				#Fülle Wände mit Vieren aus
	spielfeld[i][0]=4			# Y-Wert bleibt gleich, fülle entlang der X-Achse, oben
	spielfeld[i][9]=4			# Y-Wert bleibt gleich, fülle entlang der X-Achse, unten
	spielfeld[0][i]=4			# X-Wert bleibt gleich, fülle entlang der Y-Achse, links
	spielfeld[9][i]=4			# X-Wert bleibt gleich, fülle entlang der Y-Achse, rechts
end


=begin
spielfeld [4][4] = 8
print "\t0, 1, 2, 3, 4, 5, 6, 7, 8, 9"
	print "\n"
10.times do |i|
	print " #{i}    "
	print spielfeld[i]
	print "\n"
end
=end


hauptmenue = 2			# Initialisierung
a = 0
#---------------------------------------------------------------
begin				# Do While-Schleife

	while(hauptmenue == 0) do		# Diesen Abschnitt kann man nicht überspringen, da hauptmenue am Anfang 0 ist.
		# Begrüßung
		# Abruf von Benutzereingaben
		# 1. Spiel Starten
		# 2. Anleitung
		# 3. Highscore
		# 4. Spiel beenden
	end # --- Ende Hauptmenue = 0
	
	while(hauptmenue == 1) do
		# Levelauswahl vom Benutzer
		# Neuer Bildschirm
		# Neues Objekt der Klasse Schlange erzeugen, bzw. Konstruktor aufrufen
		# Übergebe das Level an das Objekt
		# Zeichne das Spielfeld (drawKasten) inkl. rechts Punktetafel
		
	end 	# --- Ende Hauptmenue = 1
	
	while(hauptmenue == 2) do
		# Hier kommt die Anleitung rein
		# zurück mit Abfrage if(getch()) {hauptmenue='0';}		
	end # --- Ende Hauptmenue = 2
	
	while(hauptmenue == 3) do
		# Hier kommt der Highscore rein
		# zurück mit Abfrage if(getch()) {hauptmenue='0';}	
	end # --- Ende Hauptmenue = 3
	
end while (a==0)
exit


