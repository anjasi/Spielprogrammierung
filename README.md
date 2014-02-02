Das ist ein Test von Anja :)Spielprogrammierung
===================

Im Rahmen unseres Seminars "Programmierung in einer objektorientierten Programmiersprache" wurde uns die Aufgabe gestellt in kleinen Gruppen ein Spiel mit Ruby und Shoes zu programmieren. 
Unsere Gruppe hat entschieden, sich an dem Spielehttps://github.com/anjasi/Spielprogrammierungklassiker Snake zu versuchen. 

________

Das Team
--------

* Alexander Gantikow
* Sandra Hildebrand
* Regina Puls 
* Anja Sinz 



_________

Das Spiel 
---------

Regeln: 
Der Spieler lenkt mit den Pfeiltasten eine Schlange über das Spielfeld und versucht dabei so viel Essen wie möglich einzusammeln und dadurch Punkte zu holen. 
Jedes Mal, wenn die Schlange Essen frisst wächst sie ein Stück. Dadurch wir sie immer länger. 

Das Spiel ist verloren, wenn einer der folgenden Fälle eintritt: 
* Die Schlange läuft gegen den Rand des Spielfelds
* Die Schlange läuft gegen eine Teil ihres eigenen Körpers

______________________________

Grobes Konzept für unser Spiel 
------------------------------

Startbildschirm mit den folgenden Optionen 
* Spiel starten 
* Anleitung 
* High Score
* Spiel beenden 

Konzept für den Ablauf des Spiels

> Schlange: 
- Besteht am Anfang aus einem Quadrat und startet an einer vordefinierten Stelle im Spielfeld 
- Kann durch Drücken der Pfeiltasten ihre Laufrichtung ändern
- Wenn sie ein Futterstück frisst wird sie um ein Quadrat länger
- Wenn sie gegen die Wand läuft ist das Spiel beendet. 
- Wenn sie gegen einen Teil von sich selbst fährt ist das Spiel beendet
> 

> Futter: 
- Es ist immer nur ein Futterteil auf dem Spielfeld vorhanden 
- Es befindet sich an einer zufälligen Position -> random 
- Wenn es gefressen wurde, erscheint ein neues Futterteil
> 

> Spielfeld: 
- Quadratisches Spielfeld 
- Besitzt einen Rahmen! Wenn die Schlange dagegen fährt ist das Spiel verloren
> 

> Zelle: 
- Eine Zelle auf dem Spielfeld ist quadratisch und besitzt eine bestimmte Größe 
- Die Schlange ist zu Beginn eine Zelle groß 
- Die Schlange wächst mit jedem Futterteil, das gefressen wird um eine Zelle
- Ein Futterteil ist eine Zelle groß 
> 

