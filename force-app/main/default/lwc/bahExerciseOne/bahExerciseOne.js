import { LightningElement } from 'lwc';
import GenWattStyle from '@salesforce/resourceUrl/GenWattStyle';
import { loadStyle } from 'lightning/platformResourceLoader';

export default class BahExerciseOne extends LightningElement {
    firstName;
    lastName;
    jobTitle;

    constructor() {
        super();

        this.firstName = "Vu";
        this.lastName = "Doan";
        this.jobTitle = "Technologist";

        loadStyle(this, GenWattStyle)
        .then(() => {console.log("Styling now...")})
        .catch((error) => { console.log(`No styles loaded. Error: ${error}`)})
        .finally(() => {console.log("Finally finished with the loadStyle promise...")});
    }
}