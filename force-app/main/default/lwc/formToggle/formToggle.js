import { LightningElement, api } from 'lwc';

export default class FormToggle extends LightningElement {
    @api mode;

    get toggleButtonLabel() {
        return this.mode === 'readonly' ? 'Edit' : 'Cancel';
    }

    toggleMode() {
        const event = new CustomEvent('modechange', {
            detail: { newMode: this.mode === 'readonly' ? 'edit' : 'readonly' }
        });
        this.dispatchEvent(event);
    }   
}