import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class GetRecordForm extends LightningElement {
    @api recordId; 

    @wire(getRecord, {recordId: '$recordId', fields: [NAME_FIELD, PHONE_FIELD, TITLE_FIELD, EMAIL_FIELD]}) 
    contact;

    renderedCallback(){console.log(this.contact);}
}