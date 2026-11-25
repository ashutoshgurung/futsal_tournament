/*
  Warnings:

  - You are about to drop the column `away_score` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `away_team_id` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `home_score` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `home_team_id` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `penalty_away` on the `matches` table. All the data in the column will be lost.
  - You are about to drop the column `penalty_home` on the `matches` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[tie_sheet_id,match_number]` on the table `matches` will be added. If there are existing duplicate values, this will fail.

*/
DROP VIEW IF EXISTS tournament_standings;
-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_away_team_id_fkey";

-- DropForeignKey
ALTER TABLE "matches" DROP CONSTRAINT "matches_home_team_id_fkey";

-- DropIndex
DROP INDEX "idx_matches_away";

-- DropIndex
DROP INDEX "idx_matches_home";

-- AlterTable
ALTER TABLE "matches" DROP COLUMN "away_score",
DROP COLUMN "away_team_id",
DROP COLUMN "home_score",
DROP COLUMN "home_team_id",
DROP COLUMN "penalty_away",
DROP COLUMN "penalty_home",
ADD COLUMN     "bracket_position" INTEGER,
ADD COLUMN     "loser_next_match_id" UUID,
ADD COLUMN     "loser_next_slot" INTEGER,
ADD COLUMN     "match_number" INTEGER,
ADD COLUMN     "next_match_id" UUID,
ADD COLUMN     "next_match_slot" INTEGER,
ADD COLUMN     "penalty_team1" INTEGER,
ADD COLUMN     "penalty_team2" INTEGER,
ADD COLUMN     "team1_id" UUID,
ADD COLUMN     "team1_score" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "team2_id" UUID,
ADD COLUMN     "team2_score" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "tie_sheet_id" UUID;


-- CreateTable
CREATE TABLE "tie_sheets" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "organization_id" UUID NOT NULL,
    "tournament_id" UUID NOT NULL,
    "name" TEXT NOT NULL DEFAULT 'Main Draw',
    "type" TEXT NOT NULL DEFAULT 'single_elimination',
    "seeding_method" TEXT NOT NULL DEFAULT 'random',
    "bracket_size" INTEGER NOT NULL,
    "total_rounds" INTEGER NOT NULL,
    "third_place_match" BOOLEAN NOT NULL DEFAULT false,
    "is_published" BOOLEAN NOT NULL DEFAULT false,
    "is_locked" BOOLEAN NOT NULL DEFAULT false,
    "generated_at" TIMESTAMPTZ(6),
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tie_sheets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tie_sheet_entries" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "tie_sheet_id" UUID NOT NULL,
    "team_id" UUID NOT NULL,
    "seed" INTEGER,
    "slot" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "tie_sheet_entries_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "idx_tiesheets_org" ON "tie_sheets"("organization_id");

-- CreateIndex
CREATE INDEX "idx_tiesheets_tournament" ON "tie_sheets"("tournament_id");

-- CreateIndex
CREATE UNIQUE INDEX "tie_sheets_tournament_id_name_key" ON "tie_sheets"("tournament_id", "name");

-- CreateIndex
CREATE INDEX "idx_tiesheet_entries_team" ON "tie_sheet_entries"("team_id");

-- CreateIndex
CREATE UNIQUE INDEX "tie_sheet_entries_tie_sheet_id_team_id_key" ON "tie_sheet_entries"("tie_sheet_id", "team_id");

-- CreateIndex
CREATE UNIQUE INDEX "tie_sheet_entries_tie_sheet_id_slot_key" ON "tie_sheet_entries"("tie_sheet_id", "slot");

-- CreateIndex
CREATE INDEX "idx_matches_team1" ON "matches"("team1_id");

-- CreateIndex
CREATE INDEX "idx_matches_team2" ON "matches"("team2_id");

-- CreateIndex
CREATE INDEX "idx_matches_tiesheet_round_pos" ON "matches"("tie_sheet_id", "round", "bracket_position");

-- CreateIndex
CREATE UNIQUE INDEX "matches_tie_sheet_id_match_number_key" ON "matches"("tie_sheet_id", "match_number");

-- AddForeignKey
ALTER TABLE "tie_sheets" ADD CONSTRAINT "tie_sheets_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "organizations"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tie_sheets" ADD CONSTRAINT "tie_sheets_tournament_id_fkey" FOREIGN KEY ("tournament_id") REFERENCES "tournaments"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tie_sheet_entries" ADD CONSTRAINT "tie_sheet_entries_tie_sheet_id_fkey" FOREIGN KEY ("tie_sheet_id") REFERENCES "tie_sheets"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tie_sheet_entries" ADD CONSTRAINT "tie_sheet_entries_team_id_fkey" FOREIGN KEY ("team_id") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_team1_id_fkey" FOREIGN KEY ("team1_id") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_team2_id_fkey" FOREIGN KEY ("team2_id") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_tie_sheet_id_fkey" FOREIGN KEY ("tie_sheet_id") REFERENCES "tie_sheets"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_next_match_id_fkey" FOREIGN KEY ("next_match_id") REFERENCES "matches"("id") ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "matches" ADD CONSTRAINT "matches_loser_next_match_id_fkey" FOREIGN KEY ("loser_next_match_id") REFERENCES "matches"("id") ON DELETE SET NULL ON UPDATE NO ACTION;
