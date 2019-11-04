package com.acs.oas.cache;

import java.util.HashMap;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;



public class OASCacheManager {
	private HashMap cache = null;
	private static OASCacheManager me = null;

	
	private OASCacheManager() {
		try {
			cache = new HashMap();
		} catch (Exception ex) {
		    Logger.getLogger("oas").error("Exception in oasCache Constructor:"+ ExceptionUtils.getFullStackTrace(ex));
		}
	}
		
	synchronized static public OASCacheManager getInstance() {
	    if(me != null) {
	        return me;
	    } else {
	        me = new OASCacheManager();
	    }
	    return me;
	}
  
	public synchronized void forcedReload(String key) {    
	    addElement(key, null, true);
	}
	
	
	public synchronized Object addElement(String key, Object obj, boolean reload) {    
	    Logger.getLogger("oas").info("OASCacheManager.addElement enter");
	   try {    
		    if(!cache.containsKey(key) || reload) {
		        if(key != null && obj != null) {
		            cache.put(key, obj);
		        }
		    }else{
		        	obj = cache.get(key);
		    }
		} catch (Exception ex) {
		  //TODO error handling here
		}    
		
		return obj;
	}

	public Object getElement(String key) {
	    //Logger.getLogger("oas").debug("OASCacheManager.getElement enter");
	    Object value = null;
	    if(cache.containsKey(key)) {
	        value = cache.get(key);
	    }else{
	        value = addElement(key, null, false);
	    }
    
	    return value;
	}
}
