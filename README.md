# GoNimbly Gutter Guard Sales Assist
GoNimbly interview project using MetaWeather api.

---Project Idea---

What better time to sell gutters than before it rains?
The ForecastController will gather forecast information for a given city and then return a Sales Score based on the percentage of
days that are forecasted to have precipitation.

---How to run---

Navigate to https://cunning-koala-eb819o-dev-ed.lightning.force.com/lightning/n/Gutter_Sales_Assist  
Log in using provided credentials  
Enter City Name in input field and click Calculate to retrieve Sales Score  

Alternatively run the following in an "Execute Anonymous" window for the Developer Console  
ForecastController.getSalesScoreWithForecast('<CITY_NAME>');  

To view the response navigate to the CalloutLogs custom SObject to see what is being returned from the MetaWeather API.  

---Limitations---

Will not log responses if an error is encountered.  

---Future Ideas---

Polish UI to have better styling  
Display Forecast in App  
Allow for Sales Rep to search for Contact/Lead and use their address for Forecast  

