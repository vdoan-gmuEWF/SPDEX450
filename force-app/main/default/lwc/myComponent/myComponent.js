import { LightningElement } from 'lwc';

export default class MyComponent extends LightningElement {
    showContacts = false;
    #index = 0;
    contacts = [
        {Id: '111', Name: 'John', Title: 'VP'},
        {Id: '222', Name: 'Dagny', Title: 'SVP'},
        {Id: '333', Name: 'Henry', Title: 'President'},
    ];

    toggleView = () => { this.showContacts = !this.showContacts; };
    get incrementedIndex() { return ++this.#index; }
}