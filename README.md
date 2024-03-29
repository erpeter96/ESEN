# ESEN

1. Jelentkezz be APPS account-al az adatbázisra.
2. Csinálj copy-t a következő táblákról, minden tábla neve kezdődjön a neptunkódoddal (pl.: NEPTUN_OE_ORDER_HEADERS_ALL): oe_order_lines_all, oe_order_headers_all, mtl_system_items_b
3. Minden tábla esetében használd ezeket a másolat táblákat.
4. Csinálj egy package-et (legyen pks és pkb file-od is).
5. A package tartalmazzon egy privát FUNCTIONT (a function nevének első 5 karaktere tartalmazza a neptunkódod), amely 2 bemenő paraméter alapján (line_id és kedvezmény)
   Az adott line-hoz tartozó unit_selling_price és az arra alkalmazott kedvezmény-ből egy számmal tér vissza.
   A a kedvezményt számként adjuk meg és számoljunk százalékot. pl.:  unit_selling_price = 100 és kedvezmény = 10 akkor return = 90
   (bármilyen exception kezelés extra pontot jelent)
6. Tartalmazzon a package egy PROCEDURE-t amely ezeket a paramétereket használja (a procedure nevének első 5 karaktere tartalmazza a neptunkódod):

   PROCEDURE neptun_cut_order_selling_price(p_out_errbuff     OUT VARCHAR2,p_out_retcode     OUT NUMBER,p_in_order_number IN  NUMBER,p_in_cut_by       IN  NUMBER)

   A procedure egy CURSOR-ba szedje össze az adott ORDER_NUMBER-hez tartozó összes line-t és egy ciklusban frissítsük a 4. feladatban megadott function használatával azokat.
   A program futása közben az output-ra írjuk ki a módosított order header_id-ját, valamint minden line esetében az ahhoz tartozó part_numbert (mtl_system_items_b-ben a segment1)
   valamint a hozzá tartozó description-t és eredeti valamint módosított árat.
   A log file-ba írjuk be az érintett sorok line_id-ját valamint az eredeti és új árat.
   (Exception kezelés extra pontot jelent)
8. Fordítsd be a package-et
9. Csináljunk hozzá konkurens programot.
    ![image](https://github.com/erpeter96/ESEN/assets/127132338/f5b0ba7a-c7ef-4a6b-a01c-2a18e38c143f)
    ![image](https://github.com/erpeter96/ESEN/assets/127132338/c6652173-7611-44f7-b264-420a8d560391)



Segítség a konkurens programhoz:
![image](https://github.com/erpeter96/ESEN/assets/127132338/252920a5-323d-400c-8ccd-350aa1a2e0e3)

![image](https://github.com/erpeter96/ESEN/assets/127132338/e330d8bd-4717-4ab0-8994-6b5382a7edf7)
![2024-03-25_21h14_55](https://github.com/erpeter96/ESEN/assets/127132338/b1f078b8-a3a3-4d78-b97f-71c307438bdd)
![2024-03-25_21h16_01](https://github.com/erpeter96/ESEN/assets/127132338/1effd5d8-eadf-4807-880d-810108bdc22a)
![image](https://github.com/erpeter96/ESEN/assets/127132338/5bb9cfbb-1def-49a8-8acc-adc33b2740b4)
![image](https://github.com/erpeter96/ESEN/assets/127132338/74267669-1d14-4b8b-8a37-b169ac62089a)
