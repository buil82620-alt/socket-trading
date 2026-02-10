-- CreateTable
CREATE TABLE "transfers" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "asset" TEXT NOT NULL,
    "amount" DECIMAL(36,18) NOT NULL,
    "from_account" TEXT NOT NULL,
    "to_account" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transfers_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "transfers_user_id_created_at_idx" ON "transfers"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "transfers_asset_created_at_idx" ON "transfers"("asset", "created_at");

-- AddForeignKey
ALTER TABLE "transfers" ADD CONSTRAINT "transfers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
