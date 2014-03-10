
all : dtd xsd


dtd :
	xmllint --valid --noout projet.xml

xsd : temp
	xmllint --valid --noout --schema projet_schema.xsd temp.xml

temp :
	xmllint --valid --noent projet.xml > temp.xml 

web :
	xsltproc projet_xsl.xsl projet.xml > www/index.html
 xq :
	java -cp ./saxon9he.jar: net.sf.saxon.Query -q:xq.txt -o:resxq.html !indent=yes !encoding=utf-8

clean:
	rm www/*.html temp.xml
