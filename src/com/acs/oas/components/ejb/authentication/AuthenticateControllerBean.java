package com.acs.oas.components.ejb.authentication;

import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.apache.commons.lang.exception.ExceptionUtils;
import org.apache.log4j.Logger;

import com.acs.oas.components.entities.Chpwebansw;
import com.acs.oas.components.entities.Chpwebchlq;
import com.acs.oas.components.entities.Chpwebdevi;
import com.acs.oas.components.entities.Chpwebimag;
import com.acs.oas.components.entities.Chpwebpass;
import com.acs.oas.db.OASLoginSql;
import com.acs.util.Common;
import com.acs.util.Conversion;


@Stateless
public class AuthenticateControllerBean implements AuthenticateControllerLocal
{
	@PersistenceContext
    private EntityManager em;

	public void addChallengeQuestionAnswer (String cusid, String questionId, String answerText)
	{
		try
		{
			String answguid = Common.getAGuid();
			Integer custId = new Integer(cusid);

			java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());

			Chpwebansw chpwebansw = new Chpwebansw();
			
			chpwebansw.setAnswerId(answguid);
			chpwebansw.setCustId(custId);
			chpwebansw.setAnswText(answerText);
			chpwebansw.setDateCreatedTime(now);
			
			
			em.persist(chpwebansw);
		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.addChallengeQuestionAnswer: "+ ExceptionUtils.getFullStackTrace(ex));
		}
	}   

	public void addPicturePass (String cusid, String imageName, String picturePhraseText)
	{
		try
		{
			Chpwebpass chpwebpass = new Chpwebpass();
			
			String picturepassId = Common.getAGuid();
			Integer custId = new Integer (cusid);
			java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());

			chpwebpass.setPicPassId(picturepassId);
			chpwebpass.setCustId(custId);
			chpwebpass.setPicPassFlag("A");
			chpwebpass.setImageName(imageName);
			chpwebpass.setPicPassPhrase(picturePhraseText);
			chpwebpass.setPicPassLastUpdate(now);
			chpwebpass.setPicPassCreatedTime(now);

			em.persist(chpwebpass);
		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.addPicturePass: "+ ExceptionUtils.getFullStackTrace(ex));
		}
	}
	public boolean updateAuthFlag(String custId, String flag)
	{
		boolean result = false;
		try
		{
			//Logger.getLogger("oas").debug("In AuthenticateControllerBean.updateAuthFlag: custId"+custId+",flag:"+flag);

			OASLoginSql dao = new OASLoginSql();

			result = dao.updateAuthFlag(Conversion.stringToInt(custId), flag);
			Logger.getLogger("oas").debug("In AuthenticateControllerBean.updateAuthFlag,result:"+result);

		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.updateAuthFlag: "+ ExceptionUtils.getFullStackTrace(ex));
			result = false;
		}
		return result;
	}
	public void addDeviceToken (String cusid, String deviceId, String pcInformation)
	{
		try
		{
			Chpwebdevi chpwebdevi = new Chpwebdevi();
			Logger.getLogger("oas").debug("AuthenticateControllerBean.addDeviseToken" + " custid[" + cusid + "]");
			Integer custId = new Integer (cusid);

			java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());
			
			chpwebdevi.setDeviceGuid(deviceId);
			chpwebdevi.setCustId(custId);
			chpwebdevi.setDeviceInfo(pcInformation);
			chpwebdevi.setDeviceCreatedTime(now);
			
			em.persist(chpwebdevi);
		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.addDeviceToken: "+ ExceptionUtils.getFullStackTrace(ex));
		}
	}  
	public boolean inActivateExistingAnswers(String cusid,String flag)
	{
		boolean upFlag = false;
		try
		{
			Integer custId = new Integer(cusid);


			Query qry = em.createNamedQuery("Chpwebansw.findAllActiveAnswersByCustId");
			qry.setParameter("custId", cusid);
			 
			List<Chpwebansw> existingAnswers = qry.getResultList();

			Logger.getLogger("oas").debug("AuthenticateControllerBean.inActivateExistingAnswers: existingAnswers.size(),"+existingAnswers.size());


			for(Chpwebansw answer : existingAnswers)
			{	
				//while (it.hasNext()) {
				//ChlgAnswerLocal 	answerLocal = (ChlgAnswerLocal) it.next();
				//Logger.getLogger("oas").debug("answerLocal id:"+answerLocal.getAnswguid().trim()+",question id is:"+answerLocal.getQuestionId().trim()+",text is:"+answerLocal.getAnswText().trim()+",answerLocal.getAnswFlag(),"+answerLocal.getAnswFlag());
				//answerLocal.setAnswFlag(flag);
				java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());
				//answerLocal.setLastupdTime(now);
				
				answer.setAnswFlag(flag);
				answer.setDateUpdatedTime(now);
				
				em.persist(answer);
				
				upFlag = true;
			}

		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.inActivateExistingAnswers: "+ ExceptionUtils.getFullStackTrace(ex));
		}
		return upFlag;

	}
	public boolean archiveExistingPass(String cusid, String flag)
	{
		boolean upFlag = false;
		try
		{	
			Integer custId = new Integer(cusid);
			java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());
			
			Query qry = em.createNamedQuery("Chpwebpass.findPassByCustId");
			qry.setParameter("custId", custId);
			
			List<Chpwebpass> picPassList = qry.getResultList();
			
			for(Chpwebpass picPass : picPassList)
			{
				//Logger.getLogger("oas").debug("passLocal id:"+passLocal.getPassId().trim()+",image id is:"+passLocal.getImageName().trim()+",phrase is:"+passLocal.getPicturePhrase().trim());
				upFlag = true;


				picPass.setPicPassFlag(flag);
				picPass.setPicPassLastUpdate(now);

				em.persist(picPass);
			}


		}
		catch(Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.archiveExistingPass: "+ ExceptionUtils.getFullStackTrace(ex));
		}
		return upFlag;

	}
	/**
	 * 
	 */
	public HashMap<String, String> getAllChallengeQuestions ()
	{

		HashMap<String, String>	challengeQuestions 	= new HashMap<String, String>();
		try
		{

            Query qry = em.createNamedQuery("Chpwebchlq.findAllActiveQuestions");
            
            List<Chpwebchlq> chlQuestions = qry.getResultList();
          
            Logger.getLogger("oas").debug("AuthenticateControllerBean.getAllChallengeQuestions Found " + chlQuestions.size() + " challenge question records.");

			for (Chpwebchlq challengQuestion : chlQuestions)
			{
				challengeQuestions.put(challengQuestion.getQuestionId().trim(), challengQuestion.getQuestionText().trim());
			}

		}
		catch (Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.getAllChallengeQuestions:"+ ExceptionUtils.getFullStackTrace(ex));
			throw new EJBException(ex.getMessage());
		}

		return challengeQuestions;
	}

	public Hashtable<String,String> getPicturePassInfoByCustId (String cusid)
	{
		Hashtable<String, String> 	picpass 	= new Hashtable<String,String>();

		Integer custId = new Integer (cusid);

		try
		{
			
			Query qry = em.createNamedQuery("Chpwebpass.findPassByCustId");
			qry.setParameter("custId", custId);
			
			
			Chpwebpass chpwebpass = (Chpwebpass) qry.getSingleResult();


					//if(passLocal1.getLastupdTime().after(passLocal.getLastupdTime()))

			//Logger.getLogger("oas").debug("passLocal input [" + cusid + "] input-integer[" + custId + "] id:"+passLocal.getPassId().trim()+",image name is:"+passLocal.getImageName().trim()+",phrase is:"+passLocal.getPicturePhrase().trim());


				picpass.put("1",chpwebpass.getImageName().trim());
				picpass.put("2",chpwebpass.getPicPassPhrase().trim());
				picpass.put("3",chpwebpass.getPicPassId().trim());


		}
		catch (Exception ex)
		{
			Logger.getLogger("oas").error("AuthenticateControllerBean/getPicturePassInfoByCustId Exception:cusid= "+cusid + " "+ ExceptionUtils.getFullStackTrace(ex));   
		}

		return picpass;

	}
	public Hashtable<String, String> getQuestionsByCustId (String cusid){
		Hashtable<String, String> 	allQuestions 	= new Hashtable<String, String>();

		Integer custId = new Integer (cusid);
		int counter =	0;

		try
		{
			Query qry = em.createNamedQuery("Chpwebansw.findAllActiveAnswersByCustId");
			qry.setParameter("custId", custId);
			
			List<Chpwebansw> allAnswers = qry.getResultList();

			for(Chpwebansw answ : allAnswers)
			{	
				counter++;
				Hashtable custQuestions = new Hashtable();
				//Logger.getLogger("oas").debug("answerLocal id:"+answerLocal.getAnswguid().trim()+",question id is:"+answerLocal.getQuestionId().trim()+",text is:"+answerLocal.getAnswText().trim());
				//custQuestions.put("1",answerLocal.getQuestionId().trim());
				//custQuestions.put("2",answerLocal.getAnswText().trim());

				//allQuestions.put(Conversion.intToString(counter),custQuestions);
			}

		}catch (Exception ex){
			Logger.getLogger("oas").error("AuthenticateControllerBean/getQuestionsByCustId Exception: "+ ExceptionUtils.getFullStackTrace(ex));   
		}

		return allQuestions;

	}
	public Hashtable<String, String> getAllDeviceIDsByCustId (String cusid){
		Hashtable<String, String> 	custDeviceIds 	= new Hashtable<String, String>();

		Integer custId = new Integer (cusid);
		int counter =	0;

		try
		{
			
			Query qry = em.createNamedQuery("Chpwebdevi.findallDeviceIdsByCustId");
			qry.setParameter("custId", custId);

			
			List<Chpwebdevi> allDeviceIds = qry.getResultList();

			for(Chpwebdevi device : allDeviceIds)
			{	
				//Logger.getLogger("oas").debug("pcInfoLocal  id:"+pcInfoLocal.getDeviceId().trim());
				custDeviceIds.put(device.getDeviceGuid().trim(), device.getDeviceGuid().trim());
			}


		}
		catch (Exception ex)
		{
			Logger.getLogger("oas").error("AuthenticateControllerBean/getAllDeviceIDsByCustId Exception: "+ ExceptionUtils.getFullStackTrace(ex));   
		}

		return custDeviceIds;

	}
	public List<Chpwebimag> getAllActiveImages ()
	{

		 List<Chpwebimag> allImagesList = null;
		try
		{

            Query qry = em.createNamedQuery("Chpwebimag.findAllActiveImages");
            
           allImagesList = qry.getResultList();
          
            Logger.getLogger("oas").debug("AuthenticateControllerBean.getAllActiveImages Found " + allImagesList.size() + " images.");

//			for (Chpwebimag activeImage : allImagesList)
//			{
//				allActiveImages.put(activeImage.getImageId().trim(), activeImage.getImageName().trim());
//			}

		}
		catch (Exception ex)
		{
			Logger.getLogger("oas").error("Exception in AuthenticateControllerBean.getAllChallengeQuestions: "+ ExceptionUtils.getFullStackTrace(ex));
			throw new EJBException(ex.getMessage());
		}

		return allImagesList;
	}	
}
