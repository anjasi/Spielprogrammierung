# Diese Datei wurde fuer die Schlangenfunktion angelegt
require 'konstanten'

class Schlange 

	@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 10x10 und fülle es mit Nullen (Default-Wert)
	@@schlange = Array.new(4) {Array.new(4)}		# Erweitert sich automatisch
	

	def initialize					# Konstruktor 		
		50.times do |i|				#Fülle Wände mit Vieren aus
			@@spielfeld[i][0]=4		# Y-Wert bleibt gleich, fülle entlang der X-Achse, oben
			@@spielfeld[i][49]=4		# Y-Wert bleibt gleich, fülle entlang der X-Achse, unten
			@@spielfeld[0][i]=4		# X-Wert bleibt gleich, fülle entlang der Y-Achse, links
			@@spielfeld[49][i]=4		# X-Wert bleibt gleich, fülle entlang der Y-Achse, rechts
		end
		
			@@spielfeld[25][25]=1;	# ANFANG: Start-Schlange setzen
			@@spielfeld[26][25]=1;
			@@spielfeld[27][25]=1;
			@@spielfeld[28][25]=1;	
	

			@@schlange[0][0]=28;       	# [Körperteil] [Unterscheidung Koordinate] = X-Koordinate
			@@schlange[0][1]=25;       	# [Körperteil] [Unterscheidung Koordinate] = Y-Koordinate
			@@schlange[1][0]=27;		# Rückwärts gezählt, da Schlangen-Kopf größerer X-Wert als Körper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;
			@@schlange[3][1]=25;		
			debug("Spielfeld und Schlange wurden erzeugt")

	end # Ende initialize		
 end # Ende Klasse
