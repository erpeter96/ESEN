create or replace PACKAGE ESEN_gyak_pkb
IS
   PROCEDURE order_item_description(p_out_errbuff     OUT VARCHAR2,
                                    p_out_retcode     OUT NUMBER,
                                    p_in_order_number IN NUMBER);
--
END ESEN_gyak_pkb;