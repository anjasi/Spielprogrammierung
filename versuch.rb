
# Konstanten 
#-------------------------------------------------------------
	FENSTER = 600 		# Groessee des Fensters
	FELD_GROESSE = 500 	# Groesse des Spielfelds
	ZELLE = 10 		# Groesse des Schlangenkröpers
	RAND = 50 			# Offset vom Spielfeld
	SPEED = 15		# Geschwindigkeit der Schlange

# Klassen 
#-------------------------------------------------------------
class Schlange <Shoes::Widget
	
	def initialize()
		@richtung = :right			# Legt eine Startrichtung fest.		
		@test = para				# für die Testausgaben
								# für die Punkteanzeige
		@punkte = para :align => "center", :size => "small", :stroke =>white, :displace_top => 10
		@fressen_auf_feld = false		# Statusvariable: zeigt an ob bereits Fressen auf Feld liegt
		@speed = 10				# Spielgeschwindigkeit
		@fressen = 0				# Für das Fressen-Rect
		@@schlange_grafisch = nil			# Initialisierung
		@@fressen_grafisch = nil


		@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 50x50 und fülle es mit Nullen (Default-Wert)
		@@schlange = Array.new(4) {Array.new(2,0)}	# Lege ein 2D-Array für die Schlange an, erweitert sich fynamisch
		@@verlaengerung = 0						# Gibt an, umwieviel Stellen die Schlange erweitert wird, sinnvoll bei Boni, TODO
		@@anzahl_felder = 4 						# Anzahl der Körperteile von Snake
		@@punkte = 0							# Variable für die Punkteanzahl
		@xmove=0								# Speichert die Richtung für x, entweder -1 (links) oder +1 (rechts)
		@ymove=0								# Speichert die Richtung für y, entweder -1 (oben) oder +1 (unten)
		@@spielvariable = 0						# Läuft das Spiel? 0 = nein, 1 = ja, 2 = Crash (Der Crash wirft uns aus der Animation)
		
		50.times do |i|				# Fülle Wände mit Vieren aus
			@@spielfeld[i][0]=4		# Y-Wert bleibt gleich, fülle entlang der X-Achse, oben
			@@spielfeld[i][49]=4		# Y-Wert bleibt gleich, fülle entlang der X-Achse, unten
			@@spielfeld[0][i]=4		# X-Wert bleibt gleich, fülle entlang der Y-Achse, links
			@@spielfeld[49][i]=4		# X-Wert bleibt gleich, fülle entlang der Y-Achse, rechts
		end
								
			@@spielfeld[25][25]=1;	# Setze im Spielfeld die Schlange
			@@spielfeld[26][25]=1;	# Das ist die Schlange, die auch unten im Schlangen-Array anlegt wird
			@@spielfeld[27][25]=1;
			@@spielfeld[28][25]=1;		
			
								# Setze die ersten Koordinaten der Snake
			@@schlange[0][0]=28;       	# X-Koordinate [Körperteil] [Unterscheidung Koordinate] 
			@@schlange[0][1]=25;       	# Y-Koordinate [Körperteil] [Unterscheidung Koordinate] 
			@@schlange[1][0]=27;		# Rückwärts gezählt, da Schlangen-Kopf größerer X-Wert als Körper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;		# X - Letztes Feld der Schlange
			@@schlange[3][1]=25;		# Y - Letztes Feld der Schlange	
			zeichne_spielfeld()		# Rufe auf, zeichne Spielfeld
			zeichne_schlange()		# Setzt die erste Schlange, noch keine Bewegung
			setze_fressen()			# Setzt das erste Fressen
	end


# Methoden
#--------------------------------------------------------------------------------------------------------------------------------------------------------

	def zeichne_schlange()				# Zeichnet die Schlange grafisch
		if @@schlange_grafisch!=nil then
			@@schlange_grafisch.clear
		end
		@@schlange_grafisch = stack do
			@@anzahl_felder.times do |i|		# Für alle Feld der Schlange, nutze den Iterator "i"
				stroke white				# Rand ist weiß
				if i==0 then 				# Schlangenkopf
					fill black				# fülle Schwarz
				else						# Schlangenkörper
					fill forestgreen			# fülle grün		
				end
				
				rect(@@schlange[i][0]*10+RAND,@@schlange[i][1]*10+RAND,ZELLE,ZELLE)			
				# Zeichnet die Schlange grafisch
			end
		end
	end

#--------------------------------------------------------------------------------------------------------------------------------------------------------
	
	def richtung(richtung)				# Holte die Richtung aus der Keypress-Methode
		@richtung = richtung			# 
	end
 	
