package com.acs.oas.components.ejb.authentication;



import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;


import javax.ejb.Local;

import com.acs.oas.components.entities.Chpwebimag;





/**
 * @author B0028202
 */
@Local
public interface AuthenticateControllerLocal 
{
    public void addChallengeQuestionAnswer (String cusid, String questionId, String answerText);
    public void addPicturePass (String cusid, String imageId, String picturePhraseText);
    public boolean updateAuthFlag(String custId, String flag);
    public void addDeviceToken (String cusid, String deviceId, String pcInformation);
    public boolean inActivateExistingAnswers(String cusid,String flag);
    public boolean archiveExistingPass(String cusid,String flag);
    public HashMap<String, String> getAllChallengeQuestions ();
    public List<Chpwebimag> getAllActiveImages ();
    public Hashtable getPicturePassInfoByCustId (String custid);
    public Hashtable getQuestionsByCustId (String cusid);
    public Hashtable getAllDeviceIDsByCustId (String cusid);
}
