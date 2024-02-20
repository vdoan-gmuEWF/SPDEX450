trigger updateOpportunityFromAccount on Account ( after update ) {
    Set<Id> accountIds = new Set<Id>();
    for ( Account a : trigger.new ) {
        if ( a.Name != trigger.oldMap.get( a.Id ).Name ) { accountIds.add( a.Id ); } 
    }

    List<Opportunity> opportunitiesToUpdate = [ SELECT Id FROM Opportunity WHERE AccountId IN :accountIds ];

    List<Database.SaveResult> srlist = Database.update(opportunitiesToUpdate, false);

    for ( Database.SaveResult sr : srlist ) { System.Debug( 'Success? ' + sr.isSuccess() ); }
}