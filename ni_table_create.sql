CREATE TABLE NITNG_CUSTOMER
(
  CUSTOMER_ID       NUMBER,
  CUSTOMER_NAME     VARCHAR2(1000 BYTE),
  CREATION_DATE     DATE,
  CREATED_BY        NUMBER,
  LAST_UPDATED_BY   NUMBER,
  LAST_UPDATE_DATE  DATE
);


CREATE TABLE NITNG_ITEMS
(
  INVENTORY_ITEM_ID  NUMBER                     NOT NULL,
  PART_NUMBER        VARCHAR2(4000 BYTE),
  CREATION_DATE      DATE                       NOT NULL,
  CREATED_BY         NUMBER,
  LAST_UPDATED_BY    NUMBER,
  LAST_UPDATE_DATE   DATE,
  DESCRIPTION        VARCHAR2(1000 BYTE)
);

CREATE TABLE NITNG_ORDER_HEADERS
(
  HEADER_ID          NUMBER,
  ORDER_NUMBER       NUMBER,
  ORDER_CUSTOMER_ID  NUMBER,
  CREATION_DATE      DATE,
  CREATED_BY         NUMBER,
  LAST_UPDATED_BY    NUMBER,
  LAST_UPDATE_DATE   DATE
);

CREATE TABLE NITNG_ORDER_LINES
(
  HEADER_ID           NUMBER,
  LINE_ID             NUMBER,
  ORGANIZATION_CODE   VARCHAR2(3 BYTE),
  LINE                VARCHAR2(204 BYTE),
  INVENTORY_ITEM_ID   NUMBER                    NOT NULL,
  QUANTITY            NUMBER,
  CREATION_DATE       DATE,
  CREATED_BY          NUMBER                    NOT NULL,
  LAST_UPDATE_DATE    DATE                      NOT NULL,
  LAST_UPDATED_BY     NUMBER                    NOT NULL,
  STATUS              VARCHAR2(30 BYTE),
  UNIT_SELLING_PRICE  NUMBER,
  SCHEDULE_SHIP_DATE  DATE
);

