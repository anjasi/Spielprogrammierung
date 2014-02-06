
# Konstanten 
#-------------------------------------------------------------
	FENSTER = 600 		# Groessee des Fensters
	FELD_GROESSE = 500 	# Groesse des Spielfelds
	ZELLE = 10 		# Groesse des Schlangenkr�pers
	RAND = 50 			# Offset vom Spielfeld
	SPEED = 15		# Geschwindigkeit der Schlange

# Klassen 
#-------------------------------------------------------------
class Schlange <Shoes::Widget
	
	def initialize()
		@richtung = :right			# Legt eine Startrichtung fest.		
		@test = para				# f�r die Testausgaben
								# f�r die Punkteanzeige
		@punkte = para :align => "center", :size => "small", :stroke =>white, :displace_top => 10
		@fressen_auf_feld = false		# Statusvariable: zeigt an ob bereits Fressen auf Feld liegt
		@speed = 10				# Spielgeschwindigkeit
		@fressen = 0				# F�r das Fressen-Rect


		@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 50x50 und f�lle es mit Nullen (Default-Wert)
		@@schlange = Array.new(4) {Array.new(2,0)}	# Lege ein 2D-Array f�r die Schlange an, erweitert sich fynamisch
		@@verlaengerung = 0						# Gibt an, umwieviel Stellen die Schlange erweitert wird, sinnvoll bei Boni, TODO
		@@anzahl_felder = 4 						# Anzahl der K�rperteile von Snake
		@@punkte = 0							# Variable f�r die Punkteanzahl
		@xmove=0								# Speichert die Richtung f�r x, entweder -1 (links) oder +1 (rechts)
		@ymove=0								# Speichert die Richtung f�r y, entweder -1 (oben) oder +1 (unten)
		@@spielvariable = 0						# L�uft das Spiel? 0 = nein, 1 = ja, 2 = Crash (Der Crash wirft uns aus der Animation)
		
		50.times do |i|				# F�lle W�nde mit Vieren aus
			@@spielfeld[i][0]=4		# Y-Wert bleibt gleich, f�lle entlang der X-Achse, oben
			@@spielfeld[i][49]=4		# Y-Wert bleibt gleich, f�lle entlang der X-Achse, unten
			@@spielfeld[0][i]=4		# X-Wert bleibt gleich, f�lle entlang der Y-Achse, links
			@@spielfeld[49][i]=4		# X-Wert bleibt gleich, f�lle entlang der Y-Achse, rechts
		end
								
			@@spielfeld[25][25]=1;	# Setze im Spielfeld die Schlange
			@@spielfeld[26][25]=1;	# Das ist die Schlange, die auch unten im Schlangen-Array anlegt wird
			@@spielfeld[27][25]=1;
			@@spielfeld[28][25]=1;		
			
								# Setze die ersten Koordinaten der Snake
			@@schlange[0][0]=28;       	# X-Koordinate [K�rperteil] [Unterscheidung Koordinate] 
			@@schlange[0][1]=25;       	# Y-Koordinate [K�rperteil] [Unterscheidung Koordinate] 
			@@schlange[1][0]=27;		# R�ckw�rts gez�hlt, da Schlangen-Kopf gr��erer X-Wert als K�rper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;		# X - Letztes Feld der Schlange
			@@schlange[3][1]=25;		# Y - Letztes Feld der Schlange	
			zeichne_spielfeld()		# Rufe auf, zeichne Spielfeld
			zeichne_schlange()		# Setzt die erste Schlange, noch keine Bewegung
	end


# Methoden
#--------------------------------------------------------------------------------------------------------------------------------------------------------

	def zeichne_schlange()				# Zeichnet die Schlange grafisch
		@@anzahl_felder.times do |i|		# F�r alle Feld der Schlange, nutze den Iterator "i"
			stroke white				# Rand ist wei�
			if i==0 then 				# Schlangenkopf
				fill black				# f�lle Schwarz
			else						# Schlangenk�rper
				fill forestgreen			# f�lle gr�n		
			end
			@schlange = rect(@@schlange[i][0]*10+RAND,@@schlange[i][1]*10+RAND,ZELLE,ZELLE)
			# Zeichnet die Schlange grafisch
		end
	end

