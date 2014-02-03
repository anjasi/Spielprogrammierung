# Hier entsteht das Hauptprogramm# Das ist ein Test von Anja

# ------------------------------ Includes ------------------------------
require 'schlange'
require 'konstanten'
require 'funktionen'
# ------------------------------ Hauptprogramm ------------------------------ 
Shoes.app :height => 600, :width => 600 do
Shoes.show_log	

	stack :margin_left => 240 do
		# ------------------------------ Hauptmenue ------------------------------	 
		@hauptauswahl = 0 
		@spielvariable == true
		@b1 = button "Spiel Starten" do					
			#clear()						# Neuer Bildschirm
			#print_spielfeld()					# Zeige Spielfeld
			snakeobj = Schlange.new(5)				# Das Array wird erfolgreich erzeugt
			#@object = rect(OFFSET, OFFSET, 10, 10)	# Einfach mal das Rect reingesetzt
			# ------------------------------ Keypress funktioniert mit den Buttons nicht :( ------------------------------			
			keypress do |k| 
				case k 
					when :left then para "Test" #quadrat.nach_links
					when :right then para "Test" #quadrat.nach_rechts
					when :up then para "Test" #uadrat.nach_oben
					when :down then para "Test" #quadrat.nach_unten
				end 
			end					
		end
		@b2 = button "Anleitung"do				
			@hauptauswahl = 2
				stack do
					alert "Ziel des Spiels ist es, mit deiner Schlange moeglichst viel Futter einzusammeln. Dies gelingt dir, indem du die Schlange mit den Pfeiltasten nach oben, nach unten, nach links oder  nach rechts steuerst. Doch aufgepasst! Mit jedem eingesammelten Futterstueck waechst deine Schlange. Faehrst du in dich selbst oder gegen den Rand hast du leider verloren und das Spiel ist beendet!"
				end
		end
		@b3 = button "Highscore"do		# TODO: Auslesen und Schreiben in TXT
			@hauptauswahl = 3				
			alert "Test"
		end
		@b4 = button "Spiel beenden"do		# funktioniert
			@hauptauswahl = 4				
			if confirm 'Wirklich das Spiel beenden?' then
				exit
			end
		end			
	
		if @hauptauswahl  == 1 then
			para "juhu"
		end
		# Styles der Buttons bestimmen
		@b1.style :width => 140, :margin_top => 5
		@b2.style :width => 140, :margin_top => 5
		@b3.style :width => 140, :margin_top => 5
		@b4.style :width => 140, :margin_top => 5
	end #-- Stack Ende

end




=begin
	hauptmenue = 2			# Initialisierung
	a = 0
	#---------------------------------------------------------------
	begin	# Do While-Schleife

		while(hauptmenue == 0) do		# Diesen Abschnitt kann man nicht ueberspringen, da hauptmenue am Anfang 0 ist.
			# Begruessung
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
			# zurueck mit Abfrage if(getch()) {hauptmenue='0';}		
		end # --- Ende Hauptmenue = 2
		
		while(hauptmenue == 3) do
			# Hier kommt der Highscore rein
			# zurueck mit Abfrage if(getch()) {hauptmenue='0';}	
		end # --- Ende Hauptmenue = 3
		
	end while (a==0)
	exit # TODO Unn�tig?
=end



