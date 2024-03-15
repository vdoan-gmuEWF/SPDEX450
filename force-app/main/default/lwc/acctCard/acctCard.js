import { LightningElement, api } from 'lwc';
import getRelatedContactList from '@salesforce/apex/ContactController.getRelatedContactList';

export default class AcctCard extends LightningElement {
    @api phone;
    @api annualRevenue;
    @api id;
    @api name;

    show = false;
    relatedContacts = [];    

    acctSelected() {
        const myEvent = new CustomEvent('acctselected', { detail: {id: this.id,name: this.name} });
        this.dispatchEvent(myEvent);
    }

    showRelatedContacts() {
        this.show = !this.show;
        const parameter = this.id.split("-")[0] ?? this.id;
        getRelatedContactList({accountId: parameter})
            .then((data) => {
                this.relatedContacts = data;
                console.log(this.relatedContacts);
                
            })
            .catch((error) => {console.log(error);})
            .finally(() => {console.log("Done!");})
    }
}