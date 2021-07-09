public with sharing class SalesScoringService {
    private List<String> precipitationStateAbbreviations = new List<String> {
        'sn',
        'sl',
        'h',
        't',
        'hr',
        'lr',
        's'
    };

    public SalesScoringService() {}

    public SalesScoringService(List<String> precipitationStateAbbreviations) {
        this.precipitationStateAbbreviations = precipitationStateAbbreviations;
    }

    public Integer getSalesScoreFromForecast(WeatherForecast forecast) {
        Decimal numberOfDaysWithPrecipitation = 0.0;
        for (DailyWeatherForecast dailyForecast : forecast.consolidated_weather) {
            if (precipitationStateAbbreviations.contains(dailyForecast.weather_state_abbr)) {
                numberOfDaysWithPrecipitation++;
            }
        }

        Integer forecastedPrecipitationPercentage = ((numberOfDaysWithPrecipitation / forecast.consolidated_weather.size()) * 100).intValue();
        if (forecastedPrecipitationPercentage < 10) {
            forecastedPrecipitationPercentage = 10;
        }

        return forecastedPrecipitationPercentage;
    }
}
