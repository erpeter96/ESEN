# ESEN

1. Jelentkezz be APPS account-al az adatbázisra.
2. Csinálj copy-t a következő táblákról, minden tábla neve kezdődjön a neptunkódoddal (pl.: NEPTUN_OE_ORDER_HEADERS_ALL): oe_order_lines_all, oe_order_headers_all, mtl_system_items_b (10 pont)
3. Minden tábla esetében használd ezeket a másolat táblákat.
4. Csinálj egy package-et (legyen pks és pkb file-od is. Az üres package is pontot ér ha befordul). (10 pont)
5. A package tartalmazzon egy privát FUNCTIONT (a function nevének első 5 karaktere tartalmazza a neptunkódod), 
   amely 2 bemenő paraméter alapján (p_in_line_id és p_in_days) 
   Az adott line-hoz tartozó schedule_arrival_date és ay ahhoz hozzáadott days-ből egy dátummal tér vissza.
   pl.:  schedule_arrival_date = 28-OCT-04 és napok = 1 akkor return = 29-OCT-04 (10 pont)
   (bármilyen exception kezelés extra pontot jelent) (5 pont extra) 
6. Tartalmazzon a package egy PROCEDURE-t amely ezeket a paramétereket használja (a procedure nevének első 5 karaktere tartalmazza a neptunkódod):

   PROCEDURE neptun_cut_order_selling_price(p_out_errbuff     OUT VARCHAR2,p_out_retcode     OUT NUMBER,p_in_order_number IN  NUMBER,p_in_days       IN  NUMBER)

   A procedure egy CURSOR-ba szedje össze az adott ORDER_NUMBER-hez tartozó összes line-t és egy ciklusban frissítsük a 4. feladatban megadott function használatával azokat.
   A program futása közben az output-ra írjuk ki a módosított order header_id-ját, valamint minden line esetében az ahhoz tartozó part_numbert (mtl_system_items_b-ben a segment1)
   valamint a hozzá tartozó description-t és eredeti valamint módosított dátumot.
   A log file-ba írjuk be az érintett sorok line_id-ját valamint az eredeti és új dátumot. (10 pont)
   (Exception kezelés extra pontot jelent) (5 pont extra)

7. Fordítsd be a package-et

8. Csináljunk hozzá konkurens programot. (40 pont)

Ponthatárok: 

10-39 : 1
40-49 : 2
50-59 : 3
60-69 : 4
70-   : 5