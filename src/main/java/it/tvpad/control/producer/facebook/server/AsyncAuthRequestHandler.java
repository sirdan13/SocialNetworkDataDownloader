package it.tvpad.control.producer.facebook.server;

import java.io.IOException;
import java.util.Observable;
import java.util.concurrent.BlockingQueue;

import org.apache.http.HttpException;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.nio.protocol.BasicAsyncRequestConsumer;
import org.apache.http.nio.protocol.BasicAsyncResponseProducer;
import org.apache.http.nio.protocol.HttpAsyncExchange;
import org.apache.http.nio.protocol.HttpAsyncRequestConsumer;
import org.apache.http.nio.protocol.HttpAsyncRequestHandler;
import org.apache.http.protocol.HttpContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AsyncAuthRequestHandler extends Observable implements HttpAsyncRequestHandler<HttpRequest> {

	
	private BlockingQueue<String> authQueue;
	private static Logger logger =  LoggerFactory.getLogger(AsyncAuthRequestHandler.class);
	
	public void handle(HttpRequest request, HttpAsyncExchange httpexchange,HttpContext context) throws HttpException, IOException {
		HttpResponse response = httpexchange.getResponse();
        handleInternal(request, response, context);
        httpexchange.submitResponse(new BasicAsyncResponseProducer(response));
	}

	private void handleInternal(HttpRequest request, HttpResponse response,	HttpContext context) {
		String uri = request.getRequestLine().getUri().toString();
		System.out.println(uri);
		if(request.getRequestLine().getMethod().equalsIgnoreCase("get")){			
			if(uri.startsWith("/auth?code=")){
				String code=uri.substring(11, uri.length());
				authQueue.offer(code);
				response.setStatusCode(HttpStatus.SC_OK);
				logger.debug("code received");
			}else{
				response.setStatusCode(HttpStatus.SC_NOT_IMPLEMENTED);			
			}
		}else{
			response.setStatusCode(HttpStatus.SC_NOT_IMPLEMENTED);			
		}	
		
	}

	public HttpAsyncRequestConsumer<HttpRequest> processRequest(HttpRequest request, HttpContext context) throws HttpException,IOException {
		return new BasicAsyncRequestConsumer();
	}

	public void setQueue(BlockingQueue<String> authQueue) {
		this.authQueue = authQueue;		
	}
	
	
	
	
	

}
