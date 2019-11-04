package com.acs.oas.waf.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.cache.OASCacheManager;
import com.acs.oas.components.ejb.authentication.AuthenticateControllerLocal;
import com.acs.oas.components.entities.Chpwebimag;
import com.acs.oas.components.servicelocator.ejb.ServiceLocator;
import com.acs.oas.components.valueobject.FingerPrinterVO;
import com.acs.oas.components.valueobject.SessionVO;
import com.acs.oas.db.EmailSql;
import com.acs.oas.util.JNDINames;
import com.acs.oas.util.OASConstants;
import com.acs.soa.requester.serviceurl.ServiceUrl;
import com.acs.util.Common;


/**
 * This class implements the main Controller. It invokes RequestMap to load the
 * values from the properties file when first instantiated. The RouterServlet
 * also reads in the Request from the client and forms a Hashtable of parameter
 * names and values which is passed to the CommandCache with the URI of the
 * request. It gets back a Response object which is processed and added to the
 * Request object. Finally the control is redirected to the appropriate JSP read
 * from the properties file.
 */
public class RouterServlet extends HttpServlet
{
	@EJB
	private AuthenticateControllerLocal authenticateControllerLocal;
	
	public static String serviceUrl = null;

	private WafProperties waf = new WafProperties();

    // Used to store the error page.
    private String errorPage = waf.getProperty("error.page");

    // Used to write the log file
    private ServletContext context = null;

    private String lname = waf.getProperty("waf.logger.name");

    public static String sysName = null;
    
    // Image names and id's for display on page
    private static String picturePassNames = new String("");
    private static String picturePassCategory = new String("");
    private static String picturePassIds = new String("");

    public static final String DATA_SEPARATOR = ";";

    
    /**
     * This method is called by the Servlet Container at the initialization to
     * invoke RequestMap object to load the properties file.
     * 
     * @param config
     *            Configuration of the servlet
     * @throws ServletException
     *             Exception this method can throw
     */
    public void init(ServletConfig config) throws ServletException
    {
        try
        {
            super.init(config);
            context = config.getServletContext();
            //context.setAttribute("dynContent", this.getDynamicContent());
            List<Chpwebimag> webImages = this.getPicturePassImages();
            loadPicturePassData(webImages);
            context.setAttribute("picturepassImageNames", picturePassNames);
            context.setAttribute("picturepassImageCategory", picturePassCategory);
            context.setAttribute("picturepassImageIds", picturePassIds);
            //context.setAttribute("pciturepassImages", this.getPicturePassImages());
            context.setAttribute("enableNotification", new Boolean(false));
            this.getCachedData();
            RequestMap.getInstance(); // this is done to pre-fetch mappings
			ServiceUrl su = new ServiceUrl();
			serviceUrl = su.getServiceUrl(ServiceUrl.BUSINESS_RULES_SERVICE_NAME);
			sysName = getSystemName();
            Logger.getLogger(lname).info("Initialization was successful.");
        }
        catch (Exception e)
        {
            Logger.getLogger(lname).info("Initialization failed.", e);
        }
    }

