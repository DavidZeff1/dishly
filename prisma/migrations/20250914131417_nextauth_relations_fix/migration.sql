/*
  Warnings:

  - The values [READY_FOR_PICKUP,REJECTED,CANCELLED_BY_CUSTOMER,CANCELLED_BY_CHEF,REFUND_REQUESTED,REFUNDED] on the enum `OrderStatus` will be removed. If these variants are still used in the database, this will fail.
  - The values [PROCESSING,PARTIALLY_REFUNDED,CANCELLED] on the enum `PaymentStatus` will be removed. If these variants are still used in the database, this will fail.
  - The values [MODERATOR] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `commissionRate` on the `ChefProfile` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `ChefProfile` table. All the data in the column will be lost.
  - You are about to drop the column `deletedAt` on the `ChefProfile` table. All the data in the column will be lost.
  - You are about to drop the column `maxOrdersPerDay` on the `ChefProfile` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `ChefProfile` table. All the data in the column will be lost.
  - You are about to drop the column `cancellationReason` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `cancelledAt` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `cancelledBy` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `chefEarnings` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `currency` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryAddressId` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `deliveryInstructions` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `platformFee` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `requestedDeliveryTime` on the `Order` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `OrderItem` table. All the data in the column will be lost.
  - You are about to drop the column `currency` on the `OrderItem` table. All the data in the column will be lost.
  - You are about to drop the column `specialRequests` on the `OrderItem` table. All the data in the column will be lost.
  - You are about to drop the column `totalPrice` on the `OrderItem` table. All the data in the column will be lost.
  - You are about to drop the column `currency` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `failureCode` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `failureReason` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `metadata` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `paymentMethod` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `paymentMethodId` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `refundAmount` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `refundReason` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `refundedAt` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `refundedBy` on the `Payment` table. All the data in the column will be lost.
  - You are about to drop the column `communication` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `deliverySpeed` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `foodQuality` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `isModerated` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `isVisible` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `moderatedAt` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `moderatedBy` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `presentation` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `deletedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Address` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `AppConfig` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Currency` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `DishImage` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Notification` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `dishes` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[providerId]` on the table `Payment` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `address` to the `ChefProfile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `city` to the `ChefProfile` table without a default value. This is not possible if the table is not empty.
  - Made the column `deliveryRadius` on table `ChefProfile` required. This step will fail if there are existing NULL values in that column.
  - Made the column `minOrderAmount` on table `ChefProfile` required. This step will fail if there are existing NULL values in that column.
  - Made the column `avgDeliveryTime` on table `ChefProfile` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `deliveryAddress` to the `Order` table without a default value. This is not possible if the table is not empty.
  - Made the column `deliveryFee` on table `Order` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "public"."OrderStatus_new" AS ENUM ('PENDING', 'ACCEPTED', 'IN_PREPARATION', 'READY_FOR_DELIVERY', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED');
ALTER TABLE "public"."Order" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "public"."Order" ALTER COLUMN "status" TYPE "public"."OrderStatus_new" USING ("status"::text::"public"."OrderStatus_new");
ALTER TYPE "public"."OrderStatus" RENAME TO "OrderStatus_old";
ALTER TYPE "public"."OrderStatus_new" RENAME TO "OrderStatus";
DROP TYPE "public"."OrderStatus_old";
ALTER TABLE "public"."Order" ALTER COLUMN "status" SET DEFAULT 'PENDING';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "public"."PaymentStatus_new" AS ENUM ('PENDING', 'PAID', 'FAILED', 'REFUNDED');
ALTER TABLE "public"."Payment" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "public"."Payment" ALTER COLUMN "status" TYPE "public"."PaymentStatus_new" USING ("status"::text::"public"."PaymentStatus_new");
ALTER TYPE "public"."PaymentStatus" RENAME TO "PaymentStatus_old";
ALTER TYPE "public"."PaymentStatus_new" RENAME TO "PaymentStatus";
DROP TYPE "public"."PaymentStatus_old";
ALTER TABLE "public"."Payment" ALTER COLUMN "status" SET DEFAULT 'PENDING';
COMMIT;

-- AlterEnum
BEGIN;
CREATE TYPE "public"."Role_new" AS ENUM ('CUSTOMER', 'CHEF', 'ADMIN');
ALTER TABLE "public"."User" ALTER COLUMN "role" DROP DEFAULT;
ALTER TABLE "public"."User" ALTER COLUMN "role" TYPE "public"."Role_new" USING ("role"::text::"public"."Role_new");
ALTER TYPE "public"."Role" RENAME TO "Role_old";
ALTER TYPE "public"."Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
ALTER TABLE "public"."User" ALTER COLUMN "role" SET DEFAULT 'CUSTOMER';
COMMIT;

-- DropForeignKey
ALTER TABLE "public"."Address" DROP CONSTRAINT "Address_chefId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Address" DROP CONSTRAINT "Address_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."DishImage" DROP CONSTRAINT "DishImage_dishId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Notification" DROP CONSTRAINT "Notification_orderId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Notification" DROP CONSTRAINT "Notification_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."Order" DROP CONSTRAINT "Order_deliveryAddressId_fkey";

-- DropForeignKey
ALTER TABLE "public"."OrderItem" DROP CONSTRAINT "OrderItem_dishId_fkey";

-- DropForeignKey
ALTER TABLE "public"."dishes" DROP CONSTRAINT "dishes_chefId_fkey";

-- DropIndex
DROP INDEX "public"."ChefProfile_deletedAt_idx";

-- DropIndex
DROP INDEX "public"."ChefProfile_deliveryRadius_idx";

-- DropIndex
DROP INDEX "public"."Payment_provider_idx";

-- DropIndex
DROP INDEX "public"."Review_customerId_idx";

-- DropIndex
DROP INDEX "public"."Review_isVisible_idx";

-- DropIndex
DROP INDEX "public"."User_deletedAt_idx";

-- DropIndex
DROP INDEX "public"."User_isActive_idx";

-- AlterTable
ALTER TABLE "public"."ChefProfile" DROP COLUMN "commissionRate",
DROP COLUMN "createdBy",
DROP COLUMN "deletedAt",
DROP COLUMN "maxOrdersPerDay",
DROP COLUMN "updatedBy",
ADD COLUMN     "address" TEXT NOT NULL,
ADD COLUMN     "city" TEXT NOT NULL,
ADD COLUMN     "country" TEXT NOT NULL DEFAULT 'US',
ADD COLUMN     "latitude" DECIMAL(10,8),
ADD COLUMN     "longitude" DECIMAL(11,8),
ADD COLUMN     "state" TEXT,
ALTER COLUMN "deliveryRadius" SET NOT NULL,
ALTER COLUMN "deliveryRadius" SET DEFAULT 10.0,
ALTER COLUMN "minOrderAmount" SET NOT NULL,
ALTER COLUMN "minOrderAmount" SET DEFAULT 15.0,
ALTER COLUMN "avgDeliveryTime" SET NOT NULL,
ALTER COLUMN "avgDeliveryTime" SET DEFAULT 45;

-- AlterTable
ALTER TABLE "public"."Order" DROP COLUMN "cancellationReason",
DROP COLUMN "cancelledAt",
DROP COLUMN "cancelledBy",
DROP COLUMN "chefEarnings",
DROP COLUMN "currency",
DROP COLUMN "deliveryAddressId",
DROP COLUMN "deliveryInstructions",
DROP COLUMN "platformFee",
DROP COLUMN "requestedDeliveryTime",
ADD COLUMN     "deliveryAddress" TEXT NOT NULL,
ALTER COLUMN "deliveryFee" SET NOT NULL,
ALTER COLUMN "deliveryFee" SET DEFAULT 5.0;

-- AlterTable
ALTER TABLE "public"."OrderItem" DROP COLUMN "createdAt",
DROP COLUMN "currency",
DROP COLUMN "specialRequests",
DROP COLUMN "totalPrice";

-- AlterTable
ALTER TABLE "public"."Payment" DROP COLUMN "currency",
DROP COLUMN "failureCode",
DROP COLUMN "failureReason",
DROP COLUMN "metadata",
DROP COLUMN "paymentMethod",
DROP COLUMN "paymentMethodId",
DROP COLUMN "refundAmount",
DROP COLUMN "refundReason",
DROP COLUMN "refundedAt",
DROP COLUMN "refundedBy";

-- AlterTable
ALTER TABLE "public"."Review" DROP COLUMN "communication",
DROP COLUMN "deliverySpeed",
DROP COLUMN "foodQuality",
DROP COLUMN "isModerated",
DROP COLUMN "isVisible",
DROP COLUMN "moderatedAt",
DROP COLUMN "moderatedBy",
DROP COLUMN "presentation",
DROP COLUMN "updatedAt";

-- AlterTable
ALTER TABLE "public"."User" DROP COLUMN "createdBy",
DROP COLUMN "deletedAt",
DROP COLUMN "updatedBy";

-- DropTable
DROP TABLE "public"."Address";

-- DropTable
DROP TABLE "public"."AppConfig";

-- DropTable
DROP TABLE "public"."Currency";

-- DropTable
DROP TABLE "public"."DishImage";

-- DropTable
DROP TABLE "public"."Notification";

-- DropTable
DROP TABLE "public"."dishes";

-- DropEnum
DROP TYPE "public"."AddressType";

-- DropEnum
DROP TYPE "public"."NotificationType";

-- CreateTable
CREATE TABLE "public"."Dish" (
    "id" TEXT NOT NULL,
    "chefId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "images" TEXT[],
    "isAvailable" BOOLEAN NOT NULL DEFAULT true,
    "tags" TEXT[],
    "category" TEXT,
    "preparationTime" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Dish_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."VerificationToken" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateIndex
CREATE INDEX "Dish_chefId_idx" ON "public"."Dish"("chefId");

-- CreateIndex
CREATE INDEX "Dish_isAvailable_idx" ON "public"."Dish"("isAvailable");

-- CreateIndex
CREATE INDEX "Dish_category_idx" ON "public"."Dish"("category");

-- CreateIndex
CREATE UNIQUE INDEX "Account_provider_providerAccountId_key" ON "public"."Account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionToken_key" ON "public"."Session"("sessionToken");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_token_key" ON "public"."VerificationToken"("token");

-- CreateIndex
CREATE UNIQUE INDEX "VerificationToken_identifier_token_key" ON "public"."VerificationToken"("identifier", "token");

-- CreateIndex
CREATE INDEX "ChefProfile_city_state_idx" ON "public"."ChefProfile"("city", "state");

-- CreateIndex
CREATE INDEX "ChefProfile_latitude_longitude_idx" ON "public"."ChefProfile"("latitude", "longitude");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_providerId_key" ON "public"."Payment"("providerId");

-- AddForeignKey
ALTER TABLE "public"."Dish" ADD CONSTRAINT "Dish_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES "public"."ChefProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrderItem" ADD CONSTRAINT "OrderItem_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "public"."Dish"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Account" ADD CONSTRAINT "Account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
