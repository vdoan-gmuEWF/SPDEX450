trigger applyNamingConventrion on Opportunity ( before insert, before update ) {
    /*
     * trigger.new will be a List<Opportunity> that need to be processed
     * Naming conventrion is Account Name - Opportunity Type - CloseMonth/CloseYear
     * Retrieve any Account Names that we need
     * Update all the Opportunites so that the name field mathces the convention
     * Update opportunites - NOT NECESSARY because it is a before trigger
     */

    Map<Id, Account> parentAccounts  = new Map<Id, Account>();
    Set<Id>          parentIds       = new Set<Id>();

    for ( Opportunity o : trigger.new ) { parentIds.add( o.AccountId ); }

    for ( Account a : [ SELECT Id, Name FROM Account WHERE Id IN :parentIds ] ) { 
        parentAccounts.put( a.Id, a ); 
    }

    for ( Opportunity o : trigger.new ) {
        o.Name = parentAccounts.get( o.AccountId ).Name + ' - ' + 
                 o.Type + ' - ' + 
                 String.valueof( o.CloseDate.month() ) + '/' + 
                 String.valueof( o.CloseDate.year() );
    }
    
}