# Hier werden alle Konstanten in Pixel gesammelt.

FENSTER_GROESSE = 700
SPIELFELD_GROESSE = 500
ZELLEN_GROESSE = 10
ZELLEN_ANZAHL = 48 # 50 Zellen abzüglich 2 Zellen für den Rand 
ECKE_SPIELFELD_X = 100
ECKE_SPIELFELD_Y = 150
#GESCHWINDIGKEIT = 5

# In dieser Klasse werden die Default-Werte für die einzelnen Zellen festgelegt
class Status
  HINTERGRUND = 0
  ESSEN = 1 
  SCHLANGE = 2
end

# Farben der jeweiligen Zellen
FARBEN = {
  Status::HINTERGRUND => "grey",      # Farbe in doppelte Hochkommata??
  Status::ESSEN => "red",
  Status::SCHLANGE => "green"
  }
  
# Richtungen
RICHTUNGEN = {
  :up => [0,-1],
  :down => [0,1],
  :left => [-1,0],
  :right => [1,0]
  }
