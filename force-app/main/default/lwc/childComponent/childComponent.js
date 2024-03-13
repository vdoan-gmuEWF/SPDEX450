import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api childName;
    @api age;

    childSaid = false;

    respondToParent() {
        this.childSaid = !this.childSaid;
        const myEvent = new CustomEvent('crying', {detail: this.childSaid});
        this.dispatchEvent(myEvent);
    }

    constructor() {
        super();
        console.log('Child component constructor fired...');
    }
    connectedCallback() {
        console.log('Child component connectedCallback fired...');
    }
    disconnectedCallback() {
        console.log('Child disconnectedCallback fired...');
    }
    renderedCallback() {
        console.log('Child component renderCallback fired');
    }
}