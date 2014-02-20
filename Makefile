
all : dtd xsd


dtd :
	xmllint --valid --noout projet.xml

xsd : temp
	xmllint --valid --noout --schema projet_schema.xsd temp.xml

temp :
	xmllint --valid --noent projet.xml > temp.xml 


clean:
	rm *.html temp.xml