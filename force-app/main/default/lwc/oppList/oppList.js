import { LightningElement, api, wire } from 'lwc';
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';

export default class OppList extends LightningElement {
    @api recordId;
    
    opportunities;
    display = false;

    @wire(getRelatedListRecords, { 
        parentRecordId: '$recordId', 
        relatedListId: 'Opportunities',
        fields: ['Opportunity.Id', 'Opportunity.Name',
                 'Opportunity.StageName', 'Opportunity.CloseDate',
                 'Opportunity.Amount'] 
    })
    relatedOpps(response){
        this.opportunities = (response.data) ? response.data.records : [];
        this.display = this.opportunities.length > 0;
    }

    renderedCallback(){console.log(this.opportunities);}
}