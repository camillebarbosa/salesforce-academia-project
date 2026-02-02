/**
 * @description       : Serviço para buscar clientes da Academia via API externa
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @last modified on  : 02-02-2026
**/
public with sharing class AcademiaService {

    private static final String BASE_URL = 'https://projectacademia.free.beeceptor.com/';

    /**
     * Busca cliente pelo ID usando callout GET
     * @param idCliente Id do cliente (ex: CLI-98765)
     * @return Cliente parseado do JSON
     */
    @AuraEnabled
    public static Cliente getClienteById(String idCliente) {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(BASE_URL + idCliente);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer abc123');
        req.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse res = http.send(req);
            System.debug('StatusCode: ' + res.getStatusCode());
            System.debug('Body recebido: ' + res.getBody());

            if (res.getStatusCode() == 200) {
                // Desserializa o JSON para ApiResponse
                ApiResponse wrapper = (ApiResponse) JSON.deserialize(res.getBody(), ApiResponse.class);

                // Retorna o cliente, mesmo que planos ou pagamentos sejam nulos
                if (wrapper != null && wrapper.cliente != null) {
                    if (wrapper.cliente.planos == null) {
                        wrapper.cliente.planos = new List<Plano>();
                    } else {
                        // Garante que cada plano tenha lista de pagamentos
                        for (Plano p : wrapper.cliente.planos) {
                            if (p.pagamentos == null) {
                                p.pagamentos = new List<Pagamento>();
                            }
                        }
                    }
                    return wrapper.cliente;
                } else {
                    return new Cliente(); // retorna cliente vazio para evitar erros no LWC
                }
            } else {
                throw new AuraHandledException(
                    'Erro ao chamar API. Status: ' + res.getStatusCode() +
                    ' Body: ' + res.getBody()
                );
            }
        } catch (Exception e) {
            throw new AuraHandledException('Erro no callout: ' + e.getMessage());
        }
    }

    // ======================
    // Wrapper para API
    // ======================
    public class ApiResponse {
        public String status;
        public String mensagem;
        public CriterioBusca criterioBusca;
        public Cliente cliente;
        public Metadata metadata;
    }

    public class CriterioBusca { 
        public String tipo; 
        public String valor; 
    }

    public class Metadata { 
        public String dataConsulta; 
        public String versaoApi; 
    }

    // ======================
    // Modelagem do cliente
    // ======================
    public with sharing class Cliente {
    @AuraEnabled public String idCliente;
    @AuraEnabled public String nome;
    @AuraEnabled public String cpf;
    @AuraEnabled public String telefone;
    @AuraEnabled public String email;
    @AuraEnabled public String dataNascimento;
    @AuraEnabled public String sexo;
    @AuraEnabled public List<Academia> academias;
    @AuraEnabled public List<Frequencia> frequencias;
    @AuraEnabled public List<Plano> planos;
}
    public class Academia {
         @AuraEnabled public String idAcademia;
    }
    public class Frequencia {
         @AuraEnabled public String totalCheckinsMes;
    }

public class Plano {
    @AuraEnabled public String idPlano;
    @AuraEnabled public String nomePlano;
    @AuraEnabled public String descricao;
    @AuraEnabled public Decimal preco;
    @AuraEnabled public String periodicidade;
    @AuraEnabled public String dataInicio;
    @AuraEnabled public String dataFim;
    @AuraEnabled public String status;
    @AuraEnabled public List<Pagamento> pagamentos;
}
    

public class Pagamento {
    @AuraEnabled public String idPagamento;
    @AuraEnabled public String dataVencimento;
    @AuraEnabled public Decimal valor;
    @AuraEnabled public String formaPagamento;
    @AuraEnabled public String status;
}

}
    

