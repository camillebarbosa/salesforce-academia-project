/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-02-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

public class InternetDetails {

@AuraEnabled(cacheable=true)

public static List<ChipHistoryWrapper> buscarCompras(String numeroCliente){

    String token = abc123;

String url = 'https://projectinternetatual.free.beeceptor.com/'

+ numeroCliente;

Http http = new Http();

HttpRequest request = new HttpRequest();

request.setEndpoint(url);
request.setMethod('GET');
request.setHeader('Authorization', 'Bearer' + token);
request.setTimeout(10000); //10 segundos

try{

HttpResponse response = http.send(request);

if(response.getStatusCode() == 200){

List<ChipHistoryWrapper> result = (List<ChipHistoryWrapper>) JSON.deserialize(response.getBody(), List<ChipHistoryWrapper>.class);

return result;

}

return null;

}catch(Exception e){

System.debug('Erro ao consultar API');

return null;

}

}

}

