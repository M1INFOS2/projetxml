DEVOIR XML MASTER 1 - Quentin CHEYNET - Sébastien DELECRAZ
==========================================================



Contenu
-------

- README.md
- Makefile
- projet.xml : fichier décrivant la structure du master
- projet_dtd.dtd : DTD du fichier XML
- projet_schema.xsd : schéma du fichier XML
- xsi.xsd
- projet_xsl.xsl : feuille de style XSL servant à la production du site Web
- xq.txt : requête XQuery
- SampleCreateDom.java : code java
- saxon9he.jar : logiciel nécessaire à l'exécution de la requète XQuery
- www/mon_style.css : feuille de style du site web


Makefile
--------

Un Makefile est présent pour la gestion de l'ensemble des commandes 
- make dtd : vérifier la validité du document XML à l'aide de la DTD.
- make xsd : vérifier la validité du document XML à l'aide du Schéma.
- make web : générer le site WEB dans un répertoire qui doit se nommer www
- make -i tidy : vérifier la validité des pages XHTML générées avec l'aide de tidy
- make xq : exécuter la requête XQuery
- make java : exécuter un code Java qui va lire le fichier XML de données et en
extraire les noms des unités d'enseignement.
- make -i all : faire dans cet ordre.

Pour le Makefile il faut le lancer avec l'option -i car la cible tidy génère un
erreur à cause des Warnings qu'il trouve et arrête la compilation donc :
- make -i all
- make -i tidy


Sorties
-------

- projet_no_ent.xml : fichier temporaire sans entitées permettant la
- vérification à l'aide du Schéma
- SampleCreateDom.class : fichier de compilation du code Java
- java_out.txt : sortie de l'éxécution du programme Java
- resxq.html : page XHTML qui liste les enseignants avec, pour chacun, les
- enseignements qu'il assure et les parcours dans lesquels il intervient 
- tidy_out.txt : sorite de la vérification des pages HTLM par tidy
- /www/*.html : le site web


Remarques
---------

- En ce qui concerne les deux parcours de la spécialité FSIL la matière "Anglais
2" est présente et contient des informations qui ne sont pas corrèctes.
- Le fichier Java contient une partie du code en commentaire qui devrait
permettre la création d'un fichier html à partir de l'arbre mais nous avont
rencontré et non traité un problème lié à l'élément <xsl:document>.

