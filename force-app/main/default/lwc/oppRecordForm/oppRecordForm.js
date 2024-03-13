import { LightningElement, api } from 'lwc';

export default class OppRecordForm extends LightningElement {
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApiName;
    @api layoutType;
    @api mode

    handleModeChange(event) {
        this.mode = event.detail.newMode;
    }

    handleSuccess() {
        this.mode = 'readonly';
    }
}