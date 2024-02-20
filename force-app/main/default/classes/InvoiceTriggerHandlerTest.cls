@isTest
private class InvoiceTriggerHandlerTest {

    @isTest
    private static void createInvoiceWithTermsTest(){
        testDataFactory.createSingleAccWithOppTermsApplied();
        Opportunity oOpportunity = [ SELECT Id, OwnerId FROM Opportunity LIMIT 1 ];
        Test.startTest();
            oOpportunity.StageName = 'Closed Won';
            update oOpportunity;
        Test.stopTest();
        
        Invoices__c oNewInvoice = [ SELECT Id, Due_Date__c, Invoiced_Date__c FROM Invoices__c LIMIT 1 ];
        System.assertEquals( oNewInvoice.Due_Date__c, Date.today() + 30, 'Incorrect due date');
        System.assertEquals( oNewInvoice.Invoiced_Date__c, Date.today() - 30, 'Incorrect invoiced date');
    }

    @isTest
    private static void applySharingTest() {

        testDataFactory.createSingleAccWithOpp();
        Opportunity oOpportunity = [ SELECT Id, OwnerId FROM Opportunity LIMIT 1 ];
        Test.startTest();
            oOpportunity.StageName = 'Closed Won';
            update oOpportunity;
        Test.stopTest();

        Invoices__c oNewInvoice = [ SELECT Id, Amount__c, Opportunity__c, Opportunity__r.OwnerId, Account__c FROM Invoices__c LIMIT 1 ];

        Boolean parentMatch, userMatch, causeMatch, accessMatch;
        for ( Invoices__Share is : [ SELECT Id, ParentId, UserOrGroupId, RowCause, AccessLevel FROM Invoices__Share ] ) {
            if ( is.ParentId == oNewInvoice.Id ) { 
                if ( is.UserOrGroupId == oOpportunity.OwnerId ) {
                    if ( is.RowCause == 'Opportunity_Owner__c') {
                        causeMatch  = true;
                        userMatch   = true;
                        parentMatch = true;
                        if ( is.AccessLevel == 'Read' ) { accessMatch = true; }
                    }
                }
            }
        }

        System.assertEquals( true, parentMatch, 'Share record not connected to the expected parent');
        System.assertEquals( true, userMatch, 'Share record not connected to the expected user');
        System.assertEquals( true, causeMatch, 'Share record not designated to correct cause');
        System.assertEquals( true, accessMatch, 'Share record not provision with the correct access level');

    }

    @isTest
    private static void applySharingUpdateTest() {

        testDataFactory.createSingleAccWithOpp();
        Opportunity oOpportunity = [ SELECT Id, OwnerId FROM Opportunity LIMIT 1 ];
            oOpportunity.StageName = 'Closed Won';
            update oOpportunity;
        

        Invoices__c oNewInvoice = [ SELECT Id, Amount__c, Opportunity__c, Opportunity__r.OwnerId, Account__c FROM Invoices__c LIMIT 1 ];
        Test.startTest();
            oNewInvoice.Amount__c = 68686;
            update oNewInvoice;
        Test.stopTest();

        Boolean parentMatch, userMatch, causeMatch, accessMatch;
        for ( Invoices__Share is : [ SELECT Id, ParentId, UserOrGroupId, RowCause, AccessLevel FROM Invoices__Share ] ) {
            if ( is.ParentId == oNewInvoice.Id ) { 
                if ( is.UserOrGroupId == oOpportunity.OwnerId ) {
                    if ( is.RowCause == 'Opportunity_Owner__c') {
                        causeMatch  = true;
                        userMatch   = true;
                        parentMatch = true;
                        if ( is.AccessLevel == 'Read' ) { accessMatch = true; }
                    }
                }
            }
        }

        System.assertEquals( true, parentMatch, 'Share record not connected to the expected parent');
        System.assertEquals( true, userMatch, 'Share record not connected to the expected user');
        System.assertEquals( true, causeMatch, 'Share record not designated to correct cause');
        System.assertEquals( true, accessMatch, 'Share record not provision with the correct access level');
        
    }
}