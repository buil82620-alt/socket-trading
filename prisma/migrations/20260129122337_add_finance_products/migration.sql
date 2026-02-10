-- CreateTable
CREATE TABLE "ieo_products" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'UPCOMING',
    "total_supply" DECIMAL(36,18) NOT NULL,
    "current_raised" DECIMAL(36,18) NOT NULL DEFAULT 0,
    "price_per_token" DECIMAL(36,18) NOT NULL,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ieo_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ieo_investments" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "amount" DECIMAL(36,18) NOT NULL,
    "tokens" DECIMAL(36,18) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ieo_investments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mining_products" (
    "id" SERIAL NOT NULL,
    "hash_rate" TEXT NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USDT',
    "average_daily_return" DECIMAL(36,18) NOT NULL,
    "minimum_purchase" DECIMAL(36,18) NOT NULL,
    "maximum_purchase" DECIMAL(36,18),
    "duration" INTEGER NOT NULL DEFAULT 30,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mining_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mining_investments" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "amount" DECIMAL(36,18) NOT NULL,
    "hash_rate" TEXT NOT NULL,
    "daily_return" DECIMAL(36,18) NOT NULL,
    "total_return" DECIMAL(36,18) NOT NULL DEFAULT 0,
    "start_date" TIMESTAMP(3) NOT NULL,
    "end_date" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'ACTIVE',
    "last_payout_date" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "mining_investments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "ieo_products_status_idx" ON "ieo_products"("status");

-- CreateIndex
CREATE INDEX "ieo_products_start_date_end_date_idx" ON "ieo_products"("start_date", "end_date");

-- CreateIndex
CREATE INDEX "ieo_investments_user_id_created_at_idx" ON "ieo_investments"("user_id", "created_at");

-- CreateIndex
CREATE INDEX "ieo_investments_product_id_idx" ON "ieo_investments"("product_id");

-- CreateIndex
CREATE INDEX "mining_products_status_idx" ON "mining_products"("status");

-- CreateIndex
CREATE INDEX "mining_investments_user_id_status_idx" ON "mining_investments"("user_id", "status");

-- CreateIndex
CREATE INDEX "mining_investments_product_id_idx" ON "mining_investments"("product_id");

-- CreateIndex
CREATE INDEX "mining_investments_status_end_date_idx" ON "mining_investments"("status", "end_date");

-- AddForeignKey
ALTER TABLE "ieo_investments" ADD CONSTRAINT "ieo_investments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ieo_investments" ADD CONSTRAINT "ieo_investments_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "ieo_products"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mining_investments" ADD CONSTRAINT "mining_investments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mining_investments" ADD CONSTRAINT "mining_investments_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "mining_products"("id") ON DELETE CASCADE ON UPDATE CASCADE;
