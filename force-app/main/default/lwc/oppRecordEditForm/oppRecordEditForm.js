import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name'
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount'
import CLOSE_DATE_FIELD from '@salesforce/schema/Opportunity.CloseDate'
import STAGE_NAME_FIELD from '@salesforce/schema/Opportunity.StageName'

export default class OppRecordEditForm extends LightningElement {
    @api recordId;
    @api objectApiName;

    editMode = false;
    nameField = NAME_FIELD;
    amountField = AMOUNT_FIELD;
    closeDateField = CLOSE_DATE_FIELD;
    stageNameField = STAGE_NAME_FIELD;

    toggleMode() {this.editMode = !this.editMode;}
}