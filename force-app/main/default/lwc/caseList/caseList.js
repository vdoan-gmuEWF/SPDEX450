import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class CaseList extends LightningElement {
    @api recordId;
    
    cases;
    display = false;

    @wire(getRelatedListRecords, { 
        parentRecordId: '$recordId', 
        relatedListId: 'Cases',
        fields: ['Case.Id', 'Case.Subject',
                 'Case.Status', 'Case.Priority',
                 'Case.CaseNumber'] 
    })
    relatedCases(response){
        this.cases = (response.data) ? response.data.records : [];
        this.display = this.cases.length > 0;
    }

    renderedCallback(){console.log(this.cases);}
}