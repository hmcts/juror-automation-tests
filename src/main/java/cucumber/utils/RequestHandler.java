package cucumber.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.CloseableHttpResponse;
import org.apache.hc.client5.http.impl.classic.HttpClientBuilder;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.core5.http.ContentType;
import org.apache.hc.core5.http.HttpHost;
import org.apache.hc.core5.http.io.entity.EntityUtils;
import org.apache.hc.core5.http.io.entity.StringEntity;
import org.apache.log4j.Logger;

public class RequestHandler {
	private static Logger log = Logger.getLogger(RequestHandler.class);
	
	public static String sendJsonRequest(String url, String payload, String xauthHeaderValue) {
		log.info("Preparing to post to =>"+url);
		System.out.println("12");
		HttpHost proxy = new HttpHost("proxy.logica.com");

		try (CloseableHttpClient httpClient = HttpClientBuilder.create().setProxy(proxy).build()) {
		    HttpPost request = new HttpPost(url);
		    StringEntity params = new StringEntity(payload, ContentType.APPLICATION_JSON);
		    request.addHeader("Content-Type", "application/json");
		    request.addHeader("x-auth", xauthHeaderValue);
		    
		    request.setEntity(params);
		    try (CloseableHttpResponse response = httpClient.execute(request)) {
				String responseText = "1"; // To do - response text, expecting 'OK'
				log.info("Sent Post Successfully. Response =>"+responseText);
			}

		}catch (Exception ex) {
			log.warn("Exception on Post");
		    //handle exception here

		}
		
		return "1"; 
	}
	
	/**
	 * Expand to include payload + Proxy
	 * @param url
	 */
	public static void request_post(String url)  {		
				
		String responseText = "Error";

		log.info("Preparing to post to =>"+url);

		try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
		    HttpPost request = new HttpPost(url);
		    try (CloseableHttpResponse response = httpClient.execute(request)) {
				responseText = response.toString(); // To do - response text, expecting 'OK'
				log.info("Sent Post Successfully. Response =>"+responseText);

				try	{
					String jsonString = EntityUtils.toString(response.getEntity());
					log.info(jsonString);
				} catch (Exception e){
					log.info("*** Unable ot get jsonString from response");
				}
			}
		}catch (Exception ex) {
			log.warn("Exception on Post");
			log.warn("URL => "+url);
			log.warn(ex);			
		    //handle exception here
		} 
	}
	
	/**
	 * JM - Poor implementation, refactor this /????/
	 * @param url
	 * @param expectedResponseCode
	 * @throws Exception
	 */
	public static void return_request_post(String url, int expectedResponseCode) throws Exception  {		
		
		String responseText = "Error";
		
		try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
		    HttpPost request = new HttpPost(url);
		    try (CloseableHttpResponse response = httpClient.execute(request)) {
				responseText = response.toString(); // To do - response text, expecting 'OK'
				log.info("Sent Post Successfully. Response =>"+responseText);

				if (response.getCode() != expectedResponseCode) {
					throw new Exception("Did not get expected value");
				}

				String jsonString = EntityUtils.toString(response.getEntity());
				log.info("Got =>"+jsonString);
			}
		    
		}catch (Exception ex) {
			log.warn("URL => "+url);
			log.warn(ex);
			throw new Exception("Exception on Post");
		} 
	}
	
	/**
	 * JM - Copy from above, all requires refactor
	 */
	public static String return_request_post(String url) throws Exception{
		String responseText = null;
		log.info("Making request =>"+url);
		try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
		    HttpPost request = new HttpPost(url);
		    try (CloseableHttpResponse response = httpClient.execute(request)) {
				responseText = response.toString(); // To do - response text, expecting 'OK'
				log.info("Sent Post Successfully. Response =>"+responseText);

				String jsonString = EntityUtils.toString(response.getEntity());
				log.info("Got =>"+jsonString);
				return jsonString;
			}
		    
		}catch (Exception ex) {
			log.warn("URL => "+url);
			log.warn(ex);
			throw new Exception("Exception on Post");
		} 
	}
}