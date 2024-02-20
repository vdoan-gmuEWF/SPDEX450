@isTest
public class testDataFactory {

    static Account createValidAccount( String aName ) {
       Account a    = new Account();
       a.Name       = aName;
       return a; 
    }

    static Account createValidAccount( String aName, String terms ) {
        Account a    = new Account();
        a.Name       = aName;
        a.Terms__c   = terms;
        return a; 
     }

    static Opportunity createValidOpportunity( Id accId, Date cDate, Decimal amount, String type, String stage ) {
        Opportunity o   = new Opportunity();
        o.Name          = 'Test Opp';
        o.Amount        = amount;
        o.Type          = type;
        o.StageName     = stage;
        o.CloseDate     = cDate;
        o.AccountId     = accId;
        return o;

    }

    public static void createSingleAccWithOpp() {
        Account a = createValidAccount( 'Test Account' );
        insert a;

        Opportunity o = createValidOpportunity(a.Id, Date.today(), 3456, 'New Customer', 'Prospecting');
        insert o;
    }

    public static void createSingleAccWithOppTermsApplied() {
        Account a = createValidAccount( 'Test Account', 'Net 30' );
        insert a;

        Opportunity o = createValidOpportunity(a.Id, Date.today(), 3456, 'New Customer', 'Prospecting');
        insert o;
    }
}