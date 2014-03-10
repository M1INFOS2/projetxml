# Makefile du devoir XML

all : dtd xsd web tidy xq java



dtd :
	xmllint --valid --noout projet.xml

xsd : xsd_no_ent
	xmllint --valid --noout --schema projet_schema.xsd projet_no_ent.xml

xsd_no_ent :
	xmllint --valid --noent projet.xml > projet_no_ent.xml 

web :
	xsltproc projet_xsl.xsl projet.xml > www/index.html

tidy :
	tidy --error-file tidy_out.txt -i -m www/*.html

xq :
	java -cp ./saxon9he.jar: net.sf.saxon.Query -q:xq.txt -o:resxq.html !indent=yes !encoding=utf-8

java : java_compilation
	java SampleCreateDom > java_out.txt

java_compilation :
	javac SampleCreateDom.java

clean:
	rm www/*.html projet_no_ent.xml tidy_out.txt resxq.html SampleCreateDom.class java_out.txt

