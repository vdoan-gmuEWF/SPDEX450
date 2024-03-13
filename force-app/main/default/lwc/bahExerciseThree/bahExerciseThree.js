import { LightningElement } from 'lwc';
import getTopFiveAccounts from '@salesforce/apex/AccountController.getTopFiveAccounts';
import getRelatedOpportunity from '@salesforce/apex/OpportunityController.getRelatedOpportunity';

export default class BahExerciseThree extends LightningElement {
    showOne = false;
    showTwo = false;
    loading = null;

    accounts = [];
    opps = [];

    toggleSectionOne = () => { 
        this.showTwo = false;
        if ( this.showOne ) this.showOne = !this.showOne;
        else {
            this.loading = true;
            getTopFiveAccounts().
                then((accData) => {
                    console.log(accData);
                    this.accounts = accData;
                    this.showOne = !this.showOne;
                    this.opps = [];
                    this.accounts.forEach((e) => {
                        getRelatedOpportunity({accountId: e.Id})
                            .then((oppData) => {
                                oppData.AccountName = e.Name;
                                console.log(oppData);
                                this.opps.push(oppData);
                            })
                            .catch((error) => {console.log(error);})
                            .finally(() => {console.log("Related Opp Load Done!");})
                    })
                })
                .catch((error) => {console.log(error);})
                .finally(() => {
                    console.log("Accounts Load Done!");
                    this.loading = false;
                })
        }
     };

    toggleSectionTwo = () => {
        this.showOne = false;
        this.showTwo = !this.showTwo;
    };
}