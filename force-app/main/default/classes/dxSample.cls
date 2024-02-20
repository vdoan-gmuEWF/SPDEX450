public with sharing class dxSample {
    public dxSample() {
        Account a =  new Account( Name = 'Test Account', AnnualRevenue = 10000, Rating = 'Hot' );
        // insert a;
        Contact c = new Contact( FirstName = 'Vu', LastName = 'Doan' );
        c.AccountId = a.Id;
        // insert c;
    }
}