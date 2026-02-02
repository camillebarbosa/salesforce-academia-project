import { LightningElement, track, api, wire } from 'lwc';
import getClienteById from '@salesforce/apex/AcademiaService.getClienteById';
import { getRecord } from 'lightning/uiRecordApi';

// campo que contém o relacionamento
import CLIENTE_FIELD from '@salesforce/schema/Case.cliente__c';

export default class ClienteView extends LightningElement {
    @track cliente;
    @api recordId;

    // Pega o valor do campo Cliente__c no registro atual
    @wire(getRecord, { recordId: '$recordId', fields: [CLIENTE_FIELD] })
    wiredRecord({ error, data }) {
        if (data) {
            const idCliente = data.fields.Cliente__c.value;
            this.buscarCliente(idCliente);
        } else if (error) {
            console.error('Erro ao carregar campo Cliente__c:', error);
        }
    }

    buscarCliente(idCliente) {
        if (!idCliente) return;
        getClienteById({ idCliente })
            .then(result => {
                if (result) {
                    // Máscara de segurança
                    this.cliente = {
                        ...result,
                        cpf: this.hideCPF(result.cpf),
                        telefone: this.hidePhone(result.telefone)
                    };
                }
            })
            .catch(error => {
                console.error('Erro ao buscar cliente:', error);
            });
    }

    // === Funções utilitárias de máscara ===
    hideCPF(cpf) {
        if (!cpf) return '';
        const d = cpf.replace(/[^\d]/g, '');
        if (d.length !== 11) return cpf;
        return d.replace(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, '***.***.$3-$4');
    }

    hidePhone(phone) {
        if (!phone) return '';
        const d = phone.replace(/[^\d]/g, '');
        if (d.length >= 12) {
            return '+' + d.slice(0,2) + ' (' + d.slice(2,4) + ') 9****-' + d.slice(-4);
        }
        if (d.length === 11) {
            return '(' + d.slice(0,2) + ') 9****-' + d.slice(-4);
        }
        return phone;
    }

    // === Classe de status para estilização ===
    get clientePlanosComClasse() {
        return this.cliente?.planos?.map(plano => ({
            ...plano,
            statusClass:
                plano.status === 'ativo'
                    ? 'status-ativo'
                    : plano.status === 'cancelado'
                    ? 'status-cancelado'
                    : 'status-pendente'
        }));
    }
}
