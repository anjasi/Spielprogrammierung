
# Konstanten 

# Legt die Gr√∂√üe des Fensters fest 
	FENSTER = 600 
	
# Legt die Gr√∂√üe des Spielfelds fest 
	FELD_GROESSE = 500 
	
# Legt die Gr√∂√üe einer Zelle fest = Schlange/ Futter / Zelle
	ZELLE = 10 
	
# Legt die x und y Position des Feldes mit 
	RAND = 50 
	
# Legt die Startposition des Quadrats fest 
	X_START = 300
	Y_START	= 300
	
# Geschwindigkeit der Schlange
	SPEED = 5
#-------------------------------------------------------------
# Klassen 
=begin
class Feld <Shoes::Widget
	@x_position, @y_position, @hoehe, @breite = 0, 0, 0
	@farbe = NIL 
	@feld = NIL 
	
	def initialize()
		@x_position = RAND
		@y_position = RAND
		@hoehe = FELD_GROESSE
		@breite = FELD_GROESSE
		@richtung = :left 
		
		stroke black
		fill white 
		@feld = rect(@x_position, @y_position, @hoehe, @breite)
	
	end # Ende Initialize
end # Ende Klasse
=end
class Schlange <Shoes::Widget
	@x,@y = 0,0	
	@a = 0
	@farbe = NIL
	@schlange = NIL

	def initialize()
			
		@x = X_START
		@y = Y_START
		@a = ZELLE
		@farbe = blue
	
		fill @farbe
		@schlange = rect(@x, @y, @a, @a)
		@test = para

		# Aus Schlange.rb
		@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 10x10 und f¸lle es mit Nullen (Default-Wert)
		@@schlange = Array.new(9) {Array.new(2,0)}		# Erweitert sich automatisch
		@@verlaengerung = 0	
		@anzahl_felder = 4 			# Anzahl der Kˆrperteile von Snake
		@xmove=0
		@ymove=0
		
		50.times do |i|				#F¸lle W‰nde mit Vieren aus
			@@spielfeld[i][0]=4		# Y-Wert bleibt gleich, f¸lle entlang der X-Achse, oben
			@@spielfeld[i][49]=4		# Y-Wert bleibt gleich, f¸lle entlang der X-Achse, unten
			@@spielfeld[0][i]=4		# X-Wert bleibt gleich, f¸lle entlang der Y-Achse, links
			@@spielfeld[49][i]=4		# X-Wert bleibt gleich, f¸lle entlang der Y-Achse, rechts
		end
		
			@@spielfeld[25][25]=1;	# ANFANG: Start-Schlange setzen
			@@spielfeld[26][25]=1;
			@@spielfeld[27][25]=1;
			@@spielfeld[28][25]=1;	
	

			@@schlange[0][0]=28;       	# X-Koordinate [Kˆrperteil] [Unterscheidung Koordinate] 
			@@schlange[0][1]=25;       	# Y-Koordinate [Kˆrperteil] [Unterscheidung Koordinate] 
			@@schlange[1][0]=27;		# R¸ckw‰rts gez‰hlt, da Schlangen-Kopf grˆﬂerer X-Wert als Kˆrper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;		# X - Letztes Feld der Schlange
			@@schlange[3][1]=25;		# Y - Letztes Feld der Schlange			
			debug("Spielfeld und Schlange wurden erzeugt")
			zeichne_schlange()
	end
	