#------------------------------------------------------------------------------------------------------------------	
	
	def verschiebe_schlange()
		case @richtung				# Wandelt die Richtung für die Bewegung um
			when :up 				# nach oben, x bleibt gleich, y wird kleiner
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


		#------------ LÖSCHE LETZTE STELLE ----------------------------------------------------------------------
		if @@verlaengerung==0 then				# Wenn Verlängerung der Schlange null ist										
			nostroke							# kein Rand
			fill white 							# fülle weiß			
			#@schlange = rect(@@schlange[-1][0]*10+RAND,@@schlange[-1][1]*10+RAND,ZELLE,ZELLE)	# Lösche grafisch

			@@spielfeld[@@schlange[-1][0]][@@schlange[-1][1]]=0	
			# Löscht letztes Feld im Array		
			# Setzte letztes Feld der Schlange im Spielfeld=0, damit es wieder frei wird
			# Syntax: spielfeld [] [] , X- und Y- Koordinaten der Schlagen eintragen
			
		else									# Verlängerung > 0, wurde durch Fressen erhöht
			@@schlange.push [1,1]				# erweitere Array um eine Stelle!			
			@@anzahl_felder = @@anzahl_felder+1		# erhöhe Anzahl-Felder der Schlange
			@@verlaengerung = @@verlaengerung-1	
		end		

		
		#----------- DAS ARRAY MITBWEGEN ----------------------------------------------------------------------		
		counter = @@anzahl_felder-1						# Solannge wie die Schlange lang ist
		while counter >=0 do								# Schleife fängt oben an und endet bei 0
			counter = counter - 1							# -1 für die richtige Adressierung	
			@@schlange[counter+1][0]=@@schlange[counter][0]	# X-Wert: Nachfolger kent von seinem Vorgänger die Position.	
			@@schlange[counter+1][1]=@@schlange[counter][1]	# Y-Wert: Nachfolger kent von seinem Vorgänger die Position.
		end
	
		#----------- VERWENDUNG DES TASTENDRRUCKS --------------------------------------------------------
		# Oben haben wir den Tastendruck in Nullen und Einser umgewandelt und in den Variablen @xmove und @ymove gespeichert.
		# Hier kommen die beiden zum Einsatz
		
		@@schlange[0][0]=@@schlange[1][0]+@xmove	# X - Koordinate
		@@schlange[0][1]=@@schlange[1][1]+@ymove	# Y - Koordinate
	
		#----------- CHECK 4 CRASH -----------------------------------------------------------------------------------	
		checkErg=check_crash(@@schlange[0][0],@@schlange[0][1])	# Übergebe Schlangenkopf, hole Rückgabewert
		
		if(checkErg==0) 								# Wenn Kopf auf freies Feld trifft, dann ...
			@@spielfeld[@@schlange[0][0]][@@schlange[0][1]]=1	# Schlange wird ins Spielfeld gesetzt
		end		
		if checkErg==1 then								# Wenn Kopf auf die Schlange trifft, dann ...
			@@spielvariable=2							# Setze Spielvariable, damit Ende
			alert "Ups, du bist gegen dich selbst gefahren"	# Hinweismeldung
		end		
		if checkErg==4 then								# Wenn Kopf auf die Wand trifft, dann ...
			@@spielvariable=2							# Setze Spielvariable, damit Ende
			alert "Hoppla, das war die Wand!"				# Hinweismeldung
		end      
		
		#----------- ZEICHNE SCHLANGE --------------------------------------------------------------------------
		#zeichne_schlange()								# Zeichne die Schlange, nachdem sie im Array verschoben wurde
	
	end # Ende: Methode verschiebe Schlange

#-------------------------------------------------------------------------------------------------------------------------------

	def check_crash(kopf_x,kopf_y)							# Überprüft: Trifft der Kopf auf ein belegtes Feld?
		if @@spielfeld[kopf_x][kopf_y] > 0 then					# Wenn an der Stelle des Kopfes im Spielfeld > 0 steht
													# dann kann es sich nur um Snake, Futter oder eine Wand handeln
			 if(@@spielfeld[kopf_x][kopf_y]==1) then			# CRASH mit Snake
				rueckgabe = 1							# Wird in verschiebe_schnalge genutzt
				#@@spielvariable=2						# Beendet das Spiel
			elsif(@@spielfeld[kopf_x][kopf_y] == 2)				# CRASH mit Futter
				@fressen_auf_feld=false					# Es kann neues Futter gesetzt werden
				@@verlaengerung = @@verlaengerung+1		# Gibt an, um wie viele Stellen Schlange verlängert wird	
				@@punkte = @@punkte+1					# Erhöhe Punktzahl
				rueckgabe = 2							# Wird in verschiebe_schnalge genutzt
				setze_fressen()							# Setzt neues Fressen

			elsif(@@spielfeld[kopf_x][kopf_y]==4)				# CRASH mit Wand
				rueckgabe = 4							# Wird in verschiebe_schnalge genutzt
				#@@spielvariable=2						# Beendet das Spiel
			end
		
		else 
			rueckgabe = 0								# Freies Feld
			zeichne_schlange()
		end
		@test.replace "#{@@spielvariable}"
		return rueckgabe
	end

