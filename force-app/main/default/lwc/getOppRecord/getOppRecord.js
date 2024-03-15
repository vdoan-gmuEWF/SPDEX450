import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import TYPE_FIELD from '@salesforce/schema/Opportunity.Type';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import STAGE_NAME_FIELD from '@salesforce/schema/Opportunity.StageName';

export default class GetOppRecord extends LightningElement {
    @api recordId; 

    @wire(getRecord, {recordId: '$recordId', fields: [NAME_FIELD, TYPE_FIELD, AMOUNT_FIELD, STAGE_NAME_FIELD]}) 
    opportunity;

    renderedCallback(){console.log(this.opportunity);}
}