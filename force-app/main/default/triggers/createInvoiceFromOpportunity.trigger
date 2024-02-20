trigger createInvoiceFromOpportunity on Opportunity ( after insert, after update ) {
    List<Invoices__c> invoiceToCreate    = new List<Invoices__c>();

    for ( Opportunity o : trigger.new ) {
        if ( ( trigger.isInsert && o.isWon ) || 
             ( trigger.isUpdate && ( o.isWon && !trigger.oldMap.get( o.id ).isWon ) ) ) {
                Invoices__c newInvoice       = new Invoices__c();
                newInvoice.Account__c       = o.AccountId;
                newInvoice.Opportunity__c   = o.Id;
                newInvoice.Amount__c        = o.Amount;
                newInvoice.Due_Date__c      = o.CloseDate + 30;
                invoiceToCreate.add( newInvoice );
        }
    }

    if ( !invoiceToCreate.isEmpty() ) { Database.insert( invoiceToCreate, false ); }
}