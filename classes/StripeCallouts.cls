public class StripeCallouts {
    
    private static final String API_KEY = StripeAPI.ApiKey; //variable holds the value of stripe api key(stored in custom settings)

    public static HttpRequest reqMethod(){
        HttpRequest request = new HttpRequest();
        Blob headerValue = Blob.valueOf(StripeAPI.ApiKey + ':');
		String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
		request.setHeader('Authorization', authorizationHeader);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        return request;
    }
    
    
    //this method will be called by createPayment() from Class StripeAppLwcController & complete the payment using intent method in stripe.
    public static Map<String,Object> createSetup_Intent(String serviceURL,String paymentMethodId,String amount,String currencyy,String paymentMethodType,String confirm){
        HttpRequest request = reqMethod();//new HttpRequest();
		request.setEndpoint(serviceURL);//+'?count='+pageSize+'&offset='+offset);
		request.setMethod('POST');
        String body = 'amount='+EncodingUtil.urlEncode(amount,'UTF-8');
        body+='&payment_method_types[]='+EncodingUtil.urlEncode(paymentMethodType,'UTF-8');
        body+='&currency='+EncodingUtil.urlEncode(currencyy,'UTF-8');
        body+='&confirm='+EncodingUtil.urlEncode(confirm,'UTF-8');
        body+='&payment_method='+EncodingUtil.urlEncode(paymentMethodId,'UTF-8');
        request.setBody(body);
        Http ht = new Http();
        HttpResponse response = ht.send(request);
        System.debug('=====>'+response.getBody());
        String t_json = response.getBody();
        Map<String,Object> mp = (Map<String,Object>)JSON.deserializeUntyped(t_json);//(t_json,Map<String,Object>.class);
        return mp;
        
    }

    
    //this method will be called by createPayment() from Class StripeAppLwcController & create payment method to complete the payment.
      public static Map<String,Object> createPaymentMethod(String serviceURL,String paymentType,String cardNumber, String expiryMonth,String expiryYear,String cvc){      
          HttpRequest request = reqMethod();
		request.setEndpoint(serviceURL);//+'?count='+pageSize+'&offset='+offset);
		request.setMethod('POST');
        String body = 'type='+EncodingUtil.urlEncode(paymentType,'UTF-8');
        body+='&card[number]='+EncodingUtil.urlEncode(cardNumber,'UTF-8');
        body+='&card[exp_month]='+EncodingUtil.urlEncode(expiryMonth,'UTF-8');
        body+='&card[exp_year]='+EncodingUtil.urlEncode(expiryYear,'UTF-8');
        body+='&card[cvc]='+EncodingUtil.urlEncode(cvc,'UTF-8');
        request.setBody(body);
        Http ht = new Http();
        HttpResponse response = ht.send(request);
        String t_json = response.getBody();
        Map<String,Object> mp = (Map<String,Object>)JSON.deserializeUntyped(t_json);//(t_json,Map<String,Object>.class);
          system.debug(response.getstatusCode());
          return mp;
        //return (String)mp.get('id');
    }
   
    
    
    //callout to issue refund for the single item in order & method will be called by createRefund() from Class StripeAppLwcController
    public static Map<String,Object> createRefundOrderLineItem(String serviceURL,String chargeId, string Amount){
        HttpRequest request = reqMethod();
		request.setEndpoint(serviceURL);//+'?count='+pageSize+'&offset='+offset);
		request.setMethod('POST');
        String body = 'payment_intent='+EncodingUtil.urlEncode(chargeId,'UTF-8');
        body+= '&amount='+EncodingUtil.urlEncode(Amount,'UTF-8');
        system.debug('Request Body -- '+body);
        request.setBody(body);
        system.debug('----===>> CompleteRequest==>'+request.getBody());
        Http http = new Http();
        HttpResponse response = http.send(request);
        String t_json;
		Integer statusCode;
       // String plink ='';
        t_json = response.getBody();
		statusCode = response.getStatusCode();
        system.debug('----===>> refundStatus==>'+statusCode);
        Map<String,Object> ls = (Map<String,Object>)JSON.deserializeUntyped(t_json);
        system.debug('==========>>>>>+++++'+(String)ls.get('id'));
        return ls;
        //return (String)ls.get('id');
    }
         
    //callout to issue refund for the entire order & method will be called by createRefundOrderLineItem() from Class StripeAppLwcController
    public static Map<String,Object> createRefundOrder(String serviceURL,String chargeId){
        HttpRequest request = reqMethod();
		request.setEndpoint(serviceURL);//+'?count='+pageSize+'&offset='+offset);
		request.setMethod('POST');
        String body = 'payment_intent='+EncodingUtil.urlEncode(chargeId,'UTF-8');
        system.debug('Request Body -- '+body);
        request.setBody(body);
        system.debug('----===>> CompleteRequest==>'+request.getBody());
        Http http = new Http();
        HttpResponse response = http.send(request);
        String t_json;
		Integer statusCode;
       // String plink ='';
        t_json = response.getBody();
		statusCode = response.getStatusCode();
        system.debug('----===>> refundStatus==>'+statusCode);
        Map<String,Object> ls = (Map<String,Object>)JSON.deserializeUntyped(t_json);
        system.debug('==========>>>>>+++++'+(String)ls.get('id'));
        //return (String)ls.get('id');
        return ls;
    }
    
    
    //callout to create product in stripe
	@future(Callout=true)
    public static void createProduct(String serviceURL,String productName){
        HttpRequest request = reqMethod();
		request.setEndpoint(serviceURL);//+'?count='+pageSize+'&offset='+offset);
		request.setMethod('POST');
        String body = 'name='+EncodingUtil.urlEncode(productName,'UTF-8');
        system.debug('Request Body -- '+body);
        request.setBody(body);
        system.debug('----===>> CompleteRequest==>'+request.getBody());
        Http http = new Http();
        HttpResponse response = http.send(request);
        String t_json;
		Integer statusCode;
       // String plink ='';
        t_json = response.getBody();
		statusCode = response.getStatusCode();
    }
}
    
    
    
    
    //Below methods can be used in future as per requirement
    
    
