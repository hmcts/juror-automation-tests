package cucumber.utils;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class XmlReader_v1 {

	public void read1() {

		try {

			File file = new File("src/main/resources/standingData.xml");

			DocumentBuilder dBuilder = DocumentBuilderFactory.newInstance()
					.newDocumentBuilder();

			Document doc = dBuilder.parse(file);
			doc.getDocumentElement().normalize();
			System.out.println("Root element :"
					+ doc.getDocumentElement().getNodeName());

			NodeList nList = doc.getElementsByTagName("terminalentry");

			for (int x = 0; x < nList.getLength(); x++) {
				Node nNode = nList.item(x);
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;
					System.out.println("\n");
					/*
					 * System.out.println(" Result Code and Title   : " + x +
					 * "  ,  " + eElement.getAttribute("value") + ", " +
					 * eElement.getAttribute("title"));
					 */
					System.out.println("text is : "
							+ eElement.getElementsByTagName("label").item(0)
									.getTextContent());

				}
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
}
