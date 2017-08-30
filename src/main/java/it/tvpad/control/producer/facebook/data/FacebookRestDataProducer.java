package it.tvpad.control.producer.facebook.data;

import it.tvpad.control.producer.AbstractRestDataProducer;
import it.tvpad.control.producer.facebook.data.exception.FacebookDataException;
import it.tvpad.control.producer.facebook.server.AsyncFacebookServer;
import it.tvpad.control.producer.facebook.server.exception.AuthException;
import it.tvpad.model.data.facebook.FacebookData;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.restfb.Connection;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.FacebookClient.AccessToken;
import com.restfb.Parameter;
import com.restfb.Version;
import com.restfb.exception.FacebookException;
import com.restfb.types.Comment;
import com.restfb.types.Page;
import com.restfb.types.Post;
import com.restfb.types.Post.Comments;
import com.restfb.types.User;

public class FacebookRestDataProducer extends AbstractRestDataProducer {

	private AsyncFacebookServer server;
	private long accessTokenTimeOut;
	private FacebookClient client;
	private static Logger logger = LoggerFactory.getLogger(FacebookRestDataProducer.class);
	private static final DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy-HH:mm:ss");

	public void setServer(AsyncFacebookServer server) {
		this.server = server;
	}

	public void setAccessTokenTimeOut(long accessTokenTimeOut) {
		this.accessTokenTimeOut = accessTokenTimeOut;
	}

	@Override
	public void run() {
		logger.info("FACEBOOK REST START");
		try {
			authenticate();
			logger.debug("AUTHENTICATED");
		} catch (AuthException e) {
			logger.error(e.getMessage(), e);
			return;
		}
		if (source.getType().equalsIgnoreCase("PAGE")) {
			try {
				extractPageData();
			} catch (FacebookDataException e) {
				logger.error(e.getMessage(), e);
				return;
			}
		} else if (source.getType().equalsIgnoreCase("GROUP")) {
			try {
				extractGroupData();
			} catch (FacebookDataException e) {
				logger.error(e.getMessage(), e);
				return;
			}
		} else {
			logger.error("Type: " + source.getType() + " not supported");
			return;
		}
		logger.info("FACEBOOK REST STOP");
	}

	private void authenticate() throws AuthException {
		AccessToken token = server.getAccessToken(accessTokenTimeOut);
		logger.info("Access token received. Expire date " + dateFormat.format(token.getExpires()));
		client = new DefaultFacebookClient(token.getAccessToken(), server.getAppSecret(), Version.VERSION_2_2);
	}

	// può essere velocizzato se è impostato direttamente l'id
	private void extractPageData() throws FacebookDataException {
		logger.debug("EXTRACT PAGE DATA");
		String pageId = source.getSrcSnId();
		String pageName = source.getSrcSnName();
		Page page = null;
		if (pageId != null) {
			try {
				page = client.fetchObject(pageId, Page.class);
			} catch (FacebookException e) {
				try {
					authenticate();
					page = client.fetchObject(pageId, Page.class);
				} catch (AuthException e1) {
					throw new FacebookDataException(e1.getMessage());
				} catch (FacebookException e1) {
					throw new FacebookDataException(e1.getMessage());
				}

			}
		} else if (pageName != null) {
			try {
				page = client.fetchObject(pageName, Page.class);
			} catch (FacebookException e) {
				try {
					authenticate();
					page = client.fetchObject(pageId, Page.class);
				} catch (AuthException e1) {
					throw new FacebookDataException(e1.getMessage());
				} catch (FacebookException e1) {
					throw new FacebookDataException(e1.getMessage());
				}
			}
		} else {
			throw new FacebookDataException("id or name must be specified for source with id " + source.getId());
		}
		Date startDate = new Date(request.getStartDate().getTime());
		Boolean nextPage = true;
		Connection<Post> feeds = null;
		try {
			feeds = client.fetchConnection(page.getId() + "/feed", Post.class);
		} catch (FacebookException e) {
			try {
				authenticate();
				feeds = client.fetchConnection(page.getId() + "/feed", Post.class);
			} catch (AuthException e1) {
				throw new FacebookDataException(e1.getMessage());
			} catch (FacebookException e1) {
				throw new FacebookDataException(e1.getMessage());
			}
		}

		Iterator<List<Post>> postListIterator = feeds.iterator();
		while (nextPage && postListIterator.hasNext()) {
			List<Post> curPostList = postListIterator.next();
			for (Post p : curPostList) {
				if (p.getCreatedTime().compareTo(startDate) <= 0) {
					nextPage = false;
					break;
				} else {
					if (filter.filterFacebookData(p.getMessage())) {
						FacebookData data = new FacebookData();
						data.setSnId(p.getId());
						data.setAuthorId(new BigDecimal(p.getFrom().getId()));
						data.setCaption(p.getCaption());
						data.setCreationDate(new Timestamp(p.getCreatedTime().getTime()));
						data.setDescription(p.getDescription());
						data.setLikes(countLikes(p));
						data.setLink(p.getLink());
						data.setMessage(p.getMessage());
						data.setPicture(p.getPicture());
						data.setType("FEED");
						data.setFeedRef(null);
						data.setSource(source);
						data.setRequest(request);
						logger.debug("feed received from rest (page)");
						try {
							if (!dataQueue.offer(Arrays.asList(data), 5, TimeUnit.SECONDS)) {
								logger.warn("facebook data not inserted, queue is full");
							}
						} catch (InterruptedException e) {
							logger.error(e.getMessage(), e);
						}
						try {
							Thread.sleep(100);
						} catch (InterruptedException e) {
							logger.error(e.getMessage(), e);
						}
					}
					if (source.getInfoLevel().equalsIgnoreCase("COMMENT")) {
						Comments comments = p.getComments();
						if (comments != null) {
							for (Comment c : comments.getData()) {
								if (c.getCreatedTime().compareTo(startDate) <= 0) {
									break;
								} else {
									if (filter.filterFacebookData(c.getMessage())) {
										FacebookData data = new FacebookData();
										data.setSnId(c.getId());
										data.setAuthorId(new BigDecimal(c.getFrom().getId()));
										data.setCaption(null);
										data.setCreationDate(new Timestamp(c.getCreatedTime().getTime()));
										data.setDescription(null);
										data.setLikes(new BigDecimal(c.getLikeCount()));
										data.setLink(null);
										data.setMessage(c.getMessage());
										data.setPicture(null);
										data.setType("COMMENT");
										data.setSource(source);
										data.setRequest(request);
										data.setFeedRef(p.getId());
										logger.debug("comment received from rest (page)");
										try {
											if (!dataQueue.offer(Arrays.asList(data), 5, TimeUnit.SECONDS)) {
												logger.warn("facebook data not inserted, queue is full");
											}
										} catch (InterruptedException e) {
											logger.error(e.getMessage(), e);
										}
										try {
											Thread.sleep(100);
										} catch (InterruptedException e) {
											logger.error(e.getMessage(), e);
										}
									}
								}
							}
						}
					}
				}
			}
		}

	}

