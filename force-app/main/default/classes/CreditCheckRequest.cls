global class CreditCheckRequest {

    @InvocableMethod( label = 'Credit Check Request' description = 'Sends a request to Credit Check service')
    global static void creditCheck( List<String>accountIds ) {
        callCreditCheckAPI( accountIds[0] );
    }

    @future( callout = true )
    public static void callCreditCheckAPI( String accountId ) {

        Account oAccount = [ SELECT Id, Name, CreditCheckId__c, Owner.Name, Owner.Email FROM Account WHERE Id = :accountId WITH SECURITY_ENFORCED LIMIT 1 ];

        String sUrl = 'https://steve-wasula-splx201-dev-ed.my.salesforce-sites.com/creditcheck';
        sUrl += '?name=' + EncodingUtil.urlEncode( oAccount.Name, 'UTF-8' );
        sUrl += '&email=' + oAccount.Owner.Email;
        sUrl += '&requestor=' + EncodingUtil.urlEncode( oAccount.Owner.Name, 'UTF-8' );

        Http oHttp              = new Http();
        HttpRequest oRequest    = new HttpRequest();
            oRequest.setEndpoint( sUrl );
            oRequest.setMethod( 'GET' );

        HttpResponse oResponse  = oHttp.send( oRequest );

        if ( oResponse.getStatusCode() == 200 ) {
            CreditCheckResponse oCreditCheckResponse = ( CreditCheckResponse ) JSON.deserialize( oResponse.getBody(), CreditCheckResponse.class );
            oAccount.CreditCheckId__c = oCreditCheckResponse.Id;
                update oAccount;
        }

    }

    public class CreditCheckResponse {

        public String type;
        public String url;
        public String Company_Name_c;
        public String Requestor_Name_c;
        public String Requestor_Email_c;
        public String Name;
        public String Id;
        
    }
}
