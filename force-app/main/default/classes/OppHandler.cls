public with sharing class OppHandler {

    public static void applyNamingConvention( List<Opportunity> triggernew ) {
        Map<Id, Account> parentAccounts  = new Map<Id, Account>();
        Set<Id>          parentIds       = new Set<Id>();
    
        for ( Opportunity o : triggernew ) { parentIds.add( o.AccountId ); }
    
        for ( Account a : [ SELECT Id, Name FROM Account WHERE Id IN :parentIds WITH SECURITY_ENFORCED ] ) { 
            parentAccounts.put( a.Id, a ); 
        }
    
        for ( Opportunity o : triggernew ) {
            o.Name = parentAccounts.get( o.AccountId ).Name + ' - ' + 
                     o.Type + ' - ' + 
                     String.valueof( o.CloseDate.month() ) + '/' + 
                     String.valueof( o.CloseDate.year() );
        }        
    }

    public static Invoices__c createInvoice( Opportunity o ) {

        Account oTermsAppliedAccount = [ SELECT Terms__c FROM Account WHERE Id = :o.AccountId WITH SECURITY_ENFORCED LIMIT 1 ];

        Date termsAppliedDueDate, invoicedDate;

        if ( oTermsAppliedAccount.Terms__c == 'Net 30' ) { 
            termsAppliedDueDate = o.CloseDate + 30;
            invoicedDate        = o.CloseDate - 30;
        } else if ( oTermsAppliedAccount.Terms__c == 'Net 60' ) { 
            termsAppliedDueDate = o.CloseDate + 60;
            invoicedDate        = o.CloseDate - 60;  
        } else if ( oTermsAppliedAccount.Terms__c == 'Net 90' ) {
            termsAppliedDueDate = o.CloseDate + 90;
            invoicedDate        = o.CloseDate - 90;
        } else { 
            termsAppliedDueDate = o.CloseDate;
            invoicedDate        = o.CloseDate; 
        }

        Invoices__c newInvoice       = new Invoices__c();
            newInvoice.Account__c         = o.AccountId;
            newInvoice.Opportunity__c     = o.Id;
            newInvoice.Amount__c          = o.Amount;
            newInvoice.Due_Date__c        = termsAppliedDueDate;
            newInvoice.Invoiced_Date__c   = invoicedDate;
        return newInvoice;
    }

    public static void createInvoiceFromOpportunity( List<Opportunity> triggernew, Map<Id, Opportunity> triggeroldMap ) {

        List<Invoices__c> invoiceToCreate = new List<Invoices__c>();

        for ( Opportunity o : triggernew ) {
            if ( o.isWon && !triggeroldMap.get( o.id ).isWon ) {
                invoiceToCreate.add( createInvoice(o) );
            }
        }
    
        if ( !invoiceToCreate.isEmpty() ) { Database.insert( invoiceToCreate, false ); }
    }

    public static void createInvoiceFromOpportunity( List<Opportunity> triggernew ) {
        List<Invoices__c> invoiceToCreate = new List<Invoices__c>();

        for ( Opportunity o : triggernew ) {
            if ( o.isWon ) { invoiceToCreate.add( createInvoice(o) ); }
        }

        if ( !invoiceToCreate.isEmpty() ) { Database.insert( invoiceToCreate, false ); }
    }
}