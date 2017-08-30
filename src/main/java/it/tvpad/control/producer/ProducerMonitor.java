package it.tvpad.control.producer;

public class ProducerMonitor {
	private static ProducerMonitor instance = null;
	private int tweetScaricati;
	private int tweetPersistiti;
	private boolean streamingAttivo;

	private ProducerMonitor() {
	}

	public static ProducerMonitor getInstance() {
		if (instance == null) {
			instance = new ProducerMonitor();
		}
		return instance;
	}

	public void incrementaTweetScaricati(){
		tweetScaricati = tweetScaricati + 1;
	}
	
	public void incrementaTweetPersistiti(){
		this.incrementaTweetPersistiti(1);
	}

	public void incrementaTweetPersistiti(int size){
		tweetPersistiti = tweetPersistiti + size;
	}
	
	public int getTweetScaricati() {
		return tweetScaricati;
	}

	public void setTweetScaricati(int tweetScaricati) {
		this.tweetScaricati = tweetScaricati;
	}

	public int getTweetPersistiti() {
		return tweetPersistiti;
	}

	public void setTweetPersistiti(int tweetPersistiti) {
		this.tweetPersistiti = tweetPersistiti;
	}

	public boolean isStreamingAttivo() {
		return streamingAttivo;
	}

	public void setStreamingAttivo(boolean streamingAttivo) {
		this.streamingAttivo = streamingAttivo;
	}	
}