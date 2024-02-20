public with sharing class InvoiceTriggerHandler {
    
    public static void applySharing( List<Invoices__c> triggernew ) {

        Set<Id> lOpprotunityIds = new Set<Id>();
        for ( Invoices__c invoice : triggernew ) { lOpprotunityIds.add( invoice.Opportunity__c ); }

        Map<Id, Id> mOwnerIds = new Map<Id, Id>();
        for ( Opportunity o : [ SELECT Id, OwnerId FROM Opportunity WHERE Id IN :lOpprotunityIds WITH SECURITY_ENFORCED ]) {
            mOwnerIds.put( o.Id, o.OwnerId );
        }

        Group svpGroup = [ SELECT Id, DeveloperName FROM Group WHERE DeveloperName = 'SVPCustomerServiceSupportA' WITH SECURITY_ENFORCED LIMIT  1 ];

        List<Invoices__Share> lNewShares = new List<Invoices__Share>();
        for ( Invoices__c invoice : triggernew ) {
            Invoices__Share oOwnerShare = new Invoices__Share();
                oOwnerShare.ParentId        = invoice.Id;
                oOwnerShare.UserOrGroupId   = mOwnerIds.get( invoice.Opportunity__c );
                oOwnerShare.AccessLevel     = 'Read';
                oOwnerShare.RowCause        = Schema.Invoices__Share.RowCause.Opportunity_Owner__c;
            lNewShares.add( oOwnerShare );
        }
        insert lNewShares;

    }

}