# ------------------------ Methoden ----------------	
	def richtung(richtung)
		@richtung = richtung
	end
	def ubermalen()
		fill white 
		@schlange = rect(@@schlange[-1][0]*10,@@schlange[-1][1]*10,@a,@a)	# TODO, funzt halbwegs	
		@test.replace "Pos der letzten Stelle: #{@@schlange.last}"
	end 	
	
	def verschiebe_schlange()
		# Verschiebt NUR im Schlangen Array
		# RUFT auf: zeichne Schlange
		case @richtung
			when :up 
				@xmove = 0
				@ymove = -1  
				
			when :down 
				@xmove = 0 
				@ymove = +1
				
			when :left
				@xmove = -1 
				@ymove = 0 
				
			when :right
				@xmove = 1
				@ymove = 0 
		end 


		#----------- L÷SCHE LETZTE STELLE --------------		
		if @@verlaengerung==0 then			
			
			# --------- L÷SCHE GRAFISCH --------------
			#laenge = @@schlange.length-1
			#@schlange = rect((@@schlange[-1][0])*10,(@@schlange[-1][1])*10,@a,@a)			
			#@schlange = rect((@@schlange[-1][0])*10,(@@schlange[-1][1])*10,@a,@a)	# TODO, funzt halbwegs
			#@test.replace @@schlange[0][0]
			
			
			# Letztes Feld der Schlange --> Spielfeld = 0
			@@spielfeld[@@schlange[-1][0]][@@schlange[-1][1]]=0
			# Das funktioniert			
			# Setzte letztes Feld der Schlange im Spielfeld=0, damit es wieder frei wird
			# Syntax: spielfeld [] [] , X- und Y- Koordinaten der Schlagen eintragen			
			#@test.replace "#{@@schlange[-1][0]}" # Code zum checken
		else
			@anzahl_felder = @anzahl_felder+1
			@@verlaengerung = @@verlaengerung-1	
		end
		

		
		#----------- DAS ARRAY MITBWEGEN --------------		
		counter = @@schlange.length-1
		while counter >=0 do
			para counter
			counter = counter - 1
			@@schlange[counter+1][0]=@@schlange[counter][0]		# Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
			@@schlange[counter+1][1]=@@schlange[counter][1]
			
		end
		
		#(@@schlange.length-1).times do |i|				# Das Array bewegt sich mit
		#	@@schlange[i+1][0]=@@schlange[i][0]		# Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
		#	@@schlange[i+1][1]=@@schlange[i][1]	
			#@test.replace @@schlange[i]
			#@test.replace @@schlange[3][0]
		#end
		
		 #for(int i=anzahlFelder-1;i>=0;i--) {		// Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
			#schlange[i+1][0]=schlange[i][0];		// Werden hier der Kopf und Kˆrper verschoben?
			#schlange[i+1][1]=schlange[i][1];
		#}
	
		#----------- VERWENDUNG DES TASTENDRRUCKS --------------
		# Oben haben wir den Tastendruck in Nullen und Einser umgewandelt und in den Variablen @xmove und @ymove gespeichert.
		# Hier kommen die beiden zum Einsatz
		
		@@schlange[0][0]=@@schlange[1][0]+@xmove	# X - Koordinate
		@@schlange[0][1]=@@schlange[1][1]+@ymove	# Y - Koordinate
	
=begin		
		counter = @@schlange.length-2	
		while counter >= 0 do			
			@@schlange[counter+1][0] = @@schlange[counter][0]	# Schreibe die vorhergehende Koordinate an das Kˆrperteil das in der Schlange als n‰chstes kommt
			@@schlange[counter+1][1] = @@schlange[counter][1]	
			#para counter
			counter = counter-1
		end

=end		 
		# for(int i=anzahlFelder-1;i>=0;i--) {		// Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
                #schlange[i+1][0]=schlange[i][0];		// Werden hier der Kopf und Kˆrper verschoben?
                #schlange[i+1][1]=schlange[i][1];
		#}
			
		#@@schlange[0][0] = @@schlange[0][0]+1	
		zeichne_schlange()
		ubermalen()
	end
	
#------------------------------Die Schlange wird gezeichnet -------
# ----	Zeichnet Schlange St¸ck f¸r St¸ck mit Hilfe des Arrays schlange	
	def zeichne_schlange		
		@@schlange.length.times do |i|
		#@anzahl_felder.times do |i|
			if i==0 then 
				fill green
			else
				fill red
			end
			@schlange = rect(@@schlange[i][0]*10,@@schlange[i][1]*10,@a,@a)
		end	
	end
end  # Klassenende
	


# Shoes Programm 
Shoes.app :height => FENSTER, :width => FENSTER do 
Shoes.show_log
# ----- Objekterzeugung ------------------------------
	#spielfeld = feld()			# Anlegen des Feldes   UNN÷TIG?
	schlange = schlange()		# Anlegen des Quadrats
	
	
	keypress do |key|		# keypress Event
		schlange.richtung(key)	# Speichert nur das Keyword f¸r die Richtung		
	end
			
	animate(1) do 
		#schlange.zeichne_schlange() # Checkfunktion - funktioniert!
		schlange.verschiebe_schlange() # Zeichnet die Schlange nicht, sondern verschiebt im array und grafisch
		#snakeobj.setzeFressen(); 	TODO
		#snakeobj.setzeBonus();	TODO
                #snakeobj.anzeige();		TODO
	end 


end # App-Ende