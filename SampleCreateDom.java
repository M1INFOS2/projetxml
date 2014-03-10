import java.io.File;


import javax.xml.parsers.*; 
import org.w3c.dom.*; 
import org.xml.sax.*; 
import javax.xml.transform.*; 
import javax.xml.transform.sax.*; 
import javax.xml.transform.dom.*; 
import javax.xml.transform.stream.*; 
import java.io.*; 
import java.util.*; 


public class SampleCreateDom {

	public static void main(String[] args) throws Exception {
		String path = "./";

		File xmlFile = new File(path+"projet.xml");
//		File xslFile = new File(path+"projet_xsl.xsl");
		
		DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();

		Document docXml = dBuilder.parse(xmlFile);
//		Document docXsl = dBuilder.parse(xslFile);

		docXml.getDocumentElement().normalize(); 
		
		
	// --------- transformation pour avoir un .html. Ne marche pas à cause de l'élément xsl:document	
		
//		StreamSource stylesource = new StreamSource(path+"projet_xsl.xsl");

//		TransformerFactory myFactory = TransformerFactory.newInstance();
//		Transformer transformer = myFactory.newTransformer(stylesource);
//		transformer.setOutputProperty(OutputKeys.METHOD, "html");
//		transformer.setOutputProperty(OutputKeys.ENCODING, "iso-8859-1");
//		transformer.setOutputProperty(OutputKeys.INDENT, "yes");
//			
//
//	      transformer.transform(new DOMSource(docXml),
//	    		  new DOMResult());
	      
	// ----------- fin transormation	     
		
		// affichage sur la sortie standard
		
		NodeList nList = docXml.getElementsByTagName("matière");
		for (int temp = 0; temp < nList.getLength(); temp++) {
			 
			Node nNode = nList.item(temp);
	 
			System.out.println("\nCurrent Element :" + nNode.getNodeName());
	 
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				Element eElement = (Element) nNode;
				System.out.println(eElement.getElementsByTagName("nom").item(0).getTextContent());
			}
		}


	}

}