#--------------------------------------------------------------------------------------------------------------------------------------------------------
	
	def richtung(richtung)				# Holte die Richtung aus der Keypress-Methode
		@richtung = richtung			# 
	end
 	
#------------------------------------------------------------------------------------------------------------------	
	
	def verschiebe_schlange()
		case @richtung				# Wandelt die Richtung f�r die Bewegung um
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


		#------------ L�SCHE LETZTE STELLE ----------------------------------------------------------------------
		if @@verlaengerung==0 then				# Wenn Verl�ngerung der Schlange null ist										
			nostroke							# kein Rand
			fill white 							# f�lle wei�			
			@schlange = rect(@@schlange[-1][0]*10+RAND,@@schlange[-1][1]*10+RAND,ZELLE,ZELLE)	# L�sche grafisch

			@@spielfeld[@@schlange[-1][0]][@@schlange[-1][1]]=0	
			# L�scht letztes Feld im Array		
			# Setzte letztes Feld der Schlange im Spielfeld=0, damit es wieder frei wird
			# Syntax: spielfeld [] [] , X- und Y- Koordinaten der Schlagen eintragen
			
		else									# Verl�ngerung > 0, wurde durch Fressen erh�ht
			@@schlange.push [1,1]				# erweitere Array um eine Stelle!			
			@@anzahl_felder = @@anzahl_felder+1		# erh�he Anzahl-Felder der Schlange
			@@verlaengerung = @@verlaengerung-1	
		end		

		
		#----------- DAS ARRAY MITBWEGEN ----------------------------------------------------------------------		
		counter = @@anzahl_felder-1						# Solannge wie die Schlange lang ist
		while counter >=0 do								# Schleife f�ngt oben an und endet bei 0
			counter = counter - 1							# -1 f�r die richtige Adressierung	
			@@schlange[counter+1][0]=@@schlange[counter][0]	# X-Wert: Nachfolger kent von seinem Vorg�nger die Position.	
			@@schlange[counter+1][1]=@@schlange[counter][1]	# Y-Wert: Nachfolger kent von seinem Vorg�nger die Position.
		end
	
		#----------- VERWENDUNG DES TASTENDRRUCKS --------------------------------------------------------
		# Oben haben wir den Tastendruck in Nullen und Einser umgewandelt und in den Variablen @xmove und @ymove gespeichert.
		# Hier kommen die beiden zum Einsatz
		
		@@schlange[0][0]=@@schlange[1][0]+@xmove	# X - Koordinate
		@@schlange[0][1]=@@schlange[1][1]+@ymove	# Y - Koordinate
	
		#----------- CHECK 4 CRASH -----------------------------------------------------------------------------------	
		checkErg=check_crash(@@schlange[0][0],@@schlange[0][1])	# �bergebe Schlangenkopf, hole R�ckgabewert
		
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
		zeichne_schlange()								# Zeichne die Schlange, nachdem sie im Array verschoben wurde
	
	end # Ende: Methode verschiebe Schlange

#-------------------------------------------------------------------------------------------------------------------------------

	def check_crash(kopf_x,kopf_y)							# �berpr�ft: Trifft der Kopf auf ein belegtes Feld?
		if @@spielfeld[kopf_x][kopf_y] > 0 then					# Wenn an der Stelle des Kopfes im Spielfeld > 0 steht
													# dann kann es sich nur um Snake, Futter oder eine Wand handeln
			 if(@@spielfeld[kopf_x][kopf_y]==1) then			# CRASH mit Snake
				rueckgabe = 1							# Wird in verschiebe_schnalge genutzt
				@@spielvariable=2						# Beendet das Spiel
			elsif(@@spielfeld[kopf_x][kopf_y] == 2)				# CRASH mit Futter
				@fressen_auf_feld=false					# Es kann neues Futter gesetzt werden
				@@verlaengerung = @@verlaengerung+1		# Gibt an, um wie viele Stellen Schlange verl�ngert wird	
				@@punkte = @@punkte+1					# Erh�he Punktzahl
				rueckgabe = 2							# Wird in verschiebe_schnalge genutzt		

			else(@@spielfeld[kopf_x][kopf_y]==4)				# CRASH mit Wand
				rueckgabe = 4							# Wird in verschiebe_schnalge genutzt
				@@spielvariable=2						# Beendet das Spiel
			end
		
		else rueckgabe = 0								# Freies Feld
		end
		return rueckgabe
	end

