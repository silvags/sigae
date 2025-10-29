
CREATE EXTENSION IF NOT EXISTS postgis;

-- CreateEnum
CREATE TYPE "public"."Papel" AS ENUM ('ADMIN', 'NEAS', 'DERS', 'DRS', 'ESCOLA', 'DOADOR', 'DIREP', 'SUPIN', 'SUPAD', 'DTR');

-- CreateEnum
CREATE TYPE "public"."TipoDoador" AS ENUM ('PESSOA_FISICA', 'PESSOA_JURIDICA');

-- CreateEnum
CREATE TYPE "public"."TipoAgendamento" AS ENUM ('COLETA_REGULAR', 'COLETA_EXTRA', 'ATIVIDADE_EDUCACIONAL', 'PLANTAO_FERIAS');

-- CreateTable
CREATE TABLE "public"."Setor" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "descricao" TEXT,

    CONSTRAINT "Setor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Usuario" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "matricula" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "cargo" TEXT,
    "setorId" INTEGER,
    "papel" "public"."Papel" NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Escola" (
    "id" SERIAL NOT NULL,
    "numTermo" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "endereco" TEXT,
    "telefone" TEXT,
    "email" TEXT,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "geom" geometry(Point, 4326),

    CONSTRAINT "Escola_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Doador" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "tipo" "public"."TipoDoador" NOT NULL,
    "cpfCnpj" TEXT,
    "endereco" TEXT,
    "telefone" TEXT,
    "email" TEXT,
    "escolaId" INTEGER,

    CONSTRAINT "Doador_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Cooperativa" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "cnpj" TEXT,
    "endereco" TEXT,
    "telefone" TEXT,
    "email" TEXT,
    "ativa" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Cooperativa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Coleta" (
    "id" SERIAL NOT NULL,
    "dataColeta" TIMESTAMP(3) NOT NULL,
    "quantidadeKg" DOUBLE PRECISION NOT NULL,
    "escolaId" INTEGER,
    "doadorId" INTEGER,
    "agendamentoId" INTEGER,
    "cooperativaId" INTEGER,

    CONSTRAINT "Coleta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Agendamento" (
    "id" SERIAL NOT NULL,
    "tipo" "public"."TipoAgendamento" NOT NULL,
    "descricao" TEXT,
    "dataInicio" TIMESTAMP(3) NOT NULL,
    "dataFim" TIMESTAMP(3),
    "diaSemana" TEXT,
    "frequencia" TEXT,
    "escolaId" INTEGER,
    "doadorId" INTEGER,
    "criadoPorId" INTEGER,
    "autorizadoPorId" INTEGER,

    CONSTRAINT "Agendamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Redirecionamento" (
    "id" SERIAL NOT NULL,
    "dataRedirecionamento" TIMESTAMP(3) NOT NULL,
    "motivo" TEXT,
    "origemId" INTEGER NOT NULL,
    "destinoId" INTEGER NOT NULL,

    CONSTRAINT "Redirecionamento_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_matricula_key" ON "public"."Usuario"("matricula");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "public"."Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Escola_numTermo_key" ON "public"."Escola"("numTermo");

-- CreateIndex
CREATE UNIQUE INDEX "Escola_cnpj_key" ON "public"."Escola"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "Doador_cpfCnpj_key" ON "public"."Doador"("cpfCnpj");

-- CreateIndex
CREATE UNIQUE INDEX "Cooperativa_cnpj_key" ON "public"."Cooperativa"("cnpj");

-- AddForeignKey
ALTER TABLE "public"."Usuario" ADD CONSTRAINT "Usuario_setorId_fkey" FOREIGN KEY ("setorId") REFERENCES "public"."Setor"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Doador" ADD CONSTRAINT "Doador_escolaId_fkey" FOREIGN KEY ("escolaId") REFERENCES "public"."Escola"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Coleta" ADD CONSTRAINT "Coleta_escolaId_fkey" FOREIGN KEY ("escolaId") REFERENCES "public"."Escola"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Coleta" ADD CONSTRAINT "Coleta_doadorId_fkey" FOREIGN KEY ("doadorId") REFERENCES "public"."Doador"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Coleta" ADD CONSTRAINT "Coleta_agendamentoId_fkey" FOREIGN KEY ("agendamentoId") REFERENCES "public"."Agendamento"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Coleta" ADD CONSTRAINT "Coleta_cooperativaId_fkey" FOREIGN KEY ("cooperativaId") REFERENCES "public"."Cooperativa"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agendamento" ADD CONSTRAINT "Agendamento_escolaId_fkey" FOREIGN KEY ("escolaId") REFERENCES "public"."Escola"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agendamento" ADD CONSTRAINT "Agendamento_doadorId_fkey" FOREIGN KEY ("doadorId") REFERENCES "public"."Doador"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agendamento" ADD CONSTRAINT "Agendamento_criadoPorId_fkey" FOREIGN KEY ("criadoPorId") REFERENCES "public"."Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Agendamento" ADD CONSTRAINT "Agendamento_autorizadoPorId_fkey" FOREIGN KEY ("autorizadoPorId") REFERENCES "public"."Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Redirecionamento" ADD CONSTRAINT "Redirecionamento_origemId_fkey" FOREIGN KEY ("origemId") REFERENCES "public"."Cooperativa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Redirecionamento" ADD CONSTRAINT "Redirecionamento_destinoId_fkey" FOREIGN KEY ("destinoId") REFERENCES "public"."Cooperativa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
