# Bearbeitung des Übungsblatts 11a) Aufgabe 3 (Shoes-Klasse Quadrat)

#-------------KONSTANTEN----------------
	#Groesse des Fensters
	FELD_GROESSE = 1000

	#Groesse des Quadrats
	ZELLEN_GROESSE = 50

	#Rand = RAND
	RAND = 10

	#Anfangsposition des Quadrats
	X_STARTPOSITION = 450 
	Y_STARTPOSITION = 450
#-------------KLASSEN--------------------

class Quadrat < Shoes::Widget

	@x,@y = 0,0	
	@a = 0
	@farbe = NIL
	@objekt = NIL

	def initialize(x, y, a, farbe)
			
		@x = x
		@y = y
		@a = a
		@farbe = farbe
	
		#ersetzt die Methode anzeigen -> malt das Quadrat auf den Bildschirm
 		fill @farbe
		@object = rect(x, y, a, a)	
	end

	# ------ Richtungsmethoden -> bewegen das Quadrat ----

	def nach_oben			
		
		@x = @x
		@y = @y - @a
			# Fall, dass es zu weit nach oben aus dem Fenster raus will  
			if @y < RAND then 		
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
				@x = X_STARTPOSITION
				@y = Y_STARTPOSITION
			end 

		@object.move(@x, @y)
	end

	def nach_unten
		
		@x = @x
		@y = @y + @a
	
			#Fall, dass es zu weit nach unten will
			if @y > FELD_GROESSE - ZELLEN_GROESSE - RAND then 
				@x = X_STARTPOSITION
				@y = Y_STARTPOSITION
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
			end 

		@object.move(@x, @y)		
	end

	def nach_rechts
		
		@x = @x + @a
		@y = @y 
			
			#Fall, dass es zu weit nach rechts will 
			if @x > FELD_GROESSE - ZELLEN_GROESSE - RAND then 
				@x = X_STARTPOSITION
				@y = Y_STARTPOSITION
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!"			
			end 

		@object.move @x, @y			
	end

	def nach_links
		
		@x = @x - @a
		@y = @y
			
			#Fall, dass es zu weit nach links will
			if @x < RAND  then 
				@x = X_STARTPOSITION
				@y = Y_STARTPOSITION
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
			end 

		@object.move @x, @y		
	end
	
end

 



#----------------DAS SHOES PROGRAMM -------------------

Shoes.app :height => FELD_GROESSE, :width => FELD_GROESSE do
Shoes.show_log

	#Quadrat initialisieren
	quadrat = quadrat(X_STARTPOSITION, Y_STARTPOSITION, ZELLEN_GROESSE,blue)

	#Keypress - Event
	keypress do |k| 
		case k 
			when :left then quadrat.nach_links
			when :right then quadrat.nach_rechts
			when :up then quadrat.nach_oben
			when :down then quadrat.nach_unten
		end 
			
			quadrat.move @x, @y
	end

end