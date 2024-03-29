CREATE OR REPLACE PACKAGE BODY esen_order_updater
IS
   --
   FUNCTION calc_new_price(p_in_line_id IN NUMBER,
                           p_in_perc    IN NUMBER)
   RETURN NUMBER
   IS
      new_price NUMBER;
   BEGIN
      SELECT unit_selling_price 
        INTO new_price
        FROM perdos_oe_order_lines_all
       WHERE line_id = p_in_line_id;
      --
      RETURN new_price - round(new_price * (p_in_perc/100));
      --
      EXCEPTION
      WHEN OTHERS THEN RETURN NULL;
   END;
   --
   PROCEDURE cut_order_selling_price(p_out_errbuff     OUT VARCHAR2,
                                     p_out_retcode     OUT NUMBER,
                                     p_in_order_number IN  NUMBER,
                                     p_in_cut_by       IN  NUMBER)
   IS
      CURSOR c_orders(p_in_order_number NUMBER)
      IS
      SELECT ol.line_id,
             oh.order_number order_number,
             ol.inventory_item_id inv_item_id,
             ol.unit_selling_price,
             itms.segment1 part_number,
             itms.description description
         FROM perdos_oe_order_headers_all oh,
              perdos_oe_order_lines_all ol,
              perdos_mtl_system_items_b itms
       WHERE ol.header_id = oh.header_id
         AND itms.inventory_item_id = ol.inventory_item_id
         AND itms.organization_id =  ol.org_id
         AND oh.order_number = p_in_order_number
         AND ol.flow_status_code NOT IN ('CLOSED', 'CANCELLED');
      --
      header           NUMBER;
      get_sum          NUMBER;
      new_price        NUMBER := NULL;
   BEGIN
      SELECT oh.header_id
        INTO header
        FROM perdos_oe_order_headers_all oh
       WHERE oh.order_number = p_in_order_number;
      --
      fnd_file.put_line(fnd_file.OUTPUT, 'Entered order number is: ' || p_in_order_number);
      fnd_file.put_line(fnd_file.OUTPUT, 'header id: ' || header);
      fnd_file.put_line(fnd_file.OUTPUT, 'The value of the order is: ' || get_sum);
      FOR v_rec IN c_orders(p_in_order_number)
      LOOP
         --
         new_price := calc_new_price(v_rec.line_id, p_in_cut_by);
         --
         IF new_price IS NOT NULL
         THEN
            --UPDATE perdos_oe_order_lines_all pool
            --   SET pool.unit_selling_price = new_price
            -- WHERE pool.line_id = v_rec.line_id;
             --
             COMMIT;
         END IF;
         --
         fnd_file.put_line(fnd_file.OUTPUT, 'Part number: ' || v_rec.part_number || ' Description: ' || v_rec.description || 
                                            ' Old selling price: ' || v_rec.unit_selling_price || ' New selling price: ' || new_price);
         --                                   
         fnd_file.put_line(fnd_file.LOG, 'Part number: ' || v_rec.part_number || ' Old selling price: ' || v_rec.unit_selling_price || ' New selling price: ' || new_price);
         --
         new_price := NULL;
      END LOOP;
      --
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         p_out_retcode := 1;
         p_out_errbuff := 'There is no such order ' || SQLERRM;
         fnd_file.put_line(fnd_file.LOG, 'There is no such order ' || SQLERRM);
      WHEN OTHERS THEN
         p_out_retcode := 2;
         p_out_errbuff := 'There is a problem in the cut_order_selling_price procedure ' || SQLERRM;
         fnd_file.put_line(fnd_file.LOG, SQLERRM);
   END cut_order_selling_price;
END esen_order_updater; 