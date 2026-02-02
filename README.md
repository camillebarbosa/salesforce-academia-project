# 🏋️‍♀️ Salesforce Academia – Cliente View LWC

Componente **Lightning Web Component (LWC)** que exibe informações detalhadas de um **Cliente**, seus **Planos** e **Pagamentos**, com dados obtidos via **Apex** e apresentados em um design moderno e responsivo.

---

## ✨ Visão Geral

O **ClienteView** é um componente LWC que consome o método Apex `AcademiaService.getClienteById`.  
Ele exibe os dados do cliente em um layout visual agradável e seguro, aplicando **máscaras automáticas** em campos sensíveis (CPF e telefone).

<p align="center">
  <img src="preview.png" width="800" alt="Preview do componente ClienteView LWC"/>
</p>

---

## 🧩 Funcionalidades

- ✅ Busca automática de cliente via **campo lookup (`Cliente__c`)** do registro atual.  
- 🔄 Integração com **Apex (`getClienteById`)** para carregar dados em tempo real.  
- 🔐 **Mascaramento de CPF e telefone** para proteção de dados.  
- 💳 Exibição hierárquica: **Cliente → Planos → Pagamentos**.  
- 🎨 Interface inspirada no **Salesforce Data Stream** (cards limpos e modernos).  
- ⚡ Design leve e responsivo com **SLDS** e **CSS customizado**.

---

## 🏗️ Estrutura do Projeto
force-app/
└── main/
└── default/
├── aura/
├── classes/
│ └── AcademiaService.cls
├── lwc/
│ └── clienteView/
│ ├── clienteView.html
│ ├── clienteView.js
│ ├── clienteView.css
│ └── clienteView.js-meta.xml
├── objects/
│ └── Contrato__c/
│ └── fields/
│ └── Cliente__c.field-meta.xml



---

## ⚙️ Instalação

### 1. Clone o repositório
```bash
git clone https://github.com/seu-usuario/salesforce-academia-project.git
cd salesforce-academia-project

2. Autentique-se na sua org Salesforce

sfdx force:auth:web:login -a MinhaOrg


