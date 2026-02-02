/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 02-02-2026
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/

public with sharing class InternetDetails {

    @AuraEnabled(cacheable=true)
    public static List<InternetDetailsWrapper> buscarCompras(String numeroCliente) {

        // Token da API
        String token = 'abc123';

        // Endpoint
        String url = 'https://projectinternetatual.free.beeceptor.com/' + numeroCliente;

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        request.setTimeout(10000); // 10 segundos
        request.setHeader('Authorization', 'Bearer ' + token);
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);

            if (response.getStatusCode() == 200 && String.isNotBlank(response.getBody())) {
                return (List<InternetDetailsWrapper>) JSON.deserialize(
                    response.getBody(),
                    List<InternetDetailsWrapper>.class
                );
            }

            // Sempre retorne lista vazia para Aura/LWC
            return new List<InternetDetailsWrapper>();

        } catch (Exception e) {
            System.debug('Erro ao consultar API: ' + e.getMessage());
            throw new AuraHandledException('Erro ao consultar dados de compras.');
        }
    }
}


