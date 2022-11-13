/**
 * @description       : 
 * @author            : SUDEER K
 * @group             : 
 * @last modified on  : 11-13-2022
 * @last modified by  : SUDEER K
 * Modifications Log
 * Ver   Date         Author     Modification
 * 1.0   11-13-2022   SUDEER K   Initial Version
**/
public with sharing class newsController {
    @AuraEnabled
    public static Map<String, Object> retriveNews(){
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint('https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=YOUR_API_KEY');
        httpRequest.setMethod('GET');

        Map<String, Object> newsJsonData = new Map<String, Object>();
        String strResponse = null;

        try{
            Http http = new Http();
            HttpResponse httpResponse = http.send(httpRequest);
            if(httpResponse.getStatusCode() == 200){
                strResponse = httpResponse.getBody();
            } else {
                throw new CalloutException(httpResponse.getBody());
            }

        } catch(Exception ex){
            throw ex;
        }

        if(!String.isBlank(strResponse)){
            newsJsonData = (Map<String, Object>)JSON.deserializeUntyped(strResponse);
        }
        if(!newsJsonData.isEmpty()){
            return newsJsonData;
        } else {
            return null;
        }
    }
}
