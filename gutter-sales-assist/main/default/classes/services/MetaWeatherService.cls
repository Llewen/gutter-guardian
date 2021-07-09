public with sharing class MetaWeatherService implements IForecastService {
    private String endpoint = 'https://www.metaweather.com/api/location/';
    private String searchEndpoint = 'https://www.metaweather.com/api/location/search/?query=';

    public MetaWeatherService() {}

    public MetaWeatherService(String endpoint, String searchEndpoint) {
        this.endpoint = endpoint;
        this.searchEndpoint = searchEndpoint;
    }

    public WeatherForecast getWeatherForecastForLocation(String location) {
        Http h = new Http();

        HttpRequest searchRequest = new HttpRequest();
        searchRequest.setEndpoint(searchEndpoint + location);
        HttpResponse searchResponse = h.send(searchRequest);

        if (searchResponse.getStatusCode() != 200 && String.isNotBlank(searchResponse.getBody())) {
            return null;
        }

        Location loc;
        JSONParser locationParser = JSON.createParser(searchResponse.getBody());
        while (locationParser.nextToken() != null) {
            if (locationParser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (locationParser.nextToken() != null) {
                    if (locationParser.getCurrentToken() == JSONToken.START_OBJECT) {
                        loc = (Location) locationParser.readValueAs(Location.class);
                        break;
                    }
                }
            }
        }

        HttpRequest forecastRequest = new HttpRequest();
        forecastRequest.setEndpoint(endpoint + String.valueOf(loc.woeid));
        HttpResponse forecastResponse = h.send(forecastRequest);

        if (forecastResponse.getStatusCode() != 200 && String.isNotBlank(forecastResponse.getBody())) {
            return null;
        }

        WeatherForecast forecast = (WeatherForecast) JSON.deserialize(forecastResponse.getBody(), WeatherForecast.class);

        return forecast;
    }
}