    /**
     * This method services the HTTP requests for this servlet. For each
     * request, it identifies the request type and performs the corresponding
     * operations for each request type.
     * 
     * @param request
     *            Object that encapsulates the request to the servlet
     * @param response
     *            Object that encapsulates the response from the servlet
     */
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        try
        {
            // Create a hashtable from the form values submitted to the servlet
            Hashtable formValues = getRequestParms(request);
            String healthCheck = (String) formValues.get("healthcheck");
            String refreshServiceUrl = (String) formValues.get("rsu");
            PrintWriter out = response.getWriter();
            if (healthCheck != null)
            {
               
                out.println("<BR><BR>I am feeling well, thank you.</BODY></HTML>");
                return;
            }
            else if (refreshServiceUrl != null)
            {
                try
                {
                    ServiceUrl su = new ServiceUrl();
                    serviceUrl = su.getServiceUrl(ServiceUrl.BUSINESS_RULES_SERVICE_NAME);
                    if (serviceUrl == null)
                    {
                        throw new Exception();
                    }
                    Logger.getLogger("soatestclient").info("SOAClientServlet.service. Successfully refreshed serviceUrl: " + serviceUrl);
                    out.println("Successfully refreshed serviceUrl: " + serviceUrl);
                }
                catch (Exception e)
                {
                  Logger.getLogger("soatestclient").error("SOAClientServlet.service. serviceUrl is null");
                  out.println("Unsuccessfully refreshed serviceUrl: " + serviceUrl);
                }
                finally
                {}
                
            }
            
            String refresh = (String) formValues.get("refresh");
            ///Logger.getLogger(lname).debug("RouterServlet.refresh: " + refresh);						
			if (refresh != null)
			{
				//context.setAttribute("dynContent", this.getDynamicContent());
				//context.setAttribute("challengeQuestions", this.getChallengeQuestions());
				//context.setAttribute("pciturepassImages", this.getPicturePassImages());
		        context.setAttribute("picturepassImageNames", picturePassNames);
	            context.setAttribute("picturepassImageCategory", picturePassCategory);
	            context.setAttribute("picturepassImageIds", picturePassIds);
	            
		        this.getCachedData();
				
				out.println("<BR><BR>Dynamic content has been refreshed!</BODY></HTML>");
				return;
			}

			//lmv 12/7/11 - oas authentication - 2011 0063 
			String enableNotification = (String) formValues.get("en");
			if (enableNotification != null && enableNotification.equalsIgnoreCase("true"))
			{
				context.setAttribute("enableNotification", new Boolean(true));
				
				out.println("<BR><BR>Notification logic has been enabled!</BODY></HTML>");
				Logger.getLogger(lname).debug("RouterServlet.enableNotification: Notification logic has been enabled!");	
				return;
			}			
			else if (enableNotification != null && enableNotification.equalsIgnoreCase("false"))
			{
				context.setAttribute("enableNotification", new Boolean(false));
				
				out.println("<BR><BR>Notification logic has been disabled!</BODY></HTML>");
				Logger.getLogger(lname).debug("RouterServlet.enableNotification: Notification logic has been disabled!");	
				return;
			}
			
            //Logger.getLogger(lname).debug("RouterServlet request.getScheme():
            // " + request.getScheme());
            if (!request.getScheme().equalsIgnoreCase("https"))
            {
                throw new SslException();
            }

//          Session evaluation
            HttpSession us = null;
            String reqUri = request.getRequestURI();
            //Logger.getLogger(lname).debug("RouterServlet.testSession reqUri: (1)" + reqUri);
            if (!isValidEntryPoint(reqUri))
            {
                String invalid = null;
                us = request.getSession(false);
                //Logger.getLogger(lname).debug("RouterServlet.testSession reqUri: (2), session: " + us);
                if (us != null)
                {
                    invalid = (String) us.getAttribute("invalid");
                    //Logger.getLogger(lname).debug("RouterServlet.testSession getAttribute(invalid): " + invalid);
                }
                else
                {
                    RequestDispatcher rd = context.getRequestDispatcher("/sessionTimeout.jsp");
                    rd.forward(request, response);
                    return;                	
                }

                //Logger.getLogger(lname).debug("RouterServlet.testSession invalid (3): "+ invalid);
                if (invalid == null)
                {
                    String id = request.getRequestedSessionId();
                    if (id == null || id.equals(""))
                    {
                        Logger.getLogger(lname).debug("RouterServlet.testSession getRequestedSessionId = null");
                    }
                    else
                    {
                        //Logger.getLogger(lname).debug("RouterServlet.testSession got session id: (4)" + id);
                        boolean valid = request.isRequestedSessionIdValid();
                        //Logger.getLogger(lname).debug("RouterServlet.testSession isRequestedSessionIdValid : " + valid);
                        if (!valid)
                        {
                            us = request.getSession();
                            us.setAttribute("invalid", "true");
                            Logger.getLogger(lname).debug("RouterServlet.testSession set invalid to true");
                            request.getSession().removeAttribute("guid");
                            RequestDispatcher rd = context.getRequestDispatcher("/sessionTimeout.jsp");
                            rd.forward(request, response);
                            return;
                        }
                    }
                }
                else
                {
                    Logger.getLogger(lname).debug("RouterServlet.testSession expired session: invalid: "+ invalid);
                    request.getSession().removeAttribute("guid");
                    RequestDispatcher rd = context.getRequestDispatcher("/sessionTimeout.jsp");
                    rd.forward(request, response);
                    return;
                }
            }
            else
            {
                us = request.getSession();
                if (us.getAttribute("invalid") != null)
                    us.removeAttribute("invalid");
 
            }
            
            //Logger.getLogger(lname).debug("RouterServlet testSession final");

            String userAgent = request.getHeader("User-Agent");
            String accept = request.getHeader("accept");
           
            /* Set FingerPrintVO */
            this.setFingerPrintObject(request, us);
           
            if (us.getAttribute("sessionVo") == null)
            {   
	           SessionVO sessionVo = new SessionVO();
	           
	           sessionVo.setAcceptHeader(accept);
	           sessionVo.setUserAgent(userAgent);
	           sessionVo.setIpAddress(request.getRemoteAddr());
	           
	           us.setAttribute("sessionVo", sessionVo);
            }
           

           
            /* Ticket#2017071310000074 - Make-changes-based-upon-findings-from-RSM-web-app-testing-of-OAS */
            String sessionGuid = (String) request.getSession().getAttribute("guid");    
            
//            if(formValues.get("pageGuid") != null)
//            	Logger.getLogger(lname).debug("RouterServlet valSessiona - formValues.get pageGuid: " + formValues.get("pageGuid") + ", class name: " + formValues.get("pageGuid").getClass().getName() );
//            else
//            	Logger.getLogger(lname).debug("RouterServlet valSessiona - formValues.get pageGuid: is null");
            
            String pageGuid = null;
            String [] pageGuidArray = null;
            try
            {
            	pageGuid = (String) formValues.get("pageGuid");
               	//Logger.getLogger(lname).debug("RouterServlet valSession1: " + sessionGuid + ", pageGuid: " + pageGuid + ", reqUri: " + reqUri);
            }
            catch(Exception e)
            {
            	pageGuidArray = (String[]) formValues.get("pageGuid");
            	if(pageGuidArray.length > 0)
            		pageGuid = pageGuidArray[0];
            	else
            		pageGuid = (String) formValues.get("pageGuid");
            }
            
           // Logger.getLogger(lname).debug("oas.RouterServlet.testSession : sessionGuid: "+ sessionGuid+", pageGuid: "+pageGuid);
           	//if(sessionGuid == null || sessionGuid.equals("") || (!sessionGuid.equals("") && sessionGuid != null && pageGuid == null))
            // The below pages are pages that can be accessed from a direct URL. So they could not have a pageguid, so exclude then and get a new session.
           
                String guid = Common.getAGuid();
                request.getSession().setAttribute("guid", guid);
                //Logger.getLogger(lname).debug("RouterServlet valSession2 - session guid is null or is one of the initial pages, so create new session guid: " + request.getSession().getAttribute("guid"));
            }
            else
            {
            	//Logger.getLogger(lname).debug("RouterServlet valSession3 - sessionGuid: " + sessionGuid + ", pageGuid: " + pageGuid);
            	if(!sessionGuid.equals(pageGuid))
            	{
            		String ip = request.getHeader("X-Forwarded-For");  
                    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                        ip = request.getHeader("Proxy-Client-IP");  
                    }  
                    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                        ip = request.getHeader("WL-Proxy-Client-IP");  
                    }  
                    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                        ip = request.getHeader("HTTP_CLIENT_IP");  
                    }  
                    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                        ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
                    }  
                    if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
                        ip = request.getRemoteAddr();  
                    } 
                    
            		//Logger.getLogger(lname).error("RouterServlet.validate session - Page guid does not match session guid. Return session timeout. ip: " + ip);
                    us.invalidate();
                	us.removeAttribute("guid");
            		RequestDispatcher rd = context.getRequestDispatcher("/securityConcern.jsp");
                    rd.forward(request, response);
                    return;
            	}
            }
            	
            // Instantiate Command Cache
            CommandCache commandCache = CommandCache.getInstance();

            // Create user session
