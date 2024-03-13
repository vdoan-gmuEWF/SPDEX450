import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    childSpeak;
    handleFit(event){
        console.log(event);
        this.childSpeak = event.detail;
    }
    constructor() {
        super();
        console.log('Parent component constructor fired...');
    }
    connectedCallback() {
        console.log('Parent component connectedCallback fired...');
    }
    disconnectedCallback() {
        console.log('Parent disconnectedCallback fired...');
    }
    renderedCallback() {
        console.log('Parent component renderCallback fired');
    }
}