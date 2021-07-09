public with sharing class MetaWeatherService implements IForecastService {
    private String endpoint = 'https://www.metaweather.com/api/location/';
    private String searchEndpoint = 'https://www.metaweather.com/api/location/search/?query=';
    @TestVisible private ICalloutLogRepository calloutLogRepository = new CalloutLogRepository();

    public MetaWeatherService() {}

    public MetaWeatherService(String endpoint, String searchEndpoint) {
        this.endpoint = endpoint;
        this.searchEndpoint = searchEndpoint;
    }

    public WeatherForecast getWeatherForecastForLocation(String location) {
        Http h = new Http();

        HttpResponse locationSearchResponse = getLocationResponse(h, location);

        if (locationSearchResponse.getStatusCode() != 200 && String.isNotBlank(locationSearchResponse.getBody())) {
            calloutLogRepository.logResponse(locationSearchResponse);
            return new WeatherForecast();
        }

        Location loc = getLocationFromResponse(locationSearchResponse);
        
        HttpResponse forecastResponse = getForecastResponse(h, loc.woeid);

        calloutLogRepository.logResponses(new List<HttpResponse> {locationSearchResponse, forecastResponse});

        if (forecastResponse.getStatusCode() != 200 && String.isNotBlank(forecastResponse.getBody())) {
            calloutLogRepository.logResponse(forecastResponse);
            return new WeatherForecast();
        }

        WeatherForecast forecast = (WeatherForecast) JSON.deserialize(forecastResponse.getBody(), WeatherForecast.class);

        return forecast;
    }

    private HttpResponse getLocationResponse(Http h, String location) {
        HttpRequest locationSearchRequest = new HttpRequest();
        locationSearchRequest.setMethod('GET');
        locationSearchRequest.setEndpoint(searchEndpoint + EncodingUtil.urlEncode(location, 'UTF-8'));
        return h.send(locationSearchRequest);
    }

    private HttpResponse getForecastResponse(Http h, Integer woeid) {
        HttpRequest forecastRequest = new HttpRequest();
        forecastRequest.setMethod('GET');
        forecastRequest.setEndpoint(endpoint + String.valueOf(woeid) + '/');
        return h.send(forecastRequest);
    }

    private Location getLocationFromResponse(HttpResponse locationResponse) {
        JSONParser locationParser = JSON.createParser(locationResponse.getBody());
        while (locationParser.nextToken() != null) {
            if (locationParser.getCurrentToken() == JSONToken.START_ARRAY) {
                while (locationParser.nextToken() != null) {
                    if (locationParser.getCurrentToken() == JSONToken.START_OBJECT) {
                        return (Location) locationParser.readValueAs(Location.class);
                    }
                }
            }
        }

        return new Location();
    }
}
