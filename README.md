# SIGAE – Sistema Integrado de Gestão do Projeto Adote uma Escola  
**Versão inicial – Documento vivo**

---

## 📌 Objetivo do Projeto

O projeto Adote uma Escola é um projeto que visa a geração de emprego e renda para os atadores das Cooperativas conveniadas com o Serviço Autônomo de Saneamento de Pelotas (SANEP) e trabalhar a separação e descarte ambiental de resíduos com a comunidade escolar - alunos, professores e famílias - nas escolas parceiras do projeto.
O **SIGAE** (Sistema Integrado de Gestão do Projeto Adote uma Escola) é uma plataforma modular destinada ao acompanhamento operacional, ambiental e administrativo das ações realizadas nas escolas e parcerias entre escolas e empresas doadoras de resíduos recicláveis.  
Seu foco principal é:

- Gerenciar coletas de materiais recicláveis em escolas e doadores;  
- Gerenciar agendamentos de atividades ambientais e coletas extras;  
- Registrar repasses financeiros às escolas;  
- Integrar setores institucionais (DIREP, SUPIN, NEAS, DERS, DRS e SUPAD/DTR);  
- Criar relatórios e dashboards para acompanhamento gerencial;  
- Gerenciar cooperativas responsáveis pela destinação dos resíduos coletados.  

---

## 🏗️ Arquitetura do Projeto
- **Backend:** Node.js • TypeScript • NestJS  
- **ORM:** Prisma  
- **Banco de dados:** PostgreSQL + PostGIS  
- **Autenticação:** JWT + RBAC  
- **API:** REST (expansível para GraphQL)  
- **Padrões:** Clean Architecture • Services/Repositories • DTOs

---

## 📦 Tecnologias Principais
- 🚀 **Node.js**
- 🧩 **NestJS**
- 🗄️ **PostgreSQL**
- 🗺️ **PostGIS**
- 🧭 **Prisma ORM**
- 📝 **TypeScript**
  
---

## 🧱 Estrutura de Pastas

```bash
sigae/
├── prisma/                 
│   ├── schema.prisma       
│   └── migrations/         
├── src/
│   ├── common/             
│   ├── config/             
│   ├── modules/            
│   │   ├── auth/           
│   │   ├── users/
│   │   ├── escolas/
│   │   ├── parceiros/
│   │   ├── geolocalizacao/
│   │   └── relatorios/
│   ├── app.module.ts       
│   └── main.ts             
├── tests/                  
├── Dockerfile                  
└── README.md

---

## 📚 Módulos do Sistema

### 🔐 Auth
- JWT Access/Refresh  
- RBAC via Decorators + Guards  
- Controle de sessão

### 👤 Users
- CRUD  
- Perfis e papéis  
- Relacionamento com escolas e parceiros

### 🏫 Escolas
- Cadastro  
- Validação de dados  
- Geometria (POINT) via PostGIS

### 🤝 Parceiros / Adoções
- Cadastro de parceiros  
- Associação escola ↔ parceiro  
- Controle de status

### 📍 Geolocalização
- Filtros espaciais  
- Distâncias  
- Suporte a índices GiST

### 📊 Relatórios
- Dados consolidados  
- Estatísticas  
- Exportações futuras

---

## 🔧 Requisitos
- Node.js 20+  
- PostgreSQL 15+  
- PostGIS 3+  
- Docker (opcional)

---

## ✅ Próximos Passos
- Documentar procedimentos de instalação  
- Criar exemplos de requisições (HTTP e via Prisma)  
- Implementar o sistema módulo a módulo  
- Criar collection para Postman/Insomnia  
- Criar docker-compose opcional  

---

## 📄 Observação
Este README é **provisório** e será ampliado conforme os módulos forem sendo implementados.