	// è quasi uguale a sopra può essere velocizzato se è impostato direttamente
	// l'id
	private void extractGroupData() throws FacebookDataException {
		logger.debug("EXTRACT GROUP DATA");
		String groupId = source.getSrcSnId();
		Connection<Post> feeds = null;
		if (groupId != null) {
			try {
				feeds = client.fetchConnection(groupId + "/feed", Post.class);
			} catch (FacebookException e) {
				try {
					authenticate();
					feeds = client.fetchConnection(groupId + "/feed", Post.class);
				} catch (AuthException e1) {
					throw new FacebookDataException(e1.getMessage());
				} catch (FacebookException e1) {
					throw new FacebookDataException(e1.getMessage());
				}
			}
		} else {
			throw new FacebookDataException("id must be specified for source with id " + source.getId());
		}
		Date startDate = new Date(request.getStartDate().getTime());
		Boolean nextPage = true;
		Iterator<List<Post>> postListIterator = feeds.iterator();
		while (nextPage && postListIterator.hasNext()) {
			List<Post> curPostList = postListIterator.next();
			for (Post p : curPostList) {
				if (p.getCreatedTime().compareTo(startDate) <= 0) {
					nextPage = false;
					break;
				} else {
					if (filter.filterFacebookData(p.getMessage())) {
						FacebookData data = new FacebookData();
						data.setSnId(p.getId());
						data.setAuthorId(new BigDecimal(p.getFrom().getId()));
						data.setCaption(p.getCaption());
						data.setCreationDate(new Timestamp(p.getCreatedTime().getTime()));
						data.setDescription(p.getDescription());
						data.setLikes(countLikes(p));
						data.setLink(p.getLink());
						data.setMessage(p.getMessage());
						data.setPicture(p.getPicture());
						data.setType("FEED");
						data.setFeedRef(null);
						data.setSource(source);
						data.setRequest(request);
						logger.debug("feed received from rest (page)");
						try {
							if (!dataQueue.offer(Arrays.asList(data), 5, TimeUnit.SECONDS)) {
								logger.warn("facebook data not inserted, queue is full");
							}
						} catch (InterruptedException e) {
							logger.error(e.getMessage(), e);
						}
						try {
							Thread.sleep(100);
						} catch (InterruptedException e) {
							logger.error(e.getMessage(), e);
						}
					}
					if (source.getInfoLevel().equalsIgnoreCase("COMMENT")) {
						Comments comments = p.getComments();
						if (comments != null) {
							for (Comment c : comments.getData()) {
								if (c.getCreatedTime().compareTo(startDate) <= 0) {
									break;
								} else {
									if (filter.filterFacebookData(c.getMessage())) {
										FacebookData data = new FacebookData();
										data.setSnId(c.getId());
										data.setAuthorId(new BigDecimal(c.getFrom().getId()));
										data.setCaption(null);
										data.setCreationDate(new Timestamp(c.getCreatedTime().getTime()));
										data.setDescription(null);
										data.setLikes(new BigDecimal(c.getLikeCount()));
										data.setLink(null);
										data.setMessage(c.getMessage());
										data.setPicture(null);
										data.setType("COMMENT");
										data.setSource(source);
										data.setRequest(request);
										data.setFeedRef(p.getId());
										logger.debug("comment received from rest (page)");
										try {
											if (!dataQueue.offer(Arrays.asList(data), 5, TimeUnit.SECONDS)) {
												logger.warn("facebook data not inserted, queue is full");
											}
										} catch (InterruptedException e) {
											logger.error(e.getMessage(), e);
										}
										try {
											Thread.sleep(100);
										} catch (InterruptedException e) {
											logger.error(e.getMessage(), e);
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	private BigDecimal countLikes(Post p) throws FacebookDataException {
		Connection<User> userLikes = null;
		try {
			userLikes = client.fetchConnection(p.getId() + "/likes", User.class, Parameter.with("summary", "true"));
			return new BigDecimal(userLikes.getTotalCount());
		} catch (FacebookException e) {
			try {
				authenticate();
				userLikes = client.fetchConnection(p.getId() + "/likes", User.class, Parameter.with("summary", "true"));
				return new BigDecimal(userLikes.getTotalCount());
			} catch (AuthException e1) {
				throw new FacebookDataException(e1.getMessage());
			} catch (FacebookException e1) {
				throw new FacebookDataException(e1.getMessage());
			}
		}
	}
}
