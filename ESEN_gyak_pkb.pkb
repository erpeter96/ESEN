create or replace PACKAGE BODY ESEN_gyak_pkb
IS
-- LOG procedure
   PROCEDURE log(log_msg VARCHAR2, fun_proc VARCHAR2)
   IS
   BEGIN
      INSERT INTO perdos_log_tbl
           VALUES (perdos_log.NEXTVAL,
                   SYSDATE,
                   fun_proc,
                   log_msg);
      COMMIT;
   END;

--Csináljunk egy reporting tool-t ami a bekapott order_number esetében a dbms_output-ra kiírja az
--Order_numbert, header_id-t, az order össz értékét valamint az egyes elemet Part_number-ét (segment1) és Description-ét
--Használjunk legalább 2 függvényt vagy procedure-t és legyen public és private is közte.
   --
   FUNCTION sum_unit_selling_price(p_in_header_id NUMBER)
   RETURN NUMBER
   IS
      sum_price NUMBER;
   BEGIN
      SELECT SUM(unit_selling_price)
      INTO sum_price
      FROM oe_order_lines_all
      WHERE header_id = p_in_header_id;
      --
      RETURN sum_price;
   END;
   --
   PROCEDURE order_item_description(p_out_errbuff     OUT VARCHAR2,
                                    p_out_retcode     OUT NUMBER,
                                    p_in_order_number IN NUMBER)
   IS
      CURSOR c_orders(p_in_order_number NUMBER)
      IS
      SELECT oh.order_number order_number,
             ol.inventory_item_id inv_item_id,
             itms.segment1 part_number,
             itms.description description
         FROM oe_order_headers_all oh,
              oe_order_lines_all ol,
              mtl_system_items_b itms
       WHERE ol.header_id = oh.header_id
         AND itms.inventory_item_id = ol.inventory_item_id
         AND itms.organization_id = ol.org_id
         AND oh.order_number = p_in_order_number;
      --
      header         NUMBER;
      get_sum          NUMBER;
   BEGIN
      SELECT oh.header_id
        INTO header
        FROM perdos_oe_order_headers_all oh
       WHERE oh.order_number = p_in_order_number;
      --
      get_sum := sum_unit_selling_price(header);
      dbms_output.put_line('Entered order number is: ' || p_in_order_number);
      dbms_output.put_line('header id: ' || header);
      dbms_output.put_line('The value of the order is: ' || get_sum);
      FOR v_rec IN c_orders(p_in_order_number)
      LOOP
         dbms_output.put_line('Part number: ' || v_rec.part_number || ' Description: ' || v_rec.description);
         fnd_file.put_line(fnd_file.OUTPUT, 'Part number: ' || v_rec.part_number || ' Description: ' || v_rec.description);
         fnd_file.put_line(fnd_file.LOG, 'Part number: ' || v_rec.part_number);
      END LOOP;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         p_out_retcode := 1;
         p_out_errbuff := 'There is no such order ' || SQLERRM;
         fnd_file.put_line(fnd_file.LOG, 'There is no such order ' || SQLERRM);
         log('There is no such order' || SQLERRM, 'order_item_description');
      WHEN OTHERS THEN
         p_out_retcode := 2;
         p_out_errbuff := 'There is a problem in the order_item_description procedure ' || SQLERRM;
         fnd_file.put_line(fnd_file.LOG, SQLERRM);
   END;
END ESEN_gyak_pkb;