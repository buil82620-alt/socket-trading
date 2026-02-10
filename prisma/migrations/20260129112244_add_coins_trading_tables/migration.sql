-- CreateTable
CREATE TABLE "wallets" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "asset" TEXT NOT NULL,
    "available" DECIMAL(36,18) NOT NULL,
    "locked" DECIMAL(36,18) NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wallets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "spot_orders" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "symbol" TEXT NOT NULL,
    "side" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "price" DECIMAL(36,18),
    "quantity" DECIMAL(36,18) NOT NULL,
    "filledQuantity" DECIMAL(36,18) NOT NULL DEFAULT 0,
    "status" TEXT NOT NULL DEFAULT 'NEW',
    "fee_asset" TEXT,
    "fee_amount" DECIMAL(36,18) DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "spot_orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "trade_fills" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "symbol" TEXT NOT NULL,
    "price" DECIMAL(36,18) NOT NULL,
    "quantity" DECIMAL(36,18) NOT NULL,
    "fee_asset" TEXT NOT NULL,
    "fee_amount" DECIMAL(36,18) NOT NULL,
    "side" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "trade_fills_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "wallets_user_id_asset_key" ON "wallets"("user_id", "asset");

-- CreateIndex
CREATE INDEX "spot_orders_user_id_status_idx" ON "spot_orders"("user_id", "status");

-- CreateIndex
CREATE INDEX "spot_orders_symbol_status_idx" ON "spot_orders"("symbol", "status");

-- CreateIndex
CREATE INDEX "trade_fills_user_id_created_at_idx" ON "trade_fills"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "trade_fills_order_id_idx" ON "trade_fills"("order_id");

-- CreateIndex
CREATE INDEX "trade_fills_symbol_created_at_idx" ON "trade_fills"("symbol", "created_at");

-- AddForeignKey
ALTER TABLE "wallets" ADD CONSTRAINT "wallets_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "spot_orders" ADD CONSTRAINT "spot_orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trade_fills" ADD CONSTRAINT "trade_fills_order_id_fkey" FOREIGN KEY ("order_id") REFERENCES "spot_orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "trade_fills" ADD CONSTRAINT "trade_fills_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
