# Betriebsdokumentation
[[_TOC_]]
## Einführungstext 

TODO: In 2-3 Sätzen beschreiben was die Skripte grundsaetzlich tun.

#### Skript 1: User create skript

Mit Hilfe von dem usercreate skript kann man ganz einfach mit einem externen CSV file neue users und gruppen erstellen.

#### Skript 2: Backup create skript

Mit dem backupCreate-Skript kann man über eine List von Usergroups in einem CSV file gewisse User-Directories archivieren.

## Installationsanleitung für Administratoren

### Installation

TODO: Wie ist das Skript zu installieren. (z.B. apt-get install ... oder tar xvf .... oder ...)

#### Skript 1 $ Skript 2: User create skript & Backup create skript

Da die Skripts in diesem Repo liegen kann man diese das Ganze leicht mit einem 
        
    git clone https://github.com/WoodyXP/m122_praxisarbeit_Noah_Barth.git

clonen und bei sich Lokal holen.
### Konfiguration

TODO: Beschreibung der Konfigurationsfiles (Beispiel-Files erstellen im Repo)

TODO: Wie ist ein allfaelliger Cronjob einzurichten

TODO: Wie sind User-Home-Templates einzurichten

#### Skript 1: User create skript

Für das usercreate Skript muss man noch einige Sachen einrichten um alles problemlos auszuführen.

Das Skript braucht 3 Skeleton Trees um zu funktionieren. Diese wären für die Gruppen Developer (dev), Researcher (res)
und Human Resources (hr).
Um die zu erstellen hat es simple commands.

Es hat auch im Folder bin ein File namens setup.sh, dieses File macht alles hier. Sie müssen nur Berechtigungen geben uns ausführen.

      sudo chmod 755 setup.sh
      ./setup.sh

1. Navigieren Sie zu /etc/skel
        
        cd /etc/skel

2. Erstellen Sie die Oberordner für alle Gruppen

        sudo mkdir -p dev
        sudo mkdir -p res
        sudo mkdir -p hr

3. Gehen Sie in die Ordner und erstellen ein Custom Template nach Ihrem Geschmack

        cd dev
        sudo mkdir -p tmpdir/{Documents/sources/{includes,docs},Repo,tags}
        cd res
        sudo mkdir -p tmpdir/{Documents/sources/{includes,docs},Repo,tags}
        cd hr
        sudo mkdir -p tmpdir/{Documents/sources/{includes,docs},Repo,tags}

Damit wirklich alles funktioniert wäre es gut den Skripten auch alle Rechte zu gebeb

1. Zuerst müssen Sie zu den Ort navigieren wo Sie das Repo geclont haben.

        cd /home/USER/PFAD_ZUM_REPO/m122_praxisarbeit_Noah_Barth/praxisarbeit/bin

2. Hier geben Sie den Skripten die Rechte

        sudo chmod 755 createuser.sh
        sudo chmod 755 logfunction.sh   
        sudo chmod 755 usercreationlog.txt


....

## Bediensanleitung Benutzer


TODO: Erzeugen der Input-Files beschreiben, falls noetig

TODO: beschreiben des Scriptaufruf

TODO: beschreiben der erzeugt files (falls solche erzeugt werden)

TODO: Lokation von logfiles und bekannte Fehlermeldungen beschreiben.

#### Skript 1: User create skript
    
Das usercreate Skript braucht eine CSV Datei zum auslesen. Diese Datei muss ein spezifisches Format haben.

Da wir den "username", "groupname" und "name_firstname" brauchen, richtet sich die CSV Datei auf diese Reihenfolge.

Im /etc/ Folder von diesem Branch finden Sie ein Beispiel CSV File die Sie benützten können.

Sonst können Sie mit diesem Template ein eigenes machen.

        username1 groupname1 name_firstname1
        username2 groupname2 name_firstname2
        username3 groupname3 name_firstname3
        username4 groupname4 name_firstname4

Um das Skript aufzurufen muss man im Folder "bin" sein, danache kann man mit:

    ./usercreate.sh -f INPUTFILE.csv

Das Skript ausführen.

Der Speicherort von Inputfile muss im gleichen Ordner sein wie das File.

Ein anderes File das wir brauchen ist das Backupfile für die Gruppen. In diesem
File muss man die Gruppen definieren, die ein Backup haben.

      dev
      res
      hr

Auch hier können Sie ein vorgeschriebenes File names groupbackupfile benützten.

Vergessen Sie nicht, dass dieses File im gleichen Ordner wie der createuser.sh skript sein muss, das kann man mit diesem Command mache:

      mv groupbackupfile /PFAD_ZUM_GIT_REPO/m122_pracisarbeit_Noah_Barth/prazisarbeit/bin

Das gleiche auch, fals Sie das userlist_example.csv benützten.

      mv userlist_example.csv /PFAD_ZUM_GIT_REPO/m122_pracisarbeit_Noah_Barth/prazisarbeit/bin
