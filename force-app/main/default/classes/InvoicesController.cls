public with sharing class InvoicesController {

    private Id                  sOpportunityId;
    public Opportunity          oOpportunity        { get; set; }
    public Decimal              totalInvoices       { get; set; }
    public Decimal              invoiceRemainder    { get; set; }
    public List<Invoices__c>    newInvoices         { get; set; }
    public Boolean              isBalanced          { get; set; }
    
    public InvoicesController( ApexPages.StandardSetController ssc ) {
        sOpportunityId = ApexPages.currentPage().getParameters().get('id');
        loadOpportunity();
    }

    private void loadOpportunity() {
        invoiceRemainder = 0;
        oOpportunity = [ SELECT Id, AccountId, Amount, CloseDate,
                         ( SELECT ID, Account__c, Opportunity__c, Amount__c, Due_Date__c, Invoiced_Date__c FROM Invoice__r )
                         FROM Opportunity 
                         WHERE Id = :sOpportunityId
                         WITH SECURITY_ENFORCED
                         LIMIT 1  ];

        Account oTermsAppliedAccount = [ SELECT Terms__c FROM Account WHERE Id = :oOpportunity.AccountId WITH SECURITY_ENFORCED LIMIT 1 ];

        Date termsAppliedDueDate, invoicedDate;

        if ( oTermsAppliedAccount.Terms__c == 'Net 30' ) { 
            termsAppliedDueDate = oOpportunity.CloseDate.addDays( 30 );
            invoicedDate        = oOpportunity.CloseDate.addDays( -30 );
        } else if ( oTermsAppliedAccount.Terms__c == 'Net 60' ) { 
            termsAppliedDueDate = oOpportunity.CloseDate.addDays( 60 );
            invoicedDate        = oOpportunity.CloseDate.addDays( -60 );  
        } else if ( oTermsAppliedAccount.Terms__c == 'Net 90' ) {
            termsAppliedDueDate = oOpportunity.CloseDate.addDays( 90 );
            invoicedDate        = oOpportunity.CloseDate.addDays( -90 );
        } else { 
            termsAppliedDueDate = oOpportunity.CloseDate;
            invoicedDate        = oOpportunity.CloseDate; 
        }

        System.debug('CloseDate');
        System.debug(oOpportunity.CloseDate);ion
        System.debug('termsAppliedDueDate');
        System.debug(termsAppliedDueDate);
        System.debug('invoicedDate');
        System.debug(invoicedDate);

        if ( oOpportunity.Invoice__r.size() > 0) {
            newInvoices = new List<Invoices__c>( oOpportunity.Invoice__r );
            for ( Integer i = 0; i < ( 12 - oOpportunity.Invoice__r.size() ) ; i++ ) {
                Invoices__c oInvoice = new Invoices__c();
                    oInvoice.Opportunity__c     = sOpportunityId;
                    oInvoice.Account__c         = oOpportunity.AccountId;
                    oInvoice.Amount__c          = 0;
                    oInvoice.Due_Date__c        = termsAppliedDueDate;
                    oInvoice.Invoiced_Date__c   = invoicedDate;
                newInvoices.add( oInvoice );
            }            
        } else {
            newInvoices = new List<Invoices__c>();
            for ( Integer i = 0; i < 12 ; i++ ) {
                Invoices__c oInvoice = new Invoices__c();
                    oInvoice.Opportunity__c     = sOpportunityId;
                    oInvoice.Account__c         = oOpportunity.AccountId;
                    oInvoice.Amount__c          = 0;
                    oInvoice.Due_Date__c        = termsAppliedDueDate;
                    oInvoice.Invoiced_Date__c   = invoicedDate;
                newInvoices.add( oInvoice );
            }            
        }
        
        recalcTotalInvoices();
    }

    public PageReference save() {
        List<Invoices__c> lInvoiceToCreate = new List<Invoices__c>();
        List<Invoices__c> lInvoiceToUpdate = new List<Invoices__c>();
        List<Invoices__c> lInvoiceToDelete = new List<Invoices__c>();

        for ( Invoices__c invoice : newInvoices ) {
            if ( invoice.Amount__c > 0 ) { 
                if ( invoice.Id != null ) { lInvoiceToUpdate.add( invoice ); }
                else { lInvoiceToCreate.add( invoice ); }
            } else {
                if ( invoice.Id != null ) { lInvoiceToDelete.add( invoice ); }
            }
        }

        delete lInvoiceToDelete;
        update lInvoiceToUpdate;
        insert lInvoiceToCreate;

        PageReference pageReference = new PageReference('/' + sOpportunityId);
        return pageReference;
    }

    public PageReference cancel() {
        PageReference pageReference = new PageReference('/' + sOpportunityId);
        return pageReference;
    }

    public void recalcTotalInvoices() {
        totalInvoices = 0;
        if ( newInvoices != null ) {
            for ( Invoices__c invoice : newInvoices ) {
                totalInvoices += invoice.Amount__c;
            }
        }
        invoiceRemainder = oOpportunity.Amount - totalInvoices;
        isBalanced = ( invoiceRemainder == 0 ) ? true : false;
    }

}