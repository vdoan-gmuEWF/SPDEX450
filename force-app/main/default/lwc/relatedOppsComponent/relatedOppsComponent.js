import { LightningElement, api } from 'lwc';
import getRelatedOpportunityList from '@salesforce/apex/OpportunityController.getRelatedOpportunityList';

export default class RelatedOppsComponent extends LightningElement {
    @api recordId;
    selectedOppId;
    selectedOppName;
    opps = [];
    displayRecordForm = false;
    connectedCallback() {
        this.getRealatedOpps();
    }

    handleOppEvent(event) {
        const tempId = event.detail.id.split("-")[0] ?? event.detail.id;
        if (tempId != this.selectedOppId) {
            this.selectedOppId = tempId;
            this.selectedOppName = event.detail.name;
            this.displayRecordForm = true;
        } else this.displayRecordForm = false;
    }

    getRealatedOpps() {
        getRelatedOpportunityList({accountId: this.recordId})
            .then((data) => {
                this.opps = data;
            })
            .catch((error) => {console.log(error);})
            .finally(() => {console.log("Done!");})
    }

    refreshRecords() {
        this.getRealatedOpps();
    }
}