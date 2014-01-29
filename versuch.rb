
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

		# Aus Schlange.rb
		@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 10x10 und f¸lle es mit Nullen (Default-Wert)
		@@schlange = Array.new(4) {Array.new(4)}		# Erweitert sich automatisch
		@@verlaengerung = 5
		
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
	

			@@schlange[0][0]=28;       	# [Kˆrperteil] [Unterscheidung Koordinate] = X-Koordinate
			@@schlange[0][1]=25;       	# [Kˆrperteil] [Unterscheidung Koordinate] = Y-Koordinate
			@@schlange[1][0]=27;		# R¸ckw‰rts gez‰hlt, da Schlangen-Kopf grˆﬂerer X-Wert als Kˆrper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;
			@@schlange[3][1]=25;		
			debug("Spielfeld und Schlange wurden erzeugt")
	end
	
# ------------------------ Methoden ----------------	
	def richtung(richtung)
		@richtung = richtung
	end
	
	def verschiebe_schlange()
		# Verschiebt NUR im Schlangen Array
		# RUFT auf: zeichne Schlange
=begin
		case @richtung
			when :up 
				@x = @x  
				@y = @y - 10  
				
			when :down 
				@x = @x 
				@y = @y + 10
				
			when :left
				@x = @x - 10 
				@y = @y 
				
			when :right
				@x = @x + 10
				@y = @y 
		end
=end
		case @richtung
			when :up 
				x = 0
				y = 1  
				
			when :down 
				x = 0 
				y = 1
				
			when :left
				x = -1 
				y = 0 
				
			when :right
				x = 1
				y = 0 
		end 
		
		 if @@verlaengerung==0 then			
			#gotoxy(/*X-Koordinate*/ schlange[anzahlFelder-1][0]+1, /*Beginn y-koordinate*/ schlange[anzahlFelder-1][1]+1); // Letztes Feld lˆschen
			#cout<<(char)32; // Oder Leerzeichen: cout<<" ";
			#spielfeld[schlange[anzahlFelder-1][0]][schlange[anzahlFelder-1][1]]=0; // Letztes Feld im Spielfeld=0
		end
		
		(@@schlange.length-1).times do |i|			# Das Array bewegt sich mit
			@@schlange[i+1][0]=@@schlange[i][0]	# Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
			@@schlange[i+1][1]=@@schlange[i][1]			
		end
		
		#for i in 0..5 :TODO
		#	puts "Value of local variable is #{i}"
		#end
		 
		# for(int i=anzahlFelder-1;i>=0;i--) {		// Solannge wie die Schlange lang ist, Schleife f‰ngt oben an und endet bei 0
                #schlange[i+1][0]=schlange[i][0];		// Werden hier der Kopf und Kˆrper verschoben?
                #schlange[i+1][1]=schlange[i][1];
		#}
			
		@@schlange[0][0] = @@schlange[0][0]+1	
		zeichne_schlange()
	end
	
	def zeichne_schlange
		#@schlange = rect(@x,@y,@a,@a)
		laenge=@@schlange.length
		laenge.times do |i|
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
	spielfeld = feld()			# Anlegen des Feldes 
	schlange = schlange()		# Anlegen des Quadrats
	
	
	keypress do |key|		# keypress Event
		schlange.richtung(key)	# Speichert nur das Keyword f¸r die Richtung		
	end
			
	animate(10) do 
		schlange.verschiebe_schlange() # Zeichnet die Schlange nicht, verschiebt im array und grafisch
		#snakeobj.setzeFressen(); 	TODO
		#snakeobj.setzeBonus();	TODO
                #snakeobj.anzeige();		TODO
	end 


end # App-Ende