#------------------------------------------------------------------------------------------------------------------

	def setze_fressen()				# Setzt das Fressen zuf�llig im Spielfeld, �berpr�ft ob das neue Fressen nicht schon belegt ist
		x_fressen = 0				# F�r Random
		y_fressen = 0				# F�r Random
		fill darkorange
		if (@fressen_auf_feld == false) then				# Wenn schon Fressen auf dem Feld liegt, dann darf kein neues erscheinen			
			begin								# Fussgesteurte Schleige
				x_fressen = rand (49)					# Random, X-Futter
				y_fressen = rand (49)					# Random, Y-Futter			
			end while check_crash(x_fressen, y_fressen) !=0	# Ist die Koordinate schon belegt? Wenn ja, springe hoch!			
			
			@fressen = rect(x_fressen*10+RAND,y_fressen*10+RAND,ZELLE,ZELLE)	# Zeichne Fressen grafisch			
			@@spielfeld[x_fressen][y_fressen]=2							# Setze im Spielfeld-Array das Essen			
			@fressen_auf_feld=true									# Setze Statusvariable
		end
	end	
	
#------------------------------------------------------------------------------------------------------------------

	def zeichne_spielfeld()
		nostroke
		fill white				
		rect(RAND+10, RAND+10, FELD_GROESSE-20, FELD_GROESSE-20)	
	end	

# Get und Set-Methoden f�r das Hauptprogramm
#------------------------------------------------------------------------------------------------------------------	

	def get_spielvariable						# Zeigt an, ob das Spiel noch l�uft
		return @@spielvariable
	end
	
	def set_spielvariable(x)					# Wird im ersten Keypress benutzt
		@@spielvariable=x					# Wenn eine Taste gedr�ckt wird startet das Spiel
	end
	
	def get_punkte							# Zeigt erreicht Spielpunkte im Hauptprogramm
		@punkte.replace "Punkte : #{@@punkte}"	# Punkte werden kontinuierlich ersetzt
	end	
	
end  # Klassenende
#------------------------------------------------------------------------------------------------------------------		


# Shoes Programm 
#------------------------------------------------------------------------------------------------------------------

Shoes.app :height => FENSTER, :width => FENSTER, :title=> "Unsere kleine Snake" do 
#Shoes.show_log
	
	background darkmagenta	
	alert "Anleitung: Ziel des Spiels ist es, mit deiner Schlange moeglichst viel Futter einzusammeln. Dies gelingt dir, indem du die Schlange mit den Pfeiltasten nach oben, nach unten, nach links oder  nach rechts steuerst. Doch aufgepasst! Mit jedem eingesammelten Futterstueck waechst deine Schlange. Faehrst du in dich selbst oder gegen den Rand hast du leider verloren und das Spiel ist beendet!"
			
	schlange = schlange()				# Anlegen eines Objekts der Klasse Schlange
	keypress do |key|				# Keypress Event, liefert den Tastendruck, durchgehend aktiv
		schlange.richtung(key)			# Gibt das Keyword f�r die Richtung weiter
		schlange.set_spielvariable(1)		# Setze Spielvariable auf true
	end
			
	animation=animate(SPEED) do 			# Dauerschleife die immer die Schlange zeichnet
		 if schlange.get_spielvariable==1 then	# Wenn das Spiel l�uft
			schlange.verschiebe_schlange() 	# Zeichnet die Schlange nicht, sondern l�scht (grafisch) und im array und verschiebt im Array
			schlange.setze_fressen()		# Ruft durchgehend setze_fressen auf und �berpr�ft ob er neues Fressen setzten darf
			schlange.get_punkte			# Zeigt durchgehend die Puntke an
		 elsif schlange.get_spielvariable==2	# TOT
			animation.stop				# Stoppe die Anmation
		end			
	end 
	
	
end # App-Ende