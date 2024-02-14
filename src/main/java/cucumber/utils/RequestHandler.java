package cucumber.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Properties;

import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.params.ConnRoutePNames;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.apache.log4j.Logger;

public class RequestHandler {
	private static Logger log = Logger.getLogger(RequestHandler.class);
	
	public static String sendJsonRequest(String url, String payload, String xauthHeaderValue) {
		log.info("Preparing to post to =>"+url);
		System.out.println("12");
		HttpClient httpClient = HttpClientBuilder.create().build(); //Use this instead 		
		//If using proxy
		HttpHost proxy = new HttpHost("proxy.logica.com");
		httpClient.getParams().setParameter(ConnRoutePNames.DEFAULT_PROXY, proxy);

		try {

		    HttpPost request = new HttpPost(url);
		    StringEntity params =new StringEntity(payload);
		    request.addHeader("Content-Type", "application/json");
		    request.addHeader("x-auth", xauthHeaderValue);
		    
		    request.setEntity(params);
		    HttpResponse response = httpClient.execute(request);

		    String responseText = "1"; // To do - response text, expecting 'OK'
		    log.info("Sent Post Successfully. Response =>"+responseText);
		    
		}catch (Exception ex) {
			log.warn("Exception on Post");
		    //handle exception here

		} finally {
		    //Deprecated
		    //httpClient.getConnectionManager().shutdown(); 
		}
		
		return "1"; 
	}
	
	/**
	 * Expand to include payload + Proxy
	 * @param url
	 */
	public static void request_post(String url)  {		
				
		HttpClient httpClient = HttpClientBuilder.create().build();		
		String responseText = "Error";

		log.info("Preparing to post to =>"+url);
		HttpResponse response = null;

		try {
		    HttpPost request = new HttpPost(url);
		    response = httpClient.execute(request);
		    responseText = response.toString(); // To do - response text, expecting 'OK'
		    log.info("Sent Post Successfully. Response =>"+responseText);		    
		    
		    //String jsonString = EntityUtils.toString(response.getEntity());
		    //log.info(jsonString);
		    
		}catch (Exception ex) {
			log.warn("Exception on Post");
			log.warn("URL => "+url);
			log.warn(ex);			
		    //handle exception here
		} 

		try	{
			String jsonString = EntityUtils.toString(response.getEntity());
		    log.info(jsonString);
		} catch (Exception e){
			log.info("*** Unable ot get jsonString from response");
		}
	}
	
	/**
	 * JM - Poor implementation, refactor this /????/
	 * @param url
	 * @param expectedResponseCode
	 * @throws Exception
	 */
	public static void return_request_post(String url, int expectedResponseCode) throws Exception  {		
		
		HttpClient httpClient = HttpClientBuilder.create().build();		
		String responseText = "Error";
		
		try {
		    HttpPost request = new HttpPost(url);
		    HttpResponse response = httpClient.execute(request);
		    responseText = response.toString(); // To do - response text, expecting 'OK'
		    log.info("Sent Post Successfully. Response =>"+responseText);		    
		    
		    if (response.getStatusLine().getStatusCode() != expectedResponseCode) {
		    	throw new Exception("Did not get expected value");
		    }
		    
		    String jsonString = EntityUtils.toString(response.getEntity());
		    log.info("Got =>"+jsonString);
		    
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
		HttpClient httpClient = HttpClientBuilder.create().build();		
		String responseText = null;
		log.info("Making request =>"+url);
		try {
		    HttpPost request = new HttpPost(url);
		    HttpResponse response = httpClient.execute(request);
		    responseText = response.toString(); // To do - response text, expecting 'OK'
		    log.info("Sent Post Successfully. Response =>"+responseText);
		    
		    String jsonString = EntityUtils.toString(response.getEntity());
		    log.info("Got =>"+jsonString);
		    return jsonString;
		    
		}catch (Exception ex) {
			log.warn("URL => "+url);
			log.warn(ex);
			throw new Exception("Exception on Post");
		} 
	}
}