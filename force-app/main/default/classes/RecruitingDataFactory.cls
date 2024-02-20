/*
As a developer, I need to be able to generate test data for unit tests so that I can build robust tests.
NOTE: for our purposes - create a solution that will create test data such as:
One or more positions based on status
One or more applications for a position (including an attached contact)
One or more reviews for an applicant (including an attached interviewer)
THIS ONE WILL BE HARD IN THE DEVELOPER ORGS SO JUST ALLOW FOR TWO USERS 
*/
@isTest
public class RecruitingDataFactory {

    public static void createSimpleScenario( String sType ) {

        Integer iCreateNum = ( sType == 'Single' ) ? 1 : 201;

        List<Position__c> lNewPositions         = createPositions( 'Open', iCreateNum );
            insert lNewPositions;
        List<Application__c> lNewApplications   = createApplications( 1, lNewPositions );
            System.Debug( lNewApplications );
            insert lNewApplications;

    }

    public static List<Position__c> createPositions( String sStatus, Integer iCreateNum ) {

        Set<String>         lValidStatuses  = new Set<String>{ 'New', 'Open', 'Closed' };
        List<Position__c>   lNewPositions   = new List<Position__c>();
        
        if ( !lValidStatuses.contains( sStatus ) ) { 
            System.Debug( 'Invalid status was passed to createPositions()' );
            return lNewPositions;
        } 
        
        User oHiringManager = [ SELECT Id FROM User WHERE Profile.Name = 'System Administrator' LIMIT 1 ];

        for( Integer i = 0; i < iCreateNum; i++ ) {
            Position__c oPosition = new Position__c();
                oPosition.Name                = 'Test Position #' + String.valueOf( i );
                oPosition.Hiring_Manager__c   = oHiringManager.Id;
                oPosition.Description__c      = 'Description of position';
                oPosition.Due_Date__c         = Date.today() + 90;
                oPosition.Status__c           = sStatus;
            lNewPositions.add( oPosition );
        }

        return lNewPositions;
    }

    public static List<Application__c> createApplications( Integer iCreateNum, List<Position__c> lPositions ) {

        List<Application__c> lApplications  = new List<Application__c>();
        Account oUmbrellaAccount            = new Account( Name = 'Umbrella Account' );
            insert oUmbrellaAccount;
        RecordType oCandidateType           = [ SELECT Id FROM RecordType WHERE Name = 'Candidates' LIMIT 1 ];
        List<Contact> lNewCandidtates       = new List<Contact>();

        for ( Integer i = 0; i < iCreateNum; i++ ) {
            Contact oNewContact = new Contact();
                oNewContact.FirstName       = 'Test';
                oNewContact.LastName        = 'Candidate #' + String.valueOf( i );
                oNewContact.AccountId       = oUmbrellaAccount.Id;
                oNewContact.RecordTypeId    = oCandidateType.Id;
            lNewCandidtates.add( oNewContact );
        }
        insert lNewCandidtates;

        for ( Position__c p : lPositions ) {
            for ( Contact c : lNewCandidtates ) {
                Application__c oNewApplication = new Application__c();
                    oNewApplication.Name            = 'New App';
                    oNewApplication.Candidate__c    = c.Id;
                    oNewApplication.Position__c     = p.Id;
                    oNewApplication.Status__c       = 'Applied';
                lApplications.add( oNewApplication );
                System.Debug( oNewApplication );
            }
        }

        return lApplications;
    }

    public static Interviewer__c createInterviewer( Id positionId, Id userId ) {
        
        Interviewer__c oNewInterviewer = new Interviewer__c();
            oNewInterviewer.Name            = 'New Test Interviewer';
            oNewInterviewer.Interviewer__c  = userId;
            oNewInterviewer.Position__c     = positionId;
        return oNewInterviewer;

    }

}