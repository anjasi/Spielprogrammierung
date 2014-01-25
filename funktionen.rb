# Hier werden alle Funktionen für Snake gesammelt!

# Erneutes Einfuegen der Prozedur am Freitag, 24.01
# Zeichnet das Spielfeld
def print_spielfeld()			
	fill blue			
	rect OFFSET,OFFSET,SPIELFELD_GROESSE,SPIELFELD_GROESSE
		nostroke
		fill red
				
		rect 0+OFFSET,0+OFFSET,SPIELFELD_GROESSE,10 					# Linie oben
		rect OFFSET,SPIELFELD_GROESSE+OFFSET-10,SPIELFELD_GROESSE,10		# Linie unten
		rect OFFSET,OFFSET,10,SPIELFELD_GROESSE	 					# Linie links		
		rect OFFSET+SPIELFELD_GROESSE-10,OFFSET,10,SPIELFELD_GROESSE	 	# Linie rechts	
end
