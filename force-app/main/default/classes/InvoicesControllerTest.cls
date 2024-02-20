@isTest
private class InvoicesControllerTest {

    @isTest
    private static void saveTest() {
        Account oTestAccount                    = new Account( Name = 'Test' );
            insert oTestAccount;
        Opportunity oTestOpportunity            = new Opportunity();
            oTestOpportunity.AccountId  = oTestAccount.Id;
            oTestOpportunity.Name       = 'Test';
            oTestOpportunity.Type       = 'New Customer';
            oTestOpportunity.Amount     = 120000;
            oTestOpportunity.StageName  = 'Closed Lost';
            oTestOpportunity.CloseDate  = Date.today();
        insert oTestOpportunity;

        ApexPages.StandardSetController oTestSsc = new ApexPages.StandardSetController( new List<Opportunity>{oTestOpportunity} );

        Invoices__c oTestInvoice = new Invoices__c();
            oTestInvoice.Opportunity__c = oTestOpportunity.Id;
            oTestInvoice.Account__c     = oTestOpportunity.AccountId;
            oTestInvoice.Amount__c      = oTestOpportunity.Amount;
            oTestInvoice.Due_Date__c    = oTestOpportunity.CloseDate + 90;

        PageReference testPage = new PageReference( '/' );
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', oTestOpportunity.Id);
        
        InvoicesController invoiceExtensions = new InvoicesController( oTestSsc );
            invoiceExtensions.newInvoices.add( oTestInvoice );

        Test.startTest();
        PageReference oTestPageReference = invoiceExtensions.save();
        Test.stopTest();

        System.assertEquals( '/' + oTestOpportunity.Id, oTestPageReference.getUrl(), 'Incorrect return URL' );

        List<Invoices__c> lSavedInvoices = [ SELECT Id FROM Invoices__c ];
        System.assertEquals( 1, lSavedInvoices.size(), 'Incorrect number of invoices created');
    }

    @isTest
    private static void saveCancel() {
        Account oTestAccount                    = new Account( Name = 'Test' );
            insert oTestAccount;
        Opportunity oTestOpportunity            = new Opportunity();
            oTestOpportunity.AccountId  = oTestAccount.Id;
            oTestOpportunity.Name       = 'Test';
            oTestOpportunity.Type       = 'New Customer';
            oTestOpportunity.Amount     = 120000;
            oTestOpportunity.StageName  = 'Closed Lost';
            oTestOpportunity.CloseDate  = Date.today();
        insert oTestOpportunity;

        ApexPages.StandardSetController oTestSsc = new ApexPages.StandardSetController( new List<Opportunity>{oTestOpportunity} );

        Invoices__c oTestInvoice = new Invoices__c();
            oTestInvoice.Opportunity__c = oTestOpportunity.Id;
            oTestInvoice.Account__c     = oTestOpportunity.AccountId;
            oTestInvoice.Amount__c      = oTestOpportunity.Amount;
            oTestInvoice.Due_Date__c    = oTestOpportunity.CloseDate + 90;

        PageReference testPage = new PageReference( '/' );
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', oTestOpportunity.Id);
        
        InvoicesController invoiceExtensions = new InvoicesController( oTestSsc );
            invoiceExtensions.newInvoices.add( oTestInvoice );

        Test.startTest();
        PageReference oTestPageReference = invoiceExtensions.cancel();
        Test.stopTest();

        System.assertEquals( '/' + oTestOpportunity.Id, oTestPageReference.getUrl(), 'Incorrect return URL' );

        List<Invoices__c> lSavedInvoices = [ SELECT Id FROM Invoices__c ];
        System.assertEquals( 0, lSavedInvoices.size(), 'Incorrect number of invoices created');
    }

    @isTest
    private static void saveTestWithTermsApplied() {
        Account oTestAccount                    = new Account( Name = 'Test' );
            oTestAccount.Terms__c = 'Net 30';
            insert oTestAccount;
        Opportunity oTestOpportunity            = new Opportunity();
            oTestOpportunity.AccountId  = oTestAccount.Id;
            oTestOpportunity.Name       = 'Test';
            oTestOpportunity.Type       = 'New Customer';
            oTestOpportunity.Amount     = 120000;
            oTestOpportunity.StageName  = 'Closed Lost';
            oTestOpportunity.CloseDate  = Date.today();
        insert oTestOpportunity;

        ApexPages.StandardSetController oTestSsc = new ApexPages.StandardSetController( new List<Opportunity>{oTestOpportunity} );

        Invoices__c oTestInvoice = new Invoices__c();
            oTestInvoice.Opportunity__c     = oTestOpportunity.Id;
            oTestInvoice.Account__c         = oTestOpportunity.AccountId;
            oTestInvoice.Amount__c          = oTestOpportunity.Amount;
            oTestInvoice.Due_Date__c        = oTestOpportunity.CloseDate + 30;
            oTestInvoice.Invoiced_Date__c   = oTestOpportunity.CloseDate - 30;

        PageReference testPage = new PageReference( '/' );
        Test.setCurrentPage(testPage);
        ApexPages.currentPage().getParameters().put('id', oTestOpportunity.Id);
        
        InvoicesController invoiceExtensions = new InvoicesController( oTestSsc );
            invoiceExtensions.newInvoices.add( oTestInvoice );

        Test.startTest();
        PageReference oTestPageReference = invoiceExtensions.save();
        Test.stopTest();

        System.assertEquals( '/' + oTestOpportunity.Id, oTestPageReference.getUrl(), 'Incorrect return URL' );

        List<Invoices__c> lSavedInvoices = [ SELECT Id, Due_Date__c, Invoiced_Date__c FROM Invoices__c ];
        System.assertEquals( 1, lSavedInvoices.size(), 'Incorrect number of invoices created');

        System.debug(lSavedInvoices[0].Id);
        System.debug(lSavedInvoices[0].Due_Date__c);
        System.debug(lSavedInvoices[0].Invoiced_Date__c);

        System.assertEquals( lSavedInvoices[0].Due_Date__c, Date.today() + 30, 'Incorrect due date');
        System.assertEquals( lSavedInvoices[0].Invoiced_Date__c, Date.today() - 30, 'Incorrect invoiced date');
    }

}