package it.tvpad.control.producer;

import it.tvpad.control.producer.filters.BaseFilter;
import it.tvpad.model.data.AbstractData;
import it.tvpad.model.request.Request;
import it.tvpad.model.request.Source;

import java.util.List;
import java.util.concurrent.BlockingQueue;

public abstract class AbstractDataProducer implements Runnable {
	
	
	protected BlockingQueue<List<? extends AbstractData>> dataQueue;	
	protected Request request;
	protected Source source;
	protected BaseFilter filter;
	
	
	
	public void setDataQueue(BlockingQueue<List<? extends AbstractData>> dataQueue) {
		this.dataQueue = dataQueue;
	}
	public void setRequest(Request request) {
		this.request = request;
	}
	public void setSource(Source source) {
		this.source = source;
	}
	
	public void setFilter(BaseFilter filter) {
		if(filter == null){
			System.out.println("ABDSTRACT - FILTRO NULL");
		}
		this.filter = filter;
	}
	
	@Override
	public abstract void run();
	
	

}