#------------------------------------------------------------------------------------------------------------------

	def setze_fressen()				# Setzt das Fressen zufällig im Spielfeld, überprüft ob das neue Fressen nicht schon belegt ist
		x_fressen = 0				# Für Random
		y_fressen = 0				# Für Random		
		if (@fressen_auf_feld == false) then				# Wenn schon Fressen auf dem Feld liegt, dann darf kein neues erscheinen			
			begin								# Fussgesteurte Schleige
				x_fressen = rand (40)					# Random, X-Futter
				y_fressen = rand (40)					# Random, Y-Futter			
			end while check_crash(x_fressen, y_fressen) !=0	# Ist die Koordinate schon belegt? Wenn ja, springe hoch!			
			zeichne_fressen(x_fressen,y_fressen)		
			@@spielfeld[x_fressen][y_fressen]=2							# Setze im Spielfeld-Array das Essen			
			@fressen_auf_feld=true									# Setze Statusvariable
			
		end
	end

	def zeichne_fressen(x_fressen,y_fressen)
		if @@fressen_grafisch !=nil then
			@@fressen_grafisch.clear
		end
		@@fressen_grafisch = stack do
			fill darkorange
			rect(x_fressen*10+RAND,y_fressen*10+RAND,ZELLE,ZELLE)	# Zeichne Fressen grafisch	
		
		end	
	end
	
#------------------------------------------------------------------------------------------------------------------

	def zeichne_spielfeld()
		nostroke
		fill white				
		rect(RAND+10, RAND+10, FELD_GROESSE-20, FELD_GROESSE-20)	
	end	

# Get und Set-Methoden für das Hauptprogramm
#------------------------------------------------------------------------------------------------------------------	

	def get_spielvariable						# Zeigt an, ob das Spiel noch läuft
		return @@spielvariable
	end
	
	def set_spielvariable(x)					# Wird im ersten Keypress benutzt
		@@spielvariable=x					# Wenn eine Taste gedrückt wird startet das Spiel
	end
	
	def get_punkte							# Zeigt erreicht Spielpunkte im Hauptprogramm
		@punkte.replace "Punkte : #{@@punkte}"	# Punkte werden kontinuierlich ersetzt
	end	
	
end  # Klassenende
#------------------------------------------------------------------------------------------------------------------		


# Shoes Programm 
#------------------------------------------------------------------------------------------------------------------

Shoes.app :height => FENSTER, :width => FENSTER, :title=> "Unsere kleine Snake" do 
Shoes.show_log
	
	background darkmagenta	
	alert "Anleitung: Ziel des Spiels ist es, mit deiner Schlange moeglichst viel Futter einzusammeln. Dies gelingt dir, indem du die Schlange mit den Pfeiltasten nach oben, nach unten, nach links oder  nach rechts steuerst. Doch aufgepasst! Mit jedem eingesammelten Futterstueck waechst deine Schlange. Faehrst du in dich selbst oder gegen den Rand hast du leider verloren und das Spiel ist beendet!"
			
	schlange = schlange()				# Anlegen eines Objekts der Klasse Schlange
	keypress do |key|				# Keypress Event, liefert den Tastendruck, durchgehend aktiv
		schlange.richtung(key)			# Gibt das Keyword für die Richtung weiter
		schlange.set_spielvariable(1)		# Setze Spielvariable auf true
	end
			
	animation=animate(SPEED) do 			# Dauerschleife die immer die Schlange zeichnet
		 if schlange.get_spielvariable==1 then	# Wenn das Spiel läuft
			schlange.verschiebe_schlange() 	# Zeichnet die Schlange nicht, sondern löscht (grafisch) und im array und verschiebt im Array
			
			schlange.get_punkte			# Zeigt durchgehend die Puntke an
		 elsif schlange.get_spielvariable==2	# TOT
			animation.stop				# Stoppe die Anmation
		end			
	end 
	
	
end # App-Ende