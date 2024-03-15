import { LightningElement, api, wire } from 'lwc';
import getTopFiveAccounts from '@salesforce/apex/AccountController.getTopFiveAccounts';
import { refreshApex } from '@salesforce/apex';

export default class AcctList extends LightningElement {
    @api recordId;
    accts = [];
    selectedAcctId;
    selectedAcctName;
    response;

    @wire(getTopFiveAccounts)
    wiredOpp(oRes){
        this.response = oRes;
        this.accts = (oRes.data) ? oRes.data : [];
        if (oRes.error) console.log("Error");
    }

    handleAcctEvent(event) {
        const tempId = event.detail.id.split("-")[0] ?? event.detail.id;
        if (tempId != this.selectedOppId) {
            this.selectedAcctId = tempId;
            this.selectedAcctName = event.detail.name;
        }
    }

}