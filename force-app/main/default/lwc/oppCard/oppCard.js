import { LightningElement, api } from 'lwc';

export default class OppCard extends LightningElement {
    @api id;
    @api name;
    @api stageName;
    @api amount;
    @api closeDate;

    oppSelected() {
        const myEvent = new CustomEvent('oppselected', { detail: {id: this.id,name: this.name} });
        this.dispatchEvent(myEvent);
    }
}