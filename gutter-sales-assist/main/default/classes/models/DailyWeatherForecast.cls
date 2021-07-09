public class DailyWeatherForecast {
    Date applicableDate { get; private set; }
    String weatherName { get; private set; }

    public DailyWeatherForecast(Date applicableDate, String weatherName) {
        this.applicableDate = applicableDate;
        this.weatherName = weatherName;
    }
}
