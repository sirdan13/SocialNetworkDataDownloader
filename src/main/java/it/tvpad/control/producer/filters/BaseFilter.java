package it.tvpad.control.producer.filters;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 
 * Implementation of simple filter.
 * 
 * @author Alessandro
 *
 */
public class BaseFilter {

	private List<String> contained;
	private List<String> excluded;
	private List<String> langList;

	private static Logger logger = LoggerFactory.getLogger(BaseFilter.class);

	public void parseKeywordFilter(String keywordFilter) {
		contained = new ArrayList<String>();
		excluded = new ArrayList<String>();
		String[] datas = keywordFilter.toLowerCase().split(",");

		for (String data : datas) {
			if (data.startsWith("!")) {
				excluded.add(data.replaceAll("!", ""));
			} else {
				logger.warn("Add keyword:" + data);
				contained.add(data);
			}
		}
	}

	public void parseLanguageFilter(String langFilter) {
		String[] datas = langFilter.toLowerCase().split(",");
		langList = new ArrayList<String>();
		for (String data : datas) {
			langList.add(data);
		}
	}

	public String[] getTwitterApiKeywordFilter() {
		List<String> data = new ArrayList<String>();
		logger.warn("Contained Array:" + contained);
		for (String cont : contained) {
			/*
			 * filterStr += " "+cont; logger.warn("Filterstr:" + filterStr);
			 */
			data.add(cont);
		}
		/*
		 * logger.warn("filterStr:" + filterStr); filterStr =
		 * filterStr.substring(1, filterStr.length());
		 * System.out.println(filterStr); data[0] = filterStr; logger.warn(
		 * "BaseFilter data:" + Arrays.toString(data));
		 * 
		 * return data;
		 */
		logger.warn("Data:" + data);
		return data.toArray(new String[data.size()]);
	}

	synchronized public String[] getTwitterApiLanguageFilter() {
		String[] langArray = new String[langList.size()];
		for (int i = 0; i < langList.size(); i++) {
			langArray[i] = langList.get(i);
		}
		return langArray;
	}

	synchronized public boolean filterTweet(String text) {
		String txt = text.toLowerCase();
		for (String excl : excluded) {
			if (txt.contains(excl)) {
				return false;
			}
		}
		return true;
	}

	synchronized public boolean filterFacebookData(String text) {
		if (text != null) {
			String txt = text.toLowerCase();
			for (String cont : contained) {
				if (!txt.contains(cont)) {
					return false;
				}
			}
			for (String excl : excluded) {
				if (txt.contains(excl)) {
					return false;
				}
			}
			return true;
		} else {
			return false;
		}

	}

}
