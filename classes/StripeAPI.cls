global class StripeAPI {
    global static string ApiKey{
        get{
            Stripe_Settings__c s = Stripe_Settings__c.getInstance();
            if(s!=null){
                return s.Stripe_Secret_Live_Key__c;
            }
         return null;   // testing comment
        }
    }
    /*
    
    global static String PublishableKey{
        get{
            Stripe_Settings__c s = Stripe_Settings__c.getInstance();
            if(s!=null){
                return s.Stripe_Publishable_Live_Key__c;
                /*if(StripeAPI.isTest){
                    return s.Stripe_Publishable_Test_Key__c;
                }else{
                    return s.Stripe_Publishable_Live_Key__c;
                }
            }
            return null;
        }
    } */
}