//            String requestUrl = request.getRequestURL().toString();
//    		int endLocation = requestUrl.lastIndexOf("/");
//    		String uri = requestUrl.substring(endLocation + 1);	
//    	    endLocation = requestUrl.lastIndexOf(uri);
//    		String newUrl = requestUrl.substring(0, endLocation);
//    		SessionVO sov = new SessionVO(uri.toLowerCase(), newUrl);
//    		request.getSession().setAttribute("sessionvo", sov);
//            //request.getSession().setAttribute("uri", uri.toLowerCase());
//            //request.getSession().setAttribute("url", newUrl);
//            request.getSession().setAttribute("request", request);
            
            String uri = reqUri.toLowerCase().replace("/", "");
            
           // String testURL = (String) request.getSession().getAttribute("url");

//            int index1 = newUrl.indexOf("appliedbank.com/");
//            index1 = index1 + 15;
//            if(newUrl.indexOf("/", index1+1) != -1)
//            {	
//            	request.getSession().removeAttribute("guid");
//            	((HttpServletResponse) response).sendRedirect("https://onlineaccountservices.appliedbank.com/pageNotFound.jsp");
//                return;            	
//            }
            
            //lmv 12/7/11 - oas authentication - 2011 0063 
            request.getSession().setAttribute("enableNotificationPage", context.getAttribute("enableNotification"));
            //Logger.getLogger(lname).debug("RouterServlet.enableNotification: Set enableNotificationPage variable to: " + context.getAttribute("enableNotification"));	            
            

            // Invoke commandCache with the right parameters
            UserResponse userResp = commandCache.executeCommand(uri, formValues, us);

            String view = null;
            // Set the user response values in the request Object.
            if (userResp != null)
            {
                view = (String) userResp.getResponse("View");
                Enumeration keys = userResp.getResponseKeys();
                String key = null;
                for (int i = userResp.getResponseSize() - 1; i >= 0; i--)
                {
                    key = (String) keys.nextElement();
                    request.setAttribute(key, userResp.getResponse(key));
                }
            }
            // If the view is not set in the response , get the default view
            
            //Logger.getLogger(lname).debug("RouterServlet (1) pageGuid: " + pageGuid + ", sessionGuid: " + sessionGuid + ", URI: " + uri + ", View: " + view);
            if (view == null)
            {
            	view = RequestMap.getInstance().getJsp(uri);
            }
            else
            {
                view = RequestMap.getInstance().getJsp(view.toLowerCase());
            }
            //Logger.getLogger(lname).debug("RouterServlet (2) pageGuid: " + pageGuid + ", sessionGuid: " + sessionGuid + ", URI: " + uri + ", View: " + view);
            
            // Get the JSP name to be redirected to
            RequestDispatcher rd = context.getRequestDispatcher("/" + view); 
            rd.forward(request, response);
        }
        catch (SslException ex)
        {
            //Logger.getLogger(lname).debug("RouterServlet SslException.");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/sslError.jsp");
            rd.forward(request, response);
        }
        catch (IllegalStateException ex)
        {
            //Logger.getLogger(lname).debug("RouterServlet IllegalStateException.");
            //RequestDispatcher rd = getServletContext().getRequestDispatcher("/sslError.jsp");
            RequestDispatcher rd = context.getRequestDispatcher("/securityConcern.jsp");
            rd.forward(request, response);
        }
        catch (Exception ex)
        {
        	RequestDispatcher rd = null;
        	Logger.getLogger(lname).error("RouterServlet Exception:"+ ExceptionUtils.getFullStackTrace(ex));
            if (ex != null && ex.getMessage() != null && ex.getMessage().startsWith("Requested URI"))
            {    
                Logger.getLogger(lname).debug("RouterServlet Exception: " + ex.getMessage());
                request.getSession().removeAttribute("guid");
                //errorPage = "pageNotFound.jsp";
                rd = getServletContext().getRequestDispatcher("/pageNotFound.jsp");
            }
            else
            {
                Logger.getLogger(lname).error("RouterServlet Exception:"+ ExceptionUtils.getFullStackTrace(ex));
                rd = getServletContext().getRequestDispatcher("/" + errorPage);
            }
            request.setAttribute("Exception", ex);
            rd.forward(request, response);
        }
    }

    private Hashtable getRequestParms(HttpServletRequest request)
    {
        Hashtable formValues = new Hashtable();
        String[] paramValues = null;
        Enumeration names = request.getParameterNames(); // Get all user
                                                         // parameters from the
                                                         // request
        while (names.hasMoreElements())
        {
            String paramName = (String) names.nextElement();
            paramValues = request.getParameterValues(paramName);
            // If the parameter does not have multiple values,put is as a String
            if (paramValues != null && paramValues.length == 1)
            {
            	//Logger.getLogger(lname).info("Adding mValue parm: " + paramName + " withValues: " + paramValues);
                formValues.put(paramName, paramValues[0]);
            }
            else
            {
            	//Logger.getLogger(lname).info("Adding parm: " + paramName + " withValue: " + paramValues);
                formValues.put(paramName, paramValues);
            }
        }
        return formValues;
    }


   
    
}
