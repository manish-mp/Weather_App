public class WeatherDetailsClass {
    @AuraEnabled
    public static weatherDetailWrapper getWeatherDetails(String cityName){
   
        String apiKey='Your_API_key';
        String endPoint ='https://api.openweathermap.org/data/2.5/weather';
        endpoint +='?q='+cityName;
        endpoint += '&units=matric';
        endpoint +='&APPID='+apiKey;
        system.debug('endpoint-'+endpoint);
        
        //
        Http http = new http();
        HttpRequest req =new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        system.debug('res'+res+'body'+JSON.deserializeUntyped(res.getBody()));
        
        weatherDetailWrapper weatherDet = new weatherDetailWrapper();
        if(res.getStatusCode()==200){
            Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody()); 
            weatherDet.city = String.valueOf(result.get('name'));
            Map<String,Object> mainResult =(Map<String,Object>)result.get('main');
            weatherDet.temperature = string.valueOf(mainResult.get('temp'));
            weatherDet.pressure = string.valueOf(mainResult.get('pressure'));
            weatherDet.humidity = string.valueOf(mainResult.get('humidity')); 
            weatherDet.feelsLike = string.valueOf(mainResult.get('feels_like'));
            weatherDet.tempMin = string.valueOf(mainResult.get('temp_min'));
            weatherDet.tempMax = string.valueOf(mainResult.get('temp_max'));
            Map<String,Object> cordinates =(Map<String,Object>)result.get('coord');
            weatherDet.latitude = string.valueOf(cordinates.get('lat'));
            weatherDet.longitude = string.valueOf(cordinates.get('lon'));
            
            
        }
        system.debug('weatherDet'+weatherDet);
        return weatherDet;
    }
    
    //wrapper class to share weather detail in serial manner 
    public class weatherDetailWrapper{
        @AuraEnabled public String city {get;Set;}
        @AuraEnabled public String temperature {get;Set;}
        @AuraEnabled public String pressure {get;Set;}
        @AuraEnabled public String humidity {get;Set;}
        @AuraEnabled public String feelsLike {get;Set;}
        @AuraEnabled public String tempMin {get;Set;}
        @AuraEnabled public String tempMax {get;Set;}
        @AuraEnabled public String latitude {get;Set;}
        @AuraEnabled public String longitude {get;Set;}
        
    }
    
}
