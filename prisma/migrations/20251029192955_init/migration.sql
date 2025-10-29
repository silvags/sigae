/*
  Warnings:

  - The values [DTR] on the enum `Papel` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `criadoPorId` on the `Agendamento` table. All the data in the column will be lost.
  - You are about to drop the column `descricao` on the `Agendamento` table. All the data in the column will be lost.
  - You are about to drop the column `doadorId` on the `Agendamento` table. All the data in the column will be lost.
  - The `frequencia` column on the `Agendamento` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the column `cooperativaId` on the `Coleta` table. All the data in the column will be lost.
  - You are about to drop the column `geom` on the `Escola` table. All the data in the column will be lost.
  - You are about to drop the `Redirecionamento` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `tipo` on the `Agendamento` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "public"."FrequenciaColeta" AS ENUM ('SEMANAL', 'QUINZENAL', 'MENSAL', 'EXTRA');

-- CreateEnum
CREATE TYPE "public"."StatusAgendamento" AS ENUM ('PENDENTE', 'CONFIRMADO', 'CANCELADO', 'CONCLUIDO');

-- CreateEnum
CREATE TYPE "public"."SituacaoEscola" AS ENUM ('ATIVA', 'SUSPENSA', 'EXCLUIDA');

-- AlterEnum
BEGIN;
CREATE TYPE "public"."Papel_new" AS ENUM ('ADMIN', 'NEAS', 'DERS', 'DRS', 'ESCOLA', 'DOADOR', 'DIREP', 'SUPIN', 'SUPAD');
ALTER TABLE "public"."Usuario" ALTER COLUMN "papel" TYPE "public"."Papel_new" USING ("papel"::text::"public"."Papel_new");
ALTER TYPE "public"."Papel" RENAME TO "Papel_old";
ALTER TYPE "public"."Papel_new" RENAME TO "Papel";
DROP TYPE "public"."Papel_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "public"."Agendamento" DROP CONSTRAINT "Agendamento_criadoPorId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Agendamento" DROP CONSTRAINT "Agendamento_doadorId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Coleta" DROP CONSTRAINT "Coleta_cooperativaId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Redirecionamento" DROP CONSTRAINT "Redirecionamento_destinoId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Redirecionamento" DROP CONSTRAINT "Redirecionamento_origemId_fkey";

-- AlterTable
ALTER TABLE "public"."Agendamento" DROP COLUMN "criadoPorId",
DROP COLUMN "descricao",
DROP COLUMN "doadorId",
ADD COLUMN     "observacao" TEXT,
ADD COLUMN     "status" "public"."StatusAgendamento" NOT NULL DEFAULT 'PENDENTE',
DROP COLUMN "tipo",
ADD COLUMN     "tipo" TEXT NOT NULL,
ALTER COLUMN "dataInicio" DROP NOT NULL,
DROP COLUMN "frequencia",
ADD COLUMN     "frequencia" "public"."FrequenciaColeta";

-- AlterTable
ALTER TABLE "public"."Coleta" DROP COLUMN "cooperativaId";

-- AlterTable
ALTER TABLE "public"."Escola" DROP COLUMN "geom",
ADD COLUMN     "localizacao" geography(Point, 4326),
ADD COLUMN     "situacao" "public"."SituacaoEscola" NOT NULL DEFAULT 'ATIVA';

-- DropTable
DROP TABLE "public"."Redirecionamento";

-- DropEnum
DROP TYPE "public"."TipoAgendamento";

-- CreateTable
CREATE TABLE "public"."DestinoReciclavel" (
    "id" SERIAL NOT NULL,
    "dataDestino" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "quantidadeKg" DOUBLE PRECISION NOT NULL,
    "cooperativaId" INTEGER NOT NULL,
    "coletaId" INTEGER,
    "observacao" TEXT,

    CONSTRAINT "DestinoReciclavel_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."DestinoReciclavel" ADD CONSTRAINT "DestinoReciclavel_cooperativaId_fkey" FOREIGN KEY ("cooperativaId") REFERENCES "public"."Cooperativa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DestinoReciclavel" ADD CONSTRAINT "DestinoReciclavel_coletaId_fkey" FOREIGN KEY ("coletaId") REFERENCES "public"."Coleta"("id") ON DELETE SET NULL ON UPDATE CASCADE;
