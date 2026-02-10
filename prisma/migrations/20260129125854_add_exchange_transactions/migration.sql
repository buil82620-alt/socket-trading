-- CreateTable
CREATE TABLE "exchange_transactions" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "from_asset" TEXT NOT NULL,
    "to_asset" TEXT NOT NULL,
    "from_amount" DECIMAL(36,18) NOT NULL,
    "to_amount" DECIMAL(36,18) NOT NULL,
    "rate" DECIMAL(36,18) NOT NULL,
    "fee_asset" TEXT NOT NULL,
    "fee_amount" DECIMAL(36,18) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "exchange_transactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "exchange_transactions_user_id_created_at_idx" ON "exchange_transactions"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "exchange_transactions_from_asset_to_asset_created_at_idx" ON "exchange_transactions"("from_asset", "to_asset", "created_at");

-- AddForeignKey
ALTER TABLE "exchange_transactions" ADD CONSTRAINT "exchange_transactions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
