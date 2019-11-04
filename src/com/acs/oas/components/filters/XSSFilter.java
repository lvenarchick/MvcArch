package com.acs.oas.components.filters;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jboss.logging.Logger;

import com.acs.oas.util.DataSecurityViolationDetection;

@WebFilter("/XSSFilter")
public class XSSFilter implements Filter
{
	public static final Logger logger = Logger.getLogger("*** " + XSSFilter.class);
	private ServletContext context;

	public void init(FilterConfig fConfig) throws ServletException
	{
		this.context = fConfig.getServletContext();
		this.context.log("AuthenticationFilter initialized");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException
	{

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		boolean returnValue = true;

		// XXS Evaluation 
		DataSecurityViolationDetection dataSecurityViolationDetection = new DataSecurityViolationDetection();
		Map<String, String[]> m = req.getParameterMap();
		Set<?> s = m.entrySet();
		Iterator<?> it = s.iterator();
		while (it.hasNext())
		{
			boolean quit = false;
			@SuppressWarnings("unchecked")
			Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) it.next();

			String key = entry.getKey();
			String[] value = entry.getValue();
			//logger.debug("preHandle XXS Evaluation - key: " +  key + ", value: " + value[0]);
			if (value.length > 1)
			{
				for (int i = 0; i < value.length; i++)
				{
					if (dataSecurityViolationDetection.detect(value[i]))
					{
						returnValue = false;
						quit = true;
						break;
					}
				}
			}
			else
			{
				if (dataSecurityViolationDetection.detect(value[0]))
				{
					returnValue = false;
					quit = true;
				}
			}

			if(quit)
				break;
		}
		
		//logger.debug("preHandle XXS Evaluation - returnValue: " + returnValue);
		if(returnValue)
			chain.doFilter(request, response);
		else
			res.sendRedirect("serverErrorHandler.jsp");

	}

	public void destroy()
	{
		// close any resources here
	}

}