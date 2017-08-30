package it.tvpad.control.producer.facebook.server;

import it.tvpad.control.producer.facebook.server.exception.AuthException;
import it.tvpad.control.producer.facebook.server.exception.ServerException;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

import org.apache.http.ExceptionLogger;
import org.apache.http.NameValuePair;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.impl.nio.bootstrap.HttpServer;
import org.apache.http.impl.nio.bootstrap.ServerBootstrap;
import org.apache.http.impl.nio.reactor.IOReactorConfig;
import org.apache.http.message.BasicNameValuePair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.restfb.DefaultWebRequestor;
import com.restfb.FacebookClient.AccessToken;
import com.restfb.WebRequestor;

public class AsyncFacebookServer {

	private int port;
	private AsyncAuthRequestHandler authRequestHandler;
	private BlockingQueue<String> authQueue;
	private HttpServer server;
	private String appId;
	private String appSecret;
	private String redirectBaseUri;
	private String accessTokenUri;
	private String grant;
	private static Logger logger = LoggerFactory.getLogger(AsyncFacebookServer.class);
	private static DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy-HH:mm:ss");
	private AccessToken accessToken;

	public AsyncFacebookServer() {

		authRequestHandler = new AsyncAuthRequestHandler();
		authQueue = new LinkedBlockingQueue<String>(10);
		authRequestHandler.setQueue(authQueue);
	}

	public void startServer() throws ServerException {

		IOReactorConfig config = IOReactorConfig.custom().setSoTimeout(15000).setTcpNoDelay(true).build();

		server = ServerBootstrap.bootstrap().setListenerPort(port).setServerInfo("Test/1.1").setIOReactorConfig(config)
				.setExceptionLogger(ExceptionLogger.STD_ERR).registerHandler("/auth", authRequestHandler).create();

		try {
			server.start();
			logger.info("Facebook server started. Listening on port " + port);
		} catch (IOException e) {
			throw new ServerException(e.getMessage());
		}

	}

	public void stopServer() {
		if (server != null) {
			server.shutdown(5, TimeUnit.SECONDS);
		}
	}

	synchronized public AccessToken getAccessToken(long timeoutSec) throws AuthException {

		Date current = new Date();
		if (accessToken != null) {
			if (accessToken.getExpires().compareTo(current) > 0) {
				return accessToken;
			}
		}
		String authRedirectUri = redirectBaseUri + "auth";
		List<NameValuePair> codeParams = new ArrayList<NameValuePair>();
		codeParams.add(new BasicNameValuePair("client_id", appId));
		codeParams.add(new BasicNameValuePair("redirect_uri", authRedirectUri));
		codeParams.add(new BasicNameValuePair("response_type", "code"));
		codeParams.add(new BasicNameValuePair("scope", grant));

		String url = accessTokenUri + URLEncodedUtils.format(codeParams, "utf-8").replaceAll("&", "\\^&");
		try {
			Runtime.getRuntime().exec("cmd /k start " + url);
		} catch (IOException e) {
			throw new AuthException("Access token not received in " + timeoutSec + " sec");
		}
		String code;
		try {
			code = authQueue.poll(timeoutSec, TimeUnit.SECONDS);
		} catch (InterruptedException e) {
			throw new AuthException("Access token not received in " + timeoutSec + " sec");
		}
		if (code == null) {
			throw new AuthException("Access token not received in " + timeoutSec + " sec");
		}

		WebRequestor wr = new DefaultWebRequestor();
		WebRequestor.Response accessTokenResponse = null;
		try {
			accessTokenResponse = wr.executeGet(
					"https://graph.facebook.com/oauth/access_token?" + "client_id=" + appId.replaceAll(" ", "")
							+ "&redirect_uri=" + authRedirectUri + "&client_secret=" + appSecret + "&code=" + code);

		} catch (IOException e) {
			throw new AuthException("Access token not received in " + timeoutSec + " sec");
		}
		if (accessTokenResponse == null) {
			throw new AuthException("Access token not received in " + timeoutSec + " sec");
		}
		accessToken = AccessToken.fromQueryString(accessTokenResponse.getBody());
		logger.info("Access token obtained. Expire date " + dateFormat.format(accessToken.getExpires()));
		return accessToken;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

	public void setRedirectBaseUri(String redirectBaseUri) {
		this.redirectBaseUri = redirectBaseUri;
	}

	public void setAccessTokenUri(String accessTokenUri) {
		this.accessTokenUri = accessTokenUri;
	}

	public void setGrant(String grant) {
		this.grant = grant;
	}

	public String getAccessTokenUri() {
		return accessTokenUri;
	}

	public int getPort() {
		return port;
	}

	public String getAppId() {
		return appId;
	}

	public String getAppSecret() {
		return appSecret;
	}

	public String getRedirectBaseUri() {
		return redirectBaseUri;
	}

	public String getGrant() {
		return grant;
	}

}
