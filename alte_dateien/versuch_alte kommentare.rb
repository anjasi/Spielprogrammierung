
# Konstanten 

	FENSTER = 600 		# Groessee des Fensters
	FELD_GROESSE = 500 	# Groesse des Spielfelds
	
# Legt die GrÃ¶ÃŸe einer Zelle fest = Schlange/ Futter / Zelle
	ZELLE = 10 
	
# Legt die x und y Position des Feldes mit 
	RAND = 50 
	
# Legt die Startposition des Quadrats fest 
	X_START = 0
	Y_START	= 0
	
# Geschwindigkeit der Schlange
	SPEED = 15
#-------------------------------------------------------------
# Klassen 

class Schlange <Shoes::Widget
	
	attr_accessor :schlange
	
	@x,@y = 0,0	
	@a = 0
	@farbe = NIL
	@schlange = NIL
	@fressen = NIL

	def initialize()
			
		@x = X_START
		@y = Y_START
		@a = ZELLE
		@richtung = :right
		
		@test = para			# für die Testausgaben
		@punkte = para :align => "center", :size => "small", :stroke =>white, :displace_top => 10# für die Punkteanzeige
		@fressen_auf_feld = false
		@speed = 10


		# Aus Schlange.rb
		@@spielfeld=Array.new(50) {Array.new(50, 0)} 	# Lege ein 2D-Array an mit 10x10 und fülle es mit Nullen (Default-Wert)
		@@schlange = Array.new(4) {Array.new(2,0)}	# Erweitert sich automatisch
		@@verlaengerung = 0	
		@@anzahl_felder = 4 			# Anzahl der Körperteile von Snake
		@@punkte = 0
		@xmove=0
		@ymove=0
		@@spielvariable = 0			# Zeigt an ob das Spiel läuft
		
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
	

			@@schlange[0][0]=28;       	# X-Koordinate [Körperteil] [Unterscheidung Koordinate] 
			@@schlange[0][1]=25;       	# Y-Koordinate [Körperteil] [Unterscheidung Koordinate] 
			@@schlange[1][0]=27;		# Rückwärts gezählt, da Schlangen-Kopf größerer X-Wert als Körper
			@@schlange[1][1]=25;
			@@schlange[2][0]=26;
			@@schlange[2][1]=25;
			@@schlange[3][0]=25;		# X - Letztes Feld der Schlange
			@@schlange[3][1]=25;		# Y - Letztes Feld der Schlange			
			debug("Spielfeld und Schlange wurden erzeugt")
			zeichne_spielfeld()
			zeichne_schlange()
	end
	
# ------------------------ Methoden ----------------	
	def richtung(richtung)
		@richtung = richtung
	end
 	
#------------------------------------------------------------------------------------------------------------------	
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


		#----------- LÖSCHE LETZTE STELLE --------------		
		if @@verlaengerung==0 then
			# --------- LÖSCHE GRAFISCH --------------
			nostroke
			fill white 
			@schlange = rect(@@schlange[-1][0]*10+RAND,@@schlange[-1][1]*10+RAND,@a,@a)	# Löscht letzte Stelle grafisch
			#@test.replace "Snake : #{@@schlange}"		# Testausgabe
			
			# --------- LÖSCHE IM ARRAY --------------
			@@spielfeld[@@schlange[-1][0]][@@schlange[-1][1]]=0				# Löscht letztes Feld im Array		
			# Setzte letztes Feld der Schlange im Spielfeld=0, damit es wieder frei wird
			# Syntax: spielfeld [] [] , X- und Y- Koordinaten der Schlagen eintragen			
			#@test.replace "#{@@schlange[-1][0]}  " # Code zum checken
		else
			@@schlange.push [1,1]			# erweitere Array um eine Stelle!			
			@@anzahl_felder = @@anzahl_felder+1	# erhöhe Anzahl-Felder
			@@verlaengerung = @@verlaengerung-1	
		end		

		
		#----------- DAS ARRAY MITBWEGEN --------------		
		counter = @@anzahl_felder-1
		while counter >=0 do			
			counter = counter - 1
			@@schlange[counter+1][0]=@@schlange[counter][0]		# Solannge wie die Schlange lang ist, Schleife fängt oben an und endet bei 0
			@@schlange[counter+1][1]=@@schlange[counter][1]			
		end
	
		#----------- VERWENDUNG DES TASTENDRRUCKS --------------
		# Oben haben wir den Tastendruck in Nullen und Einser umgewandelt und in den Variablen @xmove und @ymove gespeichert.
		# Hier kommen die beiden zum Einsatz		
		@@schlange[0][0]=@@schlange[1][0]+@xmove	# X - Koordinate
		@@schlange[0][1]=@@schlange[1][1]+@ymove	# Y - Koordinate
	
		#----------- CHECK 4 CRASH -------------		
		checkErg=check_crash(@@schlange[0][0],@@schlange[0][1])	# Übergebe Kopf, hole Rückgabewert
		if(checkErg==0) 								#Hier passt alles. Der Kopf ist auf einem freien oder bonus Feld
			@@spielfeld[@@schlange[0][0]][@@schlange[0][1]]=1	# Schlange ist 1 auf Spielfeld
		end
		
		if checkErg==1 then
			@@spielvariable=2
			alert "Ups, du bist gegen dich selbst gefahren"
		end		
		if checkErg==4 then
			@@spielvariable=2
			alert "Hoppla, das war die Wand!"
		end

      
		
		#----------- ZEICHNE SCHLANGE --------------
		zeichne_schlange()
	end
