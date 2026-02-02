Perfeito, Camille 💜 — aqui vai um modelo de **README.md completo**, pronto pra colocar no GitHub do seu projeto **Salesforce Academia (LWC)**.

Ele explica o propósito do componente, tecnologias usadas, estrutura, e como instalar/deployar no Salesforce.
Incluí também uma seção visual (com ideia do design moderno que você está criando).

---

### 🧾 README.md

```markdown
# 🏋️‍♀️ Salesforce Academia – Cliente View LWC

Componente Lightning Web Component (LWC) que exibe informações detalhadas de um **Cliente**, seus **Planos** e **Pagamentos**, com dados obtidos via **Apex** e apresentados em um design moderno e responsivo.


---

## ✨ Visão Geral

O **ClienteView** é um componente desenvolvido em **Lightning Web Components (LWC)** que consome a classe Apex `AcademiaService.getClienteById`.  
Ele permite exibir as informações do cliente em um layout visual agradável e seguro, com mascaramento automático de CPF e telefone.

---

## 🧩 Funcionalidades

- ✅ Busca automática de cliente via **campo lookup (`Cliente__c`)** no registro atual.
- 🔄 Integração com método **Apex (`getClienteById`)** para obter os dados completos.
- 🔐 **Máscara de CPF e telefone** para proteger dados sensíveis.
- 💳 Exibição hierárquica: **Cliente → Planos → Pagamentos**.
- 🎨 Interface inspirada no design do Salesforce Data Stream (cards limpos e coloridos).
- ⚡ Responsivo e leve, utilizando **SLDS** e CSS customizado.

---

## 🏗️ Estrutura do Projeto

```

force-app/
└── main/
└── default/
├── aura/
├── classes/
│   └── AcademiaService.cls
├── lwc/
│   └── clienteView/
│       ├── clienteView.html
│       ├── clienteView.js
│       ├── clienteView.css
│       └── clienteView.js-meta.xml
├── objects/
│   └── Contrato__c/
│       └── fields/
│           └── Cliente__c.field-meta.xml

````

---

## ⚙️ Instalação

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/salesforce-academia-project.git
   cd salesforce-academia-project
````

2. **Autentique-se na sua org Salesforce:**

   ```bash
   sfdx force:auth:web:login -a MinhaOrg
   ```

3. **Push do código para a org:**

   ```bash
   sfdx force:source:push -u MinhaOrg
   ```

4. **Atribua permissões de Apex (se necessário):**

   * Dê acesso à classe `AcademiaService` ao perfil do usuário.

5. **Adicione o componente à página:**

   * Vá até o **App Builder** da página de registro (ex: `Contrato__c`).
   * Arraste o componente **ClienteView** para a seção desejada.
   * Certifique-se de que o campo **`Cliente__c`** está preenchido.

---

## 💡 Exemplo de Uso

Ao abrir um registro que tenha o campo `Cliente__c` preenchido, o LWC faz automaticamente:

```text
1️⃣ Busca o ID do cliente relacionado
2️⃣ Chama o método Apex getClienteById
3️⃣ Exibe as informações mascaradas e formatadas:
   - Nome
   - CPF (***.***.789-00)
   - Telefone (+55 (11) 9****-5678)
   - Planos com status (Ativo, Cancelado, Pendente)
   - Pagamentos por plano
```

---

## 🖌️ Visual

Design baseado no **Salesforce Lightning Design System** + estilo moderno com gradiente azul/roxo:

<img src="https://user-images.githubusercontent.com/000000/000000000-example.png" width="600"/>

---

## 🧠 Tecnologias

* **Salesforce Lightning Web Components (LWC)**
* **Apex (backend)**
* **SLDS (Salesforce Lightning Design System)**
* **JavaScript ES6+**
* **CSS customizado com gradiente**

---

## 🛠️ Classe Apex de Suporte

```apex
public with sharing class AcademiaService {
    @AuraEnabled(cacheable=true)
    public static Cliente__c getClienteById(String idCliente) {
        // Implementação de exemplo
        return [
            SELECT Id, Nome__c, CPF__c, Telefone__c,
                   (SELECT Id, Nome__c, Status__c, Preco__c,
                        (SELECT Id, Status__c, Valor__c FROM Pagamentos__r)
                    FROM Planos__r)
            FROM Cliente__c
            WHERE Id = :idCliente
            LIMIT 1
        ];
    }
}
```

---

## 🧑‍💻 Autora

**Camille Barbosa**
💼 Projeto Salesforce Academia
📧 [camillebarbosa@example.com](mailto:camillebarbosa@example.com)

---

## 🪪 Licença

Este projeto é distribuído sob a licença **MIT**.
Sinta-se livre para usar, modificar e compartilhar — desde que mantenha os créditos.

---
