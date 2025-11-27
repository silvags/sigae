# SIGAE – Sistema Integrado de Gestão do Projeto Adote uma Escola  
**Versão inicial – Documento vivo**

---

## 📌 Objetivo do Projeto

O **SIGAE** (Sistema Integrado de Gestão do Projeto Adote uma Escola) é uma plataforma modular destinada ao acompanhamento operacional, ambiental e administrativo das ações realizadas nas escolas e empresas doadoras parceiras.  
Seu foco principal é:

- Gerenciar coletas de materiais recicláveis em escolas e doadores;  
- Gerenciar agendamentos de atividades ambientais e coletas extras;  
- Registrar repasses financeiros às escolas;  
- Integrar setores institucionais (DIREP, SUPIN, NEAS, DERS, DRS e SUPAD/DTR);  
- Criar relatórios e dashboards para acompanhamento gerencial;  
- Gerenciar cooperativas responsáveis pela destinação dos resíduos coletados.  

---

## 🏗️ Arquitetura Geral

### **Backend**
- **Node.js**
- **TypeScript**
- **Prisma ORM**
- **PostgreSQL** + **PostGIS**
- REST API modular

### **Frontend**
*(A ser definido – previsão: React, Next.js, Vue, Angular ou outro framework moderno)*

### **Infraestrutura**
- Banco de dados PostgreSQL com extensão PostGIS ativada
- Implementação modular para facilitar manutenção e evolução
- Suporte para migrações Prisma

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