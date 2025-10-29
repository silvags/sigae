/*
  Warnings:

  - You are about to drop the column `localizacao` on the `Escola` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."Escola" DROP COLUMN "localizacao",
ADD COLUMN     "geom" geometry(Point, 4326);
