import { LightningElement, wire } from 'lwc';
import getSalesScoreWithForecast from '@salesforce/apex/ForecastController.getSalesScoreWithForecast';
import getLastTenSearches from '@salesforce/apex/ForecastController.getLastTenSearches';

export default class GutterSalesAssist extends LightningElement {
    locationName;
    salesScore;

    @wire (getLastTenSearches) searches;

    getScore() {
        getSalesScoreWithForecast({location: this.locationName})
            .then(result => {
                if (result) {
                    var resObj = JSON.parse(result);
                    this.salesScore = resObj.salesScore;
                } else {
                    console.log('Did not receive a result');
                }
            })
            .catch(error => {
                this.salesScore = 'City not found.';
                console.log("error: ", error);
            })
    }

    handleLocationNameChange(event) {
        this.locationName = event.detail.value;
    }

    handleSearchButtonPress() {
        this.getScore();
    }
}