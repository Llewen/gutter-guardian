public interface ICalloutLogRepository {
    void logResponse(HttpResponse response);
    void logResponses(List<HttpResponse> responses);
}