/*
    //this method will be used by allProducts() to get all products
    public static List<Map<String,Object>> resToJsonToList(String url,String method){
        HttpResponse response = setUrlGetResponse(url,method);
        String resBody = response.getBody();
        System.debug('=====> Products Response=='+resBody);
        Map<String,Object> responseMap = ((Map<String, Object>) JSON.deserializeUntyped(resBody));
        List<Object> listObj = (List<Object>) responseMap.get('data');
        List<Map<String,Object>> listMapProd = new List<Map<String,Object>>();
        for(Object ob : listObj){
            Map<String,Object> mapProd = (Map<String,Object>)ob;
            listMapProd.add(mapProd);
        }
        return listMapProd;
    }
    
    //this method will be used by allCustomers() to get all customers from stripe
    public static HttpResponse setUrlGetResponse(String url,String method){
		Integer status_code;
        string response;
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(url);
        httpRequest.setMethod(method);
        Blob headerValue = Blob.valueOf(API_KEY+':');
        String authorizationHeader = 'BASIC '+EncodingUtil.base64Encode(headerValue);
        httpRequest.setHeader('Authorization', authorizationHeader);
        Http http = new Http();
        HttpResponse httpResponse = http.send(httpRequest);
        return httpResponse;
    }
    

    //this method will be used by allCustomers() to get all customers from stripe
    @AuraEnabled
    public static List<Object> getCallout(){
        System.debug('========>>>> Api Key='+API_KEY);
        Integer status_code;
        string response;
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(CUSTOMER_URL);
        httpRequest.setMethod('GET');
        Blob headerValue = Blob.valueOf(API_KEY+':');
        String authorizationHeader = 'BASIC '+EncodingUtil.base64Encode(headerValue);
        httpRequest.setHeader('Authorization', authorizationHeader);
        Http http = new Http();
        HttpResponse hs = http.send(httpRequest);
        System.debug('###### Status Code='+hs.getStatusCode()+'\nStatus='+hs.getStatus());
        system.debug('########## '+hs.getBody());
        string str = hs.getBody();
        Map<String,Object> ls = (Map<String,Object>)JSON.deserializeUntyped(str);
        List<Object> ls1 = (List<Object>)ls.get('data');
        return ls1;
    }
*/