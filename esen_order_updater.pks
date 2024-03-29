CREATE OR REPLACE PACKAGE esen_order_updater
IS
   PROCEDURE cut_order_selling_price(p_out_errbuff     OUT VARCHAR2,
                                     p_out_retcode     OUT NUMBER,
                                     p_in_order_number IN  NUMBER,
                                     p_in_cut_by       IN  NUMBER);
   --
END esen_order_updater;