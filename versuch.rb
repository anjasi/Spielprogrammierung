
# Konstanten 

# Legt die Größe des Fensters fest 
	FENSTER = 600 
	
# Legt die Größe des Spielfelds fest 
	FELD_GROESSE = 500 
	
# Legt die Größe einer Zelle fest = Schlange/ Futter / Zelle
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
		
	end 
end 

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
	end
	
# ------ Richtungsmethoden -> bewegen das Quadrat ----

	def nach_oben			
		
		@x = @x
		@y = @y - @a
			# Fall, dass es zu weit nach oben aus dem Fenster raus will  
			if @y < RAND then 		
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
				@x = X_START
				@y = Y_START
			end 

		@schlange.move(@x, @y)
	end

	def nach_unten
		
		@x = @x
		@y = @y + @a
	
			#Fall, dass es zu weit nach unten will
			if @y > FENSTER - ZELLE - RAND then 
				@x = X_START
				@y = Y_START
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
			end 

		@schlange.move(@x, @y)		
	end

	def nach_rechts
		
		@x = @x + @a
		@y = @y 
			
			#Fall, dass es zu weit nach rechts will 
			if @x > FENSTER - ZELLE - RAND then 
				@x = X_START
				@y = Y_START
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!"			
			end 

		@schlange.move @x, @y			
	end

	def nach_links
		
		@x = @x - @a
		@y = @y
			
			#Fall, dass es zu weit nach links will
			if @x < RAND  then 
				@x = X_START
				@y = Y_START
				alert "Da geht es nicht weiter! Du bist gegen den Rand gefahren!" 
			end 

		@schlange.move @x, @y		
	end
	
	def richtung(richtung)
		@richtung = richtung
		case richtung
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
		
		end 
	
	def bewegen()
		@x, @y = schlange.richtung(@richtung)
		@schlange = rect(@x, @y, @a, @a) 
	end
	
		
	
	
	
end  # Klassenende
	


# Shoes Programm 

Shoes.app :height => FENSTER, :width => FENSTER do 
Shoes.show_log

# Anlegen des Feldes 
	spielfeld = feld()

# Anlegen des Quadrats
	schlange = schlange()

# keypress Event
	keypress do |key|
		case key 
			when :up, :down, :left, :right
			schlange.richtung(key)
		end 
		end
			
	animate(5) do 
		
	end 


	#animate(SPEED) do |a| 
	#	case a 
	#		when :left then
				
	#	schlange.move	@x, @y	#.move ist eine Methode aus der Bibliothek!!!!!
	#@status.replace "Your Score: #{@snake.score} | High Score: #{@snake.high_score}" 
	#	elsif @new_game
	#		@status.replace "Game over!"
	#	end
	#end
end 