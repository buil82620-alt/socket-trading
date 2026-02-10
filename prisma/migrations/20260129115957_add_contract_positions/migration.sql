-- CreateTable
CREATE TABLE "contract_positions" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "symbol" TEXT NOT NULL,
    "side" TEXT NOT NULL,
    "entry_price" DECIMAL(36,18) NOT NULL,
    "amount" DECIMAL(36,18) NOT NULL,
    "duration" INTEGER NOT NULL,
    "profitability" DECIMAL(36,18) NOT NULL,
    "expected_profit" DECIMAL(36,18) NOT NULL,
    "expected_payout" DECIMAL(36,18) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'OPEN',
    "exit_price" DECIMAL(36,18),
    "actual_profit" DECIMAL(36,18),
    "result" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expires_at" TIMESTAMP(3) NOT NULL,
    "closed_at" TIMESTAMP(3),

    CONSTRAINT "contract_positions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "contract_positions_user_id_status_idx" ON "contract_positions"("user_id", "status");

-- CreateIndex
CREATE INDEX "contract_positions_user_id_created_at_idx" ON "contract_positions"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "contract_positions_status_expires_at_idx" ON "contract_positions"("status", "expires_at");

-- AddForeignKey
ALTER TABLE "contract_positions" ADD CONSTRAINT "contract_positions_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
