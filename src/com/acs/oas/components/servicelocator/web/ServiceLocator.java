package com.acs.oas.components.servicelocator.web;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.URL;
import java.rmi.RemoteException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.ejb.EJBHome;
import javax.ejb.EJBLocalHome;
import javax.ejb.EJBObject;
import javax.jms.Queue;
import javax.jms.QueueConnectionFactory;
import javax.jms.Topic;
import javax.jms.TopicConnectionFactory;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;
import javax.sql.DataSource;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.components.servicelocator.ServiceLocatorException;
/**
 * This class is an implementation of the Service Locator pattern. It is
 * used to lookup resources such as EJBHomes, JMS Destinations, etc.
 * This implementation uses the "singleton" strategy and also the "caching"
 * strategy.
 * This implementation is intended to be used on the web tier and
 * not on the ejb tier.
 */
public class ServiceLocator
{
	private InitialContext ic;
	private Map cache; //used to hold references to EJBHomes/JMS Resources for re-use
	private static ServiceLocator me;
	static {
		try
		{
			me = new ServiceLocator();
		}
		catch (ServiceLocatorException se)
		{
		    Logger.getLogger("oas").error(ExceptionUtils.getFullStackTrace(se));
		}
	}
	private ServiceLocator() throws ServiceLocatorException
	{
		try
		{
			ic = new InitialContext();
			cache = Collections.synchronizedMap(new HashMap());
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
	}
	static public ServiceLocator getInstance()
	{
		return me;
	}
	/**
	 * Will get the ejb Local home factory. If this ejb home factory has already been
	 * clients need to cast to the type of EJBHome they desire
	 * @param jndiHomeName jndiHomeName
	 * @return EJBLocalHome the EJB Home corresponding to the homeName
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public EJBLocalHome getLocalHome(String jndiHomeName) throws ServiceLocatorException
	{
		EJBLocalHome home = null;
		try
		{
			if (cache.containsKey(jndiHomeName))
			{
				home = (EJBLocalHome) cache.get(jndiHomeName);
			}
			else
			{
				home = (EJBLocalHome) ic.lookup(jndiHomeName);
				cache.put(jndiHomeName, home);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return home;
	}
	/**
	 * will get the ejb Remote home factory. If this ejb home factory has already been
	 * clients need to cast to the type of EJBHome they desire
	 * @param jndiHomeName jndi home name
	 * @param className class name 
	 * @return EJBLocalHome the EJB Home corresponding to the homeName
	 * @throws ServiceLocatorException Exception this method can throw 
	 */
	public EJBHome getRemoteHome(String jndiHomeName, Class className) throws ServiceLocatorException
	{
		EJBHome home = null;
		try
		{
			if (cache.containsKey(jndiHomeName))
			{
				home = (EJBHome) cache.get(jndiHomeName);
			}
			else
			{
				Object objref = ic.lookup(jndiHomeName);
				Object obj = PortableRemoteObject.narrow(objref, className);
				home = (EJBHome) obj;
				cache.put(jndiHomeName, home);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return home;
	}
	/**
	 * Queue connection factory.
	 * @param qConnFactoryName class name 
	 * @return QueueConnectionFactory the factory for the factory to get queue connections from
	 * @throws ServiceLocatorException Exception this method can throw 
	 */
	public QueueConnectionFactory getQueueConnectionFactory(String qConnFactoryName) throws ServiceLocatorException
	{
		QueueConnectionFactory factory = null;
		try
		{
			if (cache.containsKey(qConnFactoryName))
			{
				factory = (QueueConnectionFactory) cache.get(qConnFactoryName);
			}
			else
			{
				factory = (QueueConnectionFactory) ic.lookup(qConnFactoryName);
				cache.put(qConnFactoryName, factory);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return factory;
	}
	/**
	 * Get queue.
	 * @param queueName queue name
	 * @return Queue the Queue Destination to send messages to
	 * @throws ServiceLocatorException Exception this method can throw 
	 */
	public Queue getQueue(String queueName) throws ServiceLocatorException
	{
		Queue queue = null;
		try
		{
			if (cache.containsKey(queueName))
			{
				queue = (Queue) cache.get(queueName);
			}
			else
			{
				queue = (Queue) ic.lookup(queueName);
				cache.put(queueName, queue);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return queue;
	}
	/**
	 * This method helps in obtaining the topic factory
	 * @param topicConnFactoryName name
	 * @return TopicConnectionFactory the factory for the factory to get topic connections from
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public TopicConnectionFactory getTopicConnectionFactory(String topicConnFactoryName) throws ServiceLocatorException
	{
		TopicConnectionFactory factory = null;
		try
		{
			if (cache.containsKey(topicConnFactoryName))
			{
				factory = (TopicConnectionFactory) cache.get(topicConnFactoryName);
			}
			else
			{
				factory = (TopicConnectionFactory) ic.lookup(topicConnFactoryName);
				cache.put(topicConnFactoryName, factory);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return factory;
	}
	/**
	 * This method obtains the topic itself for a caller
	 * @param topicName name
	 * @return Topic the Topic Destination to send messages to
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public Topic getTopic(String topicName) throws ServiceLocatorException
	{
		Topic topic = null;
		try
		{
			if (cache.containsKey(topicName))
			{
				topic = (Topic) cache.get(topicName);
			}
			else
			{
				topic = (Topic) ic.lookup(topicName);
				cache.put(topicName, topic);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return topic;
	}

	/**
	 * This method obtains the datasource itself for a caller
	 * @param dataSourceName name
	 * @return DataSource the DataSource corresponding to the name parameter
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public DataSource getDataSource(String dataSourceName) throws ServiceLocatorException
	{
		DataSource dataSource = null;
		try
		{
			if (cache.containsKey(dataSourceName))
			{
				dataSource = (DataSource) cache.get(dataSourceName);
			}
			else
			{
				dataSource = (DataSource) ic.lookup(dataSourceName);
				cache.put(dataSourceName, dataSource);
			}
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return dataSource;
	}
	/**
	 * Get url.
	 * @param envName name
	 * @return URL the URL value corresponding to the env entry name.
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public URL getUrl(String envName) throws ServiceLocatorException
	{
		URL url = null;
		try
		{
			url = (URL) ic.lookup(envName);
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return url;
	}
	/**
	 * Get boolean.
	 * @param envName name
	 * @return boolean the boolean value corresponding to the env entry such as SEND_CONFIRMATION_MAIL property.
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public boolean getBoolean(String envName) throws ServiceLocatorException
	{
		Boolean bool = null;
		try
		{
			bool = (Boolean) ic.lookup(envName);
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return bool.booleanValue();
	}
	/**
	 * Get string.
	 * @param envName name
	 * @return boolean the String value corresponding to the env entry name.
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public String getString(String envName) throws ServiceLocatorException
	{
		String envEntry = null;
		try
		{
			envEntry = (String) ic.lookup(envName);
		}
		catch (NamingException ne)
		{
			throw new ServiceLocatorException(ne);
		}
		catch (Exception e)
		{
			throw new ServiceLocatorException(e);
		}
		return envEntry;
	}
	/**
	 * Return the service represented by the serialized handle passeding
	 * @param id id
	 * @return EJBObject EJB Object
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public EJBObject getService(String id) throws ServiceLocatorException
	{
		if (id == null)
		{
			throw new ServiceLocatorException("EJB id cannot be null");
		}
		try
		{
			byte[] bytes = new String(id).getBytes();
			InputStream io = new ByteArrayInputStream(bytes);
			ObjectInputStream os = new ObjectInputStream(io);
			javax.ejb.Handle handle = (javax.ejb.Handle) os.readObject();
			return (handle.getEJBObject());
		}
		catch (Exception ex)
		{
			throw new ServiceLocatorException(ex);
		}
	}
	/**
	 * Return the serialized representation of the bean as a string used later to recconnect to session bean.
	 * @param session EJB Object
	 * @return String id
	 * @throws ServiceLocatorException Exception this method can throw 	  
	 */
	public String getId(EJBObject session) throws ServiceLocatorException
	{
		try
		{
			javax.ejb.Handle handle = session.getHandle();
			ByteArrayOutputStream fo = new ByteArrayOutputStream();
			ObjectOutputStream so = new ObjectOutputStream(fo);
			so.writeObject(handle);
			so.flush();
			so.close();
			return (new String(fo.toByteArray()));
		}
		catch (RemoteException ex)
		{
			throw new ServiceLocatorException(ex);
		}
		catch (IOException ex)
		{
			throw new ServiceLocatorException(ex);
		}
	}
}