#------------------------------------------------------------------------------------------------------------------


#------------------------------ZEICHNE DAS SPIELFELD -------

	

	def zeichne_schlange()
		@@anzahl_felder.times do |i|
			stroke white
			#@@anzahl_felder.times do |i|
			if i==0 then 
				fill black
			else
				fill forestgreen				
			end
			@schlange = rect(@@schlange[i][0]*10+RAND,@@schlange[i][1]*10+RAND,@a,@a)
		end
	end
#------------------------------------------------------------------------------------------------------------------	
	def check_crash(kopf_x,kopf_y)
		if @@spielfeld[kopf_x][kopf_y] > 0 then
			 if(@@spielfeld[kopf_x][kopf_y]==1) then		# Snake-Crash
				rueckgabe = 1
				@@spielvariable=2
			elsif(@@spielfeld[kopf_x][kopf_y] == 2)			# Futter-Crash
				@fressen_auf_feld=false				# Variable wird resettet
				@@verlaengerung = @@verlaengerung+1	# Gibt an, um wie viele Stellen Schlange verlängert wird	
				@@punkte = @@punkte+1
				rueckgabe = 2			
				# 3 ist evtl Bonus

			else(@@spielfeld[kopf_x][kopf_y]==4)			# Crash mit Wand
				rueckgabe = 4
				@@spielvariable=2
			end
		
		else rueckgabe = 0
		end
		return rueckgabe
	end

#------------------------------------------------------------------------------------------------------------------	
	def setze_fressen()
		x_fressen = 0
		y_fressen = 0
		@fressen = 0						# Statusvariable, ist Fressen auf dem Feld?
		fill darkorange
		if (@fressen_auf_feld == false) then		# Wenn Fressen auf Feld, dann darf kein neues erscheinen			
			begin
				x_fressen = rand (49)						# Random, X-Var
				y_fressen = rand (49)						# Random, Y-Var				
			end while check_crash(x_fressen, y_fressen) !=0		# Ist die Koordinate schon belegt?
			
			
			@fressen = rect(x_fressen*10+RAND,y_fressen*10+RAND,@a,@a)		# Zeichne Fressen grafisch			
			@@spielfeld[x_fressen][y_fressen]=2				# Setze im Spielfeld-Array das Essen			
			@fressen_auf_feld=true						# Setze Statusvariable
		end
	end
	

	
	
#------------------------------------------------------------------------------------------------------------------	
	def zeichne_spielfeld()
		nostroke
		fill white				
		rect(RAND+10, RAND+10, FELD_GROESSE-20, FELD_GROESSE-20)	
	end	
#------------------------------------------------------------------------------------------------------------------	

	def get_spielvariable
		return @@spielvariable
	end
	
	def set_spielvariable(x)
		@@spielvariable=x
	end
	
	def get_punkte
		@punkte.replace "Punkte : #{@@punkte}"
	end	
	
end  # Klassenende
#------------------------------------------------------------------------------------------------------------------		


# Shoes Programm 
Shoes.app :height => FENSTER, :width => FENSTER, :title=> "Unsere kleine Snake" do 
Shoes.show_log
	background darkmagenta	
	alert "Anleitung: Ziel des Spiels ist es, mit deiner Schlange moeglichst viel Futter einzusammeln. Dies gelingt dir, indem du die Schlange mit den Pfeiltasten nach oben, nach unten, nach links oder  nach rechts steuerst. Doch aufgepasst! Mit jedem eingesammelten Futterstueck waechst deine Schlange. Faehrst du in dich selbst oder gegen den Rand hast du leider verloren und das Spiel ist beendet!"
			
	schlange = schlange()				# Anlegen des Objekts	
	keypress do |key|				# keypress Event
		schlange.richtung(key)			# Speichert nur das Keyword für die Richtung
		schlange.set_spielvariable(1)		# Setze Spielvariable auf true
	end
			
	animation=animate(SPEED) do 
		 if schlange.get_spielvariable==1 then	
			schlange.verschiebe_schlange() 	# Zeichnet die Schlange nicht, sondern verschiebt im array und grafisch
			schlange.setze_fressen()
			schlange.get_punkte
		 elsif schlange.get_spielvariable==2	# tot
			animation.stop			
		end	
		
	end 
	
	
end # App-Ende