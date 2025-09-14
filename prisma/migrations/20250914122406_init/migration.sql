-- CreateEnum
CREATE TYPE "public"."Role" AS ENUM ('CUSTOMER', 'CHEF', 'ADMIN', 'MODERATOR');

-- CreateEnum
CREATE TYPE "public"."OrderStatus" AS ENUM ('PENDING', 'ACCEPTED', 'IN_PREPARATION', 'READY_FOR_PICKUP', 'READY_FOR_DELIVERY', 'OUT_FOR_DELIVERY', 'DELIVERED', 'REJECTED', 'CANCELLED_BY_CUSTOMER', 'CANCELLED_BY_CHEF', 'REFUND_REQUESTED', 'REFUNDED');

-- CreateEnum
CREATE TYPE "public"."PaymentStatus" AS ENUM ('PENDING', 'PROCESSING', 'PAID', 'FAILED', 'REFUNDED', 'PARTIALLY_REFUNDED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "public"."AddressType" AS ENUM ('HOME', 'WORK', 'RESTAURANT', 'OTHER');

-- CreateEnum
CREATE TYPE "public"."NotificationType" AS ENUM ('ORDER_PLACED', 'ORDER_ACCEPTED', 'ORDER_REJECTED', 'ORDER_IN_PREPARATION', 'ORDER_READY', 'ORDER_OUT_FOR_DELIVERY', 'ORDER_DELIVERED', 'ORDER_CANCELLED', 'PAYMENT_SUCCESS', 'PAYMENT_FAILED', 'REVIEW_RECEIVED', 'CHEF_APPLICATION_STATUS', 'SYSTEM_ANNOUNCEMENT', 'PROMOTIONAL');

-- CreateTable
CREATE TABLE "public"."User" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "public"."Role" NOT NULL DEFAULT 'CUSTOMER',
    "phone" TEXT,
    "profilePic" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "deletedAt" TIMESTAMP(3),
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."ChefProfile" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "bio" TEXT,
    "cuisineTags" TEXT[],
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "deliveryRadius" DECIMAL(5,2),
    "minOrderAmount" DECIMAL(10,2),
    "avgDeliveryTime" INTEGER,
    "maxOrdersPerDay" INTEGER,
    "commissionRate" DECIMAL(5,4) NOT NULL DEFAULT 0.15,
    "deletedAt" TIMESTAMP(3),
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ChefProfile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Address" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "chefId" TEXT,
    "type" "public"."AddressType" NOT NULL DEFAULT 'OTHER',
    "label" TEXT,
    "addressLine1" TEXT NOT NULL,
    "addressLine2" TEXT,
    "city" TEXT NOT NULL,
    "state" TEXT,
    "country" TEXT NOT NULL DEFAULT 'US',
    "postalCode" TEXT NOT NULL,
    "latitude" DECIMAL(10,8),
    "longitude" DECIMAL(11,8),
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "instructions" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."dishes" (
    "id" TEXT NOT NULL,
    "chefId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "price" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "isAvailable" BOOLEAN NOT NULL DEFAULT true,
    "tags" TEXT[],
    "preparationTime" INTEGER,
    "servingSize" TEXT,
    "allergens" TEXT[],
    "nutritionInfo" JSONB,
    "spiceLevel" SMALLINT,
    "slug" TEXT,
    "category" TEXT,
    "deletedAt" TIMESTAMP(3),
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "dishes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."DishImage" (
    "id" TEXT NOT NULL,
    "dishId" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "isCover" BOOLEAN NOT NULL DEFAULT false,
    "altText" TEXT,
    "width" INTEGER,
    "height" INTEGER,
    "fileSize" INTEGER,
    "format" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DishImage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Order" (
    "id" TEXT NOT NULL,
    "orderNumber" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "chefId" TEXT NOT NULL,
    "status" "public"."OrderStatus" NOT NULL DEFAULT 'PENDING',
    "totalPrice" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "notes" TEXT,
    "deliveryAddressId" TEXT,
    "deliveryInstructions" TEXT,
    "deliveryFee" DECIMAL(10,2),
    "requestedDeliveryTime" TIMESTAMP(3),
    "estimatedDeliveryTime" TIMESTAMP(3),
    "actualDeliveryTime" TIMESTAMP(3),
    "cancelledAt" TIMESTAMP(3),
    "cancellationReason" TEXT,
    "cancelledBy" TEXT,
    "platformFee" DECIMAL(10,2),
    "chefEarnings" DECIMAL(10,2),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Order_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OrderItem" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "dishId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unitPrice" DECIMAL(10,2) NOT NULL,
    "totalPrice" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "dishTitle" TEXT NOT NULL,
    "dishDescription" TEXT,
    "specialRequests" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "OrderItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Review" (
    "id" TEXT NOT NULL,
    "rating" SMALLINT NOT NULL,
    "comment" TEXT,
    "customerId" TEXT NOT NULL,
    "chefId" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "foodQuality" SMALLINT,
    "deliverySpeed" SMALLINT,
    "presentation" SMALLINT,
    "communication" SMALLINT,
    "isModerated" BOOLEAN NOT NULL DEFAULT false,
    "isVisible" BOOLEAN NOT NULL DEFAULT true,
    "moderatedBy" TEXT,
    "moderatedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Review_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Payment" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerId" TEXT NOT NULL,
    "amount" DECIMAL(10,2) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" "public"."PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "paymentMethod" TEXT,
    "paymentMethodId" TEXT,
    "failureReason" TEXT,
    "failureCode" TEXT,
    "refundAmount" DECIMAL(10,2),
    "refundReason" TEXT,
    "refundedAt" TIMESTAMP(3),
    "refundedBy" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Payment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Notification" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "orderId" TEXT,
    "type" "public"."NotificationType" NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "data" JSONB,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "readAt" TIMESTAMP(3),
    "isSent" BOOLEAN NOT NULL DEFAULT false,
    "sentAt" TIMESTAMP(3),
    "deliveryMethod" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."AppConfig" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "description" TEXT,
    "dataType" TEXT NOT NULL DEFAULT 'string',
    "updatedBy" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AppConfig_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Currency" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "symbol" TEXT NOT NULL,
    "exchangeRate" DECIMAL(10,6) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Currency_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "public"."User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "public"."User"("phone");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "public"."User"("email");

-- CreateIndex
CREATE INDEX "User_phone_idx" ON "public"."User"("phone");

-- CreateIndex
CREATE INDEX "User_isActive_idx" ON "public"."User"("isActive");

-- CreateIndex
CREATE INDEX "User_deletedAt_idx" ON "public"."User"("deletedAt");

-- CreateIndex
CREATE UNIQUE INDEX "ChefProfile_userId_key" ON "public"."ChefProfile"("userId");

-- CreateIndex
CREATE INDEX "ChefProfile_isActive_isVerified_idx" ON "public"."ChefProfile"("isActive", "isVerified");

-- CreateIndex
CREATE INDEX "ChefProfile_deliveryRadius_idx" ON "public"."ChefProfile"("deliveryRadius");

-- CreateIndex
CREATE INDEX "ChefProfile_deletedAt_idx" ON "public"."ChefProfile"("deletedAt");

-- CreateIndex
CREATE INDEX "Address_userId_idx" ON "public"."Address"("userId");

-- CreateIndex
CREATE INDEX "Address_chefId_idx" ON "public"."Address"("chefId");

-- CreateIndex
CREATE INDEX "Address_city_state_country_idx" ON "public"."Address"("city", "state", "country");

-- CreateIndex
CREATE INDEX "Address_latitude_longitude_idx" ON "public"."Address"("latitude", "longitude");

-- CreateIndex
CREATE UNIQUE INDEX "dishes_slug_key" ON "public"."dishes"("slug");

-- CreateIndex
CREATE INDEX "dishes_chefId_idx" ON "public"."dishes"("chefId");

-- CreateIndex
CREATE INDEX "dishes_isAvailable_idx" ON "public"."dishes"("isAvailable");

-- CreateIndex
CREATE INDEX "dishes_category_idx" ON "public"."dishes"("category");

-- CreateIndex
CREATE INDEX "dishes_currency_idx" ON "public"."dishes"("currency");

-- CreateIndex
CREATE INDEX "dishes_deletedAt_idx" ON "public"."dishes"("deletedAt");

-- CreateIndex
CREATE INDEX "DishImage_dishId_idx" ON "public"."DishImage"("dishId");

-- CreateIndex
CREATE UNIQUE INDEX "Order_orderNumber_key" ON "public"."Order"("orderNumber");

-- CreateIndex
CREATE INDEX "Order_customerId_idx" ON "public"."Order"("customerId");

-- CreateIndex
CREATE INDEX "Order_chefId_idx" ON "public"."Order"("chefId");

-- CreateIndex
CREATE INDEX "Order_status_idx" ON "public"."Order"("status");

-- CreateIndex
CREATE INDEX "Order_createdAt_idx" ON "public"."Order"("createdAt");

-- CreateIndex
CREATE INDEX "Order_orderNumber_idx" ON "public"."Order"("orderNumber");

-- CreateIndex
CREATE INDEX "OrderItem_orderId_idx" ON "public"."OrderItem"("orderId");

-- CreateIndex
CREATE UNIQUE INDEX "Review_orderId_key" ON "public"."Review"("orderId");

-- CreateIndex
CREATE INDEX "Review_chefId_idx" ON "public"."Review"("chefId");

-- CreateIndex
CREATE INDEX "Review_customerId_idx" ON "public"."Review"("customerId");

-- CreateIndex
CREATE INDEX "Review_rating_idx" ON "public"."Review"("rating");

-- CreateIndex
CREATE INDEX "Review_isVisible_idx" ON "public"."Review"("isVisible");

-- CreateIndex
CREATE UNIQUE INDEX "Review_customerId_orderId_key" ON "public"."Review"("customerId", "orderId");

-- CreateIndex
CREATE UNIQUE INDEX "Payment_orderId_key" ON "public"."Payment"("orderId");

-- CreateIndex
CREATE INDEX "Payment_userId_idx" ON "public"."Payment"("userId");

-- CreateIndex
CREATE INDEX "Payment_status_idx" ON "public"."Payment"("status");

-- CreateIndex
CREATE INDEX "Payment_providerId_idx" ON "public"."Payment"("providerId");

-- CreateIndex
CREATE INDEX "Payment_provider_idx" ON "public"."Payment"("provider");

-- CreateIndex
CREATE INDEX "Notification_userId_isRead_idx" ON "public"."Notification"("userId", "isRead");

-- CreateIndex
CREATE INDEX "Notification_type_idx" ON "public"."Notification"("type");

-- CreateIndex
CREATE INDEX "Notification_createdAt_idx" ON "public"."Notification"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "AppConfig_key_key" ON "public"."AppConfig"("key");

-- CreateIndex
CREATE INDEX "AppConfig_key_idx" ON "public"."AppConfig"("key");

-- CreateIndex
CREATE UNIQUE INDEX "Currency_code_key" ON "public"."Currency"("code");

-- AddForeignKey
ALTER TABLE "public"."ChefProfile" ADD CONSTRAINT "ChefProfile_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Address" ADD CONSTRAINT "Address_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES "public"."ChefProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."dishes" ADD CONSTRAINT "dishes_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES "public"."ChefProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."DishImage" ADD CONSTRAINT "DishImage_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "public"."dishes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Order" ADD CONSTRAINT "Order_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Order" ADD CONSTRAINT "Order_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES "public"."ChefProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Order" ADD CONSTRAINT "Order_deliveryAddressId_fkey" FOREIGN KEY ("deliveryAddressId") REFERENCES "public"."Address"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrderItem" ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrderItem" ADD CONSTRAINT "OrderItem_dishId_fkey" FOREIGN KEY ("dishId") REFERENCES "public"."dishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Review" ADD CONSTRAINT "Review_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Review" ADD CONSTRAINT "Review_chefId_fkey" FOREIGN KEY ("chefId") REFERENCES "public"."ChefProfile"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Review" ADD CONSTRAINT "Review_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Payment" ADD CONSTRAINT "Payment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Payment" ADD CONSTRAINT "Payment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."Order"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Notification" ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Notification" ADD CONSTRAINT "Notification_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "public"."Order"("id") ON DELETE CASCADE ON UPDATE CASCADE;
