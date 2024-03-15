import { LightningElement, api, wire } from 'lwc';
import getRelatedOpportunityList from '@salesforce/apex/OpportunityController.getRelatedOpportunityList';
import { refreshApex } from '@salesforce/apex';

export default class RelatedOppsComponent extends LightningElement {
    @api recordId;
    selectedOppId;
    selectedOppName;
    opps = [];
    response;
    displayRecordForm = false;

    @wire(getRelatedOpportunityList, {accountId: '$recordId'})
    wiredOpp(oRet){
        this.response = oRet;
        this.opps = (oRet.data) ? oRet.data : [];
        if (oRet.error) console.log("Error");
    }

    // connectedCallback() {
    //    this.getRealatedOpps();
    // }

    handleOppEvent(event) {
        const tempId = event.detail.id.split("-")[0] ?? event.detail.id;
        if (tempId != this.selectedOppId) {
            this.selectedOppId = tempId;
            this.selectedOppName = event.detail.name;
            this.displayRecordForm = true;
        } else this.displayRecordForm = false;
    }

    // getRelatedOpps() {
    //     getRelatedOpportunityList({accountId: this.recordId})
    //         .then((data) => {
    //             this.opps = data;
    //         })
    //         .catch((error) => {console.log(error);})
    //         .finally(() => {console.log("Done!");})
    // }

    refreshRecords() {
        refreshApex(this.response);
        //this.getRealatedOpps();
    }
}