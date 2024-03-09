%let pgm=utl-passing-r-python-and-sas-macro-vars-to-sqllite-interface-arguments;

Passing r python and sas macro vars to sqllite interface arguments;

github
https://tinyurl.com/bdze69hk
https://github.com/rogerjdeangelis/utl-passing-r-python-and-sas-macro-vars-to-sqllite-interface-arguments

SOLUTIONS

  R

   1. sas pass macro vars
   2. r sas escape code
   3. r option resolve=y
   4. r functional
   5. r string query

  PYTHON

   1. python functional
   2. python sas macro vars
   3. python string query


related repos
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-using-wps-python-f-text-function
https://github.com/rogerjdeangelis/utl-passing-arguments-to-sqldf-wps-r-sql-functional-sql

macros
https://tinyurl.com/y9nfugth
https://github.com/rogerjdeangelis/utl-macros-used-in-many-of-rogerjdeangelis-repositories


I FIXED AN ERROR IN THE UTL_SUBMIT_R64X MACRO

Changed cmd to pgm

if index(pgm,"`") then cdm=tranwrd(pgm,"`","27"x);
fixed                  ===
if index(pgm,"`") then pgm=tranwrd(pgm,"`","27"x);

This only effects output when you set use
the argument resolve=Y

use utl_submit_r64x macro at

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
 ____
|  _ \
| |_) |
|  _ <
|_| \_\

*/

/**************************************************************************************************************************/
/*                                           |                                     |                                      */
/*                                           |                                     |                                      */
/*            INPUT                          |          PROCESS                    |     OUPUT                            */
/*            =====                          |          =======                    |     =====                            */
/*                                           |                                     |                                      */
/*  options validvarname=upcase;             | 1 SAS CODE                          |                                      */
/*  libname sd1 "d:/sd1";                    | ==========                          |                                      */
/*  data sd1.iris;                           |                                     |                                      */
/*    set sashelp.iris(where=                | %let specieVar = SPECIES;           | SPECIES    SEPALLENGTH               */
/*      (uniform(1234)< 15/150));            | %let specieVal = "Setosa";          |                                      */
/*    keep species sepallength;              |                                     | Setosa          51                   */
/*  run;quit;                                | %let sepalVar  = SEPALLENGTH;       | Setosa          52                   */
/*                                           | %let sepalVal  = 50;                | Setosa          54                   */
/*                                           |                                     |                                      */
/*  %let specieVar = SPECIES;                | proc sql;                           |                                      */
/*  %let specieVal = "Setosa";               |   create                            |                                      */
/*                                           |     table want as                   |                                      */
/*  %let sepalVar  = SEPALLENGTH;            |   select                            |                                      */
/*  %let sepalVal  = 50;                     |     *                               |                                      */
/*                                           |   from                              |                                      */
/*  SEPALLENGTH > 50 and  SPECIES = "Setosa" |     sd1.iris                        |                                      */
/*                                           |   where                             |                                      */
/*  Obs    SPECIES       SEPALLENGTH         |        &sepalVar   > &sepalVal      |                                      */
/*                                           |     and &specieVar = &specieVal     |                                      */
/*    1    Setosa             46             | ;quit;                              |                                      */
/*    2    Setosa             51 Select      |----------------------------------------------------------------------------*/
/*    3    Setosa             48             |                                     |                                      */
/*    4    Setosa             52 Select      | 2 R SAS ESCAPE CODE                 |                                      */
/*    5    Setosa             44             | ===================                 |                                      */
/*    6    Setosa             48             |                                     |                                      */
/*    7    Setosa             54 Select      | %let specieVar = SPECIES;           | ROWNAMES    SPECIES    SEPALLENGTH   */
/*    8    Versicolor         54             | %let specieVal = Setosa;            |                                      */
/*    9    Versicolor         56             |                                     |     1       Setosa          51       */
/*   10    Versicolor         63             | %let sepalVar  = SEPALLENGTH;       |     2       Setosa          52       */
/*   11    Versicolor         61             | %let sepalVal  = 50;                |     3       Setosa          54       */
/*   12    Versicolor         55             |                                     |                                      */
/*   13    Virginica          64             | %utl_submit_r64x("                  |                                      */
/*   14    Virginica          61             |  library(sqldf);                    |                                      */
/*   15    Virginica          77             |  library(haven);                    |                                      */
/*   16    Virginica          65             |  iris<-read_sas                     |                                      */
/*   17    Virginica          57             |    ('d:/sd1/iris.sas7bdat');        |                                      */
/*   18    Virginica          58             |  iris;                              |                                      */
/*                                           |  want<-sqldf('                      |                                      */
/*                                           |     select                          |                                      */
/*                                           |        *                            |                                      */
/*                                           |     from                            |                                      */
/*                                           |        iris                         |                                      */
/*                                           |     where                           |                                      */
/*                                           |           &sepalVar > &sepalVal     |                                      */
/*                                           |      and &specieVar = \'&specieVal\'|                                      */
/*                                           |  ');                                |                                      */
/*                                           |  want;                              |                                      */
/*                                           |  source('c:/temp/fn_tosas9.R');     |                                      */
/*                                           |  fn_tosas9(dataf=want);             |                                      */
/*                                           |  ");                                |                                      */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                           |                                     |                                      */
/*                                           |  3 R OPTION RESOLVE=Y               |                                      */
/*                                           |  ====================               |                                      */
/*                                           |                                     |                                      */
/*                                           |  %let specieVar = SPECIES;          | ROWNAMES    SPECIES    SEPALLENGTH   */
/*                                           |  %let specieVal = Setosa;           |                                      */
/*                                           |                                     |     1       Setosa          51       */
/*                                           |  %let sepalVar  = SEPALLENGTH;      |     2       Setosa          52       */
/*                                           |  %let sepalVal  = 50;               |     3       Setosa          54       */
/*                                           |                                     |                                      */
/*                                           |  %utl_submit_r64x('                 |                                      */
/*                                           |   library(sqldf);                   |                                      */
/*                                           |   library(haven);                   |                                      */
/*                                           |   iris<-read_sas                    |                                      */
/*                                           |     ("d:/sd1/iris.sas7bdat");       |                                      */
/*                                           |   iris;                             |                                      */
/*                                           |   want<-sqldf("                     |                                      */
/*                                           |      select                         |                                      */
/*                                           |         *                           |                                      */
/*                                           |      from                           |                                      */
/*                                           |         iris                        |                                      */
/*                                           |      where                          |                                      */
/*                                           |             &sepalVar > &sepalVal   |                                      */
/*                                           |        and &specieVar = `&specieVal`|                                      */
/*                                           |   ");                               |                                      */
/*                                           |   want;                             |                                      */
/*                                           |   source("c:/temp/fn_tosas9.R");    |                                      */
/*                                           |   fn_tosas9(dataf=want);            |                                      */
/*                                           |   ',resolve=Y);                     |                                      */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                           |                                     |                                      */
/*                                           |   4 R FUNCTIONAL                    |                                      */
/*                                           |   =============                     |                                      */
/*                                           |                                     |                                      */
/*                                           |    %utl_submit_r64x('               | ROWNAMES    SPECIES    SEPALLENGTH   */
/*                                           |    library(sqldf);                  |                                      */
/*                                           |    library(haven);                  |     1       Setosa          51       */
/*                                           |    iris<-read_sas                   |     2       Setosa          52       */
/*                                           |      ("d:/sd1/iris.sas7bdat");      |     3       Setosa          54      */
/*                                           |    specieVar <- "SPECIES";          |                                      */
/*                                           |    specieVal <- `"Setosa"`;         |                                      */
/*                                           |                                     |                                      */
/*                                           |    sepalVar  <- "SEPALLENGTH";      |                                      */
/*                                           |    sepalVal  <- 50;                 |                                      */
/*                                           |                                     |                                      */
/*                                           |    want<-fn$sqldf("                 |                                      */
/*                                           |     select                          |                                      */
/*                                           |        *                            |                                      */
/*                                           |     from                            |                                      */
/*                                           |        iris                         |                                      */
/*                                           |     where                           |                                      */
/*                                           |            $sepalVar > $sepalVal    |                                      */
/*                                           |       and $specieVar = $specieVal   |                                      */
/*                                           |    ");                              |                                      */
/*                                           |    want;                            |                                      */
/*                                           |    source("c:/temp/fn_tosas9.R");   |                                      */
/*                                           |    fn_tosas9(dataf=want);           |                                      */
/*                                           |    ',resolve=Y);                    |                                      */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                           |                                     |                                      */
/*                                           | 5 R STRING QUERY                    |                                      */
/*                                           | ==============                      |                                      */
/*                                           |                                     |                                      */
/*                                           | %utl_rbegin;                        | ROWNAMES    SPECIES    SEPALLENGTH   */
/*                                           | parmcards4;                         |                                      */
/*                                           |  library(sqldf)                     |     1       Setosa          51       */
/*                                           |  library(haven)                     |     2       Setosa          52       */
/*                                           |  iris<-read_sas                     |     3       Setosa          54       */
/*                                           |    ("d:/sd1/iris.sas7bdat")         |                                      */
/*                                           |  iris                               |                                      */
/*                                           |  specieVar <- "SPECIES"             |                                      */
/*                                           |  specieVal <- '"Setosa"'            |                                      */
/*                                           |  sepalVar  <- "SEPALLENGTH"         |                                      */
/*                                           |  sepalVal  <- 50                    |                                      */
/*                                           |  sqlcmd = paste ("                  |                                      */
/*                                           |    select                           |                                      */
/*                                           |       *                             |                                      */
/*                                           |    from                             |                                      */
/*                                           |       iris                          |                                      */
/*                                           |    where"                           |                                      */
/*                                           |     ,      sepalVar, ">",sepalVal   |                                      */
/*                                           |     ,"and",specieVar,"=",specieVal  |                                      */
/*                                           |    )                                |                                      */
/*                                           |  want<-sqldf(sqlcmd)                |                                      */
/*                                           |  want                               |                                      */
/*                                           |  source("c:/temp/fn_tosas9.R");     |                                      */
/*                                           |  fn_tosas9(dataf=want);             |                                      */
/*                                           | ;;;;                                |                                      */
/*                                           | %utl_rend;                          |                                      */
/*                                           |                                     |                                      */
/**************************************************************************************************************************/

/*           _   _
 _ __  _   _| |_| |__   ___  _ __
| `_ \| | | | __| `_ \ / _ \| `_ \
| |_) | |_| | |_| | | | (_) | | | |
| .__/ \__, |\__|_| |_|\___/|_| |_|
|_|    |___/
*/

/**************************************************************************************************************************/
/*                                   |                                                              |                     */
/*                                   |                                                              |                     */
/*           INPUT                   |                                                              |                     */
/*           =====                   |                                                              |                     */
/*                                   |                                                              |                     */
/* options validvarname=upcase;      | 1 WPS PY FUNCTIONAL                                          |                     */
/* libname sd1 "d:/sd1";             | ===================                                          |                     */
/* data sd1.iris;                    |                                                              |                     */
/*   set sashelp.iris(where=         | %utl_pybegin;                                                | SPECIES SEPALLENGTH */
/*     (uniform(1234)< 15/150));     | parmcards4;                                                  |                     */
/*   keep species sepallength;       | import os                                                    | Setosa       51     */
/* run;quit;                         | import sys                                                   | Setosa       52     */
/*                                   | import subprocess                                            | Setosa       54     */
/*                                   | import time                                                  |                     */
/* %let specieVar = SPECIES;         | from os import path                                          |                     */
/* %let specieVal = "Setosa";        | import pandas as pd                                          |                     */
/*                                   | import numpy as np                                           |                     */
/* %let sepalVar  = SEPALLENGTH;     | from pandasql import sqldf                                   |                     */
/* %let sepalVal  = 50;              | mysql = lambda q: sqldf(q, globals())                        |                     */
/*                                   | from pandasql import PandaSQL                                |                     */
/* SEPALLENGTH>50 & SPECIES="Setosa" | pdsql = PandaSQL(persist=True)                               |                     */
/*                                   | import pyreadstat as ps                                      |                     */
/* Obs  SPECIES     SEPALLENGTH      | sqlite3conn = next(pdsql.conn.gen).connection.connection     |                     */
/*                                   | sqlite3conn.enable_load_extension(True)                      |                     */
/*   1  Setosa           46          | sqlite3conn.load_extension("c:/temp/libsqlitefunctions.dll") |                     */
/*   2  Setosa           51 Select   | mysql = lambda q: sqldf(q, globals())                        |                     */
/*   3  Setosa           48          | iris, meta = ps.read_sas7bdat("d:/sd1/iris.sas7bdat")        |                     */
/*   4  Setosa           52 Select   | speciesVal  = "Setosa"                                       |                     */
/*   5  Setosa           44          | speciesVar  = "SPECIES"                                      |                     */
/*   6  Setosa           48          | sepalVar    = "SEPALLENGTH"                                  |                     */
/*   7  Setosa           54 Select   | sepalVal    = "50";                                          |                     */
/*   8  Versicolor       54          | sql = f"""                                                   |                     */
/*   9  Versicolor       56          |   select                                                     |                     */
/*  10  Versicolor       63          |     *                                                        |                     */
/*  11  Versicolor       61          |   from                                                       |                     */
/*  12  Versicolor       55          |     iris                                                     |                     */
/*  13  Virginica        64          |   where                                                      |                     */
/*  14  Virginica        61          |        trim({speciesVar}) = "{speciesVal}"                   |                     */
/*  15  Virginica        77          |    and {sepalVar}         > {sepalVal}"""                    |                     */
/*  16  Virginica        65          | print(sql)                                                   |                     */
/*  17  Virginica        57          | want = pdsql(sql);                                           |                     */
/*  18  Virginica        58          | print(want);                                                 |                     */
/*                                   | exec(open('c:/temp/fn_tosas9.py').read())                    |                     */
/*                                   | fn_tosas9(                                                   |                     */
/*                                   |   want                                                       |                     */
/*                                   |  ,dfstr="want"                                               |                     */
/*                                   |  ,timeest=2                                                  |                     */
/*                                   |    )                                                         |                     */
/*                                   | ;;;;                                                         |                     */
/*                                   | %utl_pyend;                                                  |                     */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                   |                                                              |                     */
/*                                   | 2 PY SAS MACRO VARS                                          |                     */
/*                                   | ====================                                         |                     */
/*                                   |                                                              |                     */
/*                                   | %let speciesVal  = \'Setosa\';                               | SPECIES SEPALLENGTH */
/*                                   | %let speciesVar  =  SPECIES;                                 |                     */
/*                                   | %let sepalVar    =  SEPALLENGTH;                             | Setosa       51     */
/*                                   | %let sepalVal    =  50;                                      | Setosa       52     */
/*                                   |                                                              | Setosa       54     */
/*                                   | %utl_submit_py64_310x("                                      |                     */
/*                                   | import os;                                                   |                     */
/*                                   | import sys;                                                  |                     */
/*                                   | import subprocess;                                           |                     */
/*                                   | import time;                                                 |                     */
/*                                   | from os import path;                                         |                     */
/*                                   | import pandas as pd;                                         |                     */
/*                                   | import numpy as np;                                          |                     */
/*                                   | from pandasql import sqldf;                                  |                     */
/*                                   | mysql = lambda q: sqldf(q, globals());                       |                     */
/*                                   | from pandasql import PandaSQL;                               |                     */
/*                                   | pdsql = PandaSQL(persist=True);                              |                     */
/*                                   | import pyreadstat as ps;                                     |                     */
/*                                   | sqlite3conn = next(pdsql.conn.gen).connection.connection;    |                     */
/*                                   | sqlite3conn.enable_load_extension(True);                     |                     */
/*                                   | sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll');|                     */
/*                                   | mysql = lambda q: sqldf(q, globals());                       |                     */
/*                                   | iris, meta = ps.read_sas7bdat('d:/sd1/iris.sas7bdat');       |                     */
/*                                   | sql = f'''                                                   |                     */
/*                                   |   select                                                     |                     */
/*                                   |     *                                                        |                     */
/*                                   |   from                                                       |                     */
/*                                   |     iris                                                     |                     */
/*                                   |   where                                                      |                     */
/*                                   |        trim(&speciesVar) = &speciesVal                       |                     */
/*                                   |    and &sepalVar         > &sepalVal''';                     |                     */
/*                                   | print(sql);                                                  |                     */
/*                                   | want = pdsql(sql);                                           |                     */
/*                                   | print(want);                                                 |                     */
/*                                   | exec(open('c:/temp/fn_tosas9.py').read());                   |                     */
/*                                   | fn_tosas9(                                                   |                     */
/*                                   |     want                                                     |                     */
/*                                   |    ,dfstr='want'                                             |                     */
/*                                   |    ,timeest=2                                                |                     */
/*                                   |    );                                                        |                     */
/*                                   | ");                                                          |                     */
/*------------------------------------------------------------------------------------------------------------------------*/
/*                                   |                                                              |                     */
/*                                   | 3 PY STRING QUERY                                            |                     */
/*                                   | =================                                            |                     */
/*                                   |                                                              |                     */
/*                                   | %utl_pybegin;                                                |                     */
/*                                   | parmcards4;                                                  | SPECIES SEPALLENGTH */
/*                                   | import os                                                    |                     */
/*                                   | import sys                                                   | Setosa       51     */
/*                                   | import subprocess                                            | Setosa       52     */
/*                                   | import time                                                  | Setosa       54     */
/*                                   | from os import path                                          |                     */
/*                                   | import pandas as pd                                          |                     */
/*                                   | import numpy as np                                           |                     */
/*                                   | from pandasql import sqldf                                   |                     */
/*                                   | mysql = lambda q: sqldf(q, globals())                        |                     */
/*                                   | from pandasql import PandaSQL                                |                     */
/*                                   | pdsql = PandaSQL(persist=True)                               |                     */
/*                                   | import pyreadstat as ps                                      |                     */
/*                                   | sqlite3conn = next(pdsql.conn.gen).connection.connection;    |                     */
/*                                   | sqlite3conn.enable_load_extension(True);                     |                     */
/*                                   | sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll') |                     */
/*                                   | mysql = lambda q: sqldf(q, globals())                        |                     */
/*                                   | iris, meta = ps.read_sas7bdat('d:/sd1/iris.sas7bdat')        |                     */
/*                                   | speciesVar = "SPECIES"                                       |                     */
/*                                   | speciesVal = '"Setosa"'                                      |                     */
/*                                   | sepalVar   = "SEPALLENGTH"                                   |                     */
/*                                   | sepalVal   = "50"                                            |                     */
/*                                   | sql = "select * from iris where " + speciesVar + " = "  \    |                     */
/*                                   |           + speciesVal                                \      |                     */
/*                                   |           + " and " + sepalVar + ">" + sepalVal              |                     */
/*                                   | print(sql)                                                   |                     */
/*                                   | want = pdsql(sql)                                            |                     */
/*                                   | print(want)                                                  |                     */
/*                                   | exec(open('c:/temp/fn_tosas9.py').read())                    |                     */
/*                                   | fn_tosas9(                                                   |                     */
/*                                   |     want                                                     |                     */
/*                                   |    ,dfstr='want'                                             |                     */
/*                                   |    ,timeest=2                                                |                     */
/*                                   |    )                                                         |                     */
/*                                   | ;;;;                                                         |                     */
/*                                   | %utl_pyend;                                                  |                     */
/*                                   |                                                              |                     */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase;
libname sd1 "d:/sd1";
data sd1.iris;
  set sashelp.iris(where=
    (uniform(1234)< 15/150));
  keep species sepallength;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  %let specieVar = SPECIES;                                                                                             */
/*  %let specieVal = "Setosa";                                                                                            */
/*                                                                                                                        */
/*  %let sepalVar  = SEPALLENGTH;                                                                                         */
/*  %let sepalVal  = 50;                                                                                                  */
/*                                                                                                                        */
/*  SEPALLENGTH>50 & SPECIES="Setosa"                                                                                     */
/*                                                                                                                        */
/*  Obs  SPECIES     SEPALLENGTH                                                                                          */
/*                                                                                                                        */
/*    1  Setosa           46                                                                                              */
/*    2  Setosa           51 Select                                                                                       */
/*    3  Setosa           48                                                                                              */
/*    4  Setosa           52 Select                                                                                       */
/*    5  Setosa           44                                                                                              */
/*    6  Setosa           48                                                                                              */
/*    7  Setosa           54 Select                                                                                       */
/*    8  Versicolor       54                                                                                              */
/*    9  Versicolor       56                                                                                              */
/*   10  Versicolor       63                                                                                              */
/*   11  Versicolor       61                                                                                              */
/*   12  Versicolor       55                                                                                              */
/*   13  Virginica        64                                                                                              */
/*   14  Virginica        61                                                                                              */
/*   15  Virginica        77                                                                                              */
/*   16  Virginica        65                                                                                              */
/*   17  Virginica        57                                                                                              */
/*   18  Virginica        58                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*                                 _
/ |  ___  __ _ ___    ___ ___   __| | ___
| | / __|/ _` / __|  / __/ _ \ / _` |/ _ \
| | \__ \ (_| \__ \ | (_| (_) | (_| |  __/
|_| |___/\__,_|___/  \___\___/ \__,_|\___|

*/

 proc datasets lib=work nolist nodetails;
  delete want;
 run;quit;

 %let specieVar = SPECIES;
 %let specieVal = "Setosa";

 %let sepalVar  = SEPALLENGTH;
 %let sepalVal  = 50;

 proc sql;
   create
     table want as
   select
     *
   from
     sd1.iris
   where
        &sepalVar   > &sepalVal
     and &specieVar = &specieVal
 ;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* WANT total obs=3                                                                                                       */
/*                                                                                                                        */
/* Obs    SPECIES    SEPALLENGTH                                                                                          */
/*                                                                                                                        */
/*  1     Setosa          51                                                                                              */
/*  2     Setosa          52                                                                                              */
/*  3     Setosa          54                                                                                              */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                                                                         _
|___ \   _ __   ___  __ _ ___    ___  ___  ___ __ _ _ __   ___   ___ ___   __| | ___
  __) | | `__| / __|/ _` / __|  / _ \/ __|/ __/ _` | `_ \ / _ \ / __/ _ \ / _` |/ _ \
 / __/  | |    \__ \ (_| \__ \ |  __/\__ \ (_| (_| | |_) |  __/| (_| (_) | (_| |  __/
|_____| |_|    |___/\__,_|___/  \___||___/\___\__,_| .__/ \___| \___\___/ \__,_|\___|
                                                   |_|
*/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%let specieVar = SPECIES;
%let specieVal = Setosa;

%let sepalVar  = SEPALLENGTH;
%let sepalVal  = 50;

%utl_submit_r64x("
 library(sqldf);
 library(haven);
 iris<-read_sas
   ('d:/sd1/iris.sas7bdat');
 iris;
 want<-sqldf('
    select
       *
    from
       iris
    where
          &sepalVar > &sepalVal
     and &specieVar = \'&specieVal\'
 ');
 want;
 source('c:/temp/fn_tosas9.R');
 fn_tosas9(dataf=want);
 ");

libname tmp "c:/temp";
proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* ROWNAMES    SPECIES    SEPALLENGTH                                                                                     */
/*                                                                                                                        */
/*     1       Setosa          51                                                                                         */
/*     2       Setosa          52                                                                                         */
/*     3       Setosa          54                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*____                      _   _                                  _
|___ /   _ __    ___  _ __ | |_(_) ___  _ __   _ __ ___  ___  ___ | |_   _____ _____ _   _
  |_ \  | `__|  / _ \| `_ \| __| |/ _ \| `_ \ | `__/ _ \/ __|/ _ \| \ \ / / _ \_____| | | |
 ___) | | |    | (_) | |_) | |_| | (_) | | | || | |  __/\__ \ (_) | |\ V /  __/_____| |_| |
|____/  |_|     \___/| .__/ \__|_|\___/|_| |_||_|  \___||___/\___/|_| \_/ \___|      \__, |
                     |_|                                                             |___/
*/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%let specieVar = SPECIES;
%let specieVal = Setosa;

%let sepalVar  = SEPALLENGTH;
%let sepalVal  = 50;

%utl_submit_r64x('
 library(sqldf);
 library(haven);
 iris<-read_sas
   ("d:/sd1/iris.sas7bdat");
 iris;
 want<-sqldf("
    select
       *
    from
       iris
    where
           &sepalVar > &sepalVal
      and &specieVar = `&specieVal`
 ");
 want;
 source("c:/temp/fn_tosas9.R");
 fn_tosas9(dataf=want);
 ',resolve=Y);

proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* ROWNAMES    SPECIES    SEPALLENGTH                                                                                     */
/*                                                                                                                        */
/*     1       Setosa          51                                                                                         */
/*     2       Setosa          52                                                                                         */
/*     3       Setosa          54                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*  _             __                  _   _                   _             _
| || |    _ __   / _|_   _ _ __   ___| |_(_) ___  _ __   __ _| |  ___  __ _| |
| || |_  | `__| | |_| | | | `_ \ / __| __| |/ _ \| `_ \ / _` | | / __|/ _` | |
|__   _| | |    |  _| |_| | | | | (__| |_| | (_) | | | | (_| | | \__ \ (_| | |
   |_|   |_|    |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|\__,_|_| |___/\__, |_|
                                                                         |_|
*/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%utl_submit_r64x('
library(sqldf);
library(haven);
iris<-read_sas
  ("d:/sd1/iris.sas7bdat");
specieVar <- "SPECIES";
specieVal <- `"Setosa"`;

sepalVar  <- "SEPALLENGTH";
sepalVal  <- 50;

want<-fn$sqldf("
 select
    *
 from
    iris
 where
        $sepalVar > $sepalVal
   and $specieVar = $specieVal
");
want;
source("c:/temp/fn_tosas9.R");
fn_tosas9(dataf=want);
',resolve=Y);

proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* ROWNAMES    SPECIES    SEPALLENGTH                                                                                     */
/*                                                                                                                        */
/*     1       Setosa          51                                                                                         */
/*     2       Setosa          52                                                                                         */
/*     3       Setosa          54                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___               _        _
| ___|   _ __   ___| |_ _ __(_)_ __   __ _    __ _ _   _  ___ _ __ _   _
|___ \  | `__| / __| __| `__| | `_ \ / _` |  / _` | | | |/ _ \ `__| | | |
 ___) | | |    \__ \ |_| |  | | | | | (_| | | (_| | |_| |  __/ |  | |_| |
|____/  |_|    |___/\__|_|  |_|_| |_|\__, |  \__, |\__,_|\___|_|   \__, |
                                     |___/      |_|                |___/
*/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%utl_rbegin;
parmcards4;
library(sqldf)
library(haven)
iris<-read_sas("d:/sd1/iris.sas7bdat")
iris
specieVar <- "SPECIES"
specieVal <- '"Setosa"'
sepalVar  <- "SEPALLENGTH"
sepalVal  <- 50
sqlcmd = paste ("
  select
     *
  from
     iris
  where "
   ,      sepalVar, ">",sepalVal
   ,"and",specieVar,"=",specieVal
  )
sqlcmd;
want<-sqldf(sqlcmd)
want
source("c:/temp/fn_tosas9.R");
fn_tosas9(dataf=want);
;;;;
%utl_rend;

proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/* ROWNAMES    SPECIES    SEPALLENGTH                                                                                     */
/*                                                                                                                        */
/*     1       Setosa          51                                                                                         */
/*     2       Setosa          52                                                                                         */
/*     3       Setosa          54                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*           _   _
 _ __  _   _| |_| |__   ___  _ __
| `_ \| | | | __| `_ \ / _ \| `_ \
| |_) | |_| | |_| | | | (_) | | | |
| .__/ \__, |\__|_| |_|\___/|_| |_|
|_|    |___/
*/

/*
/ | __      ___ __  ___   _ __  _   _    __                  _   _                   _
| | \ \ /\ / / `_ \/ __| | `_ \| | | |  / _|_   _ _ __   ___| |_(_) ___  _ __   __ _| |
| |  \ V  V /| |_) \__ \ | |_) | |_| | | |_| | | | `_ \ / __| __| |/ _ \| `_ \ / _` | |
|_|   \_/\_/ | .__/|___/ | .__/ \__, | |  _| |_| | | | | (__| |_| | (_) | | | | (_| | |
             |_|         |_|    |___/  |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|\__,_|_|
*/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%utl_pybegin;
parmcards4;
import os
import sys
import subprocess
import time
from os import path
import pandas as pd
import numpy as np
from pandasql import sqldf
mysql = lambda q: sqldf(q, globals())
from pandasql import PandaSQL
pdsql = PandaSQL(persist=True)
import pyreadstat as ps
sqlite3conn = next(pdsql.conn.gen).connection.connection
sqlite3conn.enable_load_extension(True)
sqlite3conn.load_extension("c:/temp/libsqlitefunctions.dll")
mysql = lambda q: sqldf(q, globals())
iris, meta = ps.read_sas7bdat("d:/sd1/iris.sas7bdat")
speciesVal  = "Setosa"
speciesVar  = "SPECIES"
sepalVar    = "SEPALLENGTH"
sepalVal    = "50";
sql = f"""
  select
    *
  from
    iris
  where
       trim({speciesVar}) = "{speciesVal}"
   and {sepalVar}         > {sepalVal}"""
print(sql)
want = pdsql(sql);
print(want);
exec(open('c:/temp/fn_tosas9.py').read())
fn_tosas9(
  want
 ,dfstr="want"
 ,timeest=2
   )
;;;;
%utl_pyend;

proc print data=tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Obs    SPECIES    SEPALLENGTH                                                                                         */
/*                                                                                                                        */
/*   1     Setosa          51                                                                                             */
/*   2     Setosa          52                                                                                             */
/*   3     Setosa          54                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___
|___ \   _ __  _   _   ___  __ _ ___   _ __ ___   __ _  ___ _ __ ___  __   ____ _ _ __ ___
  __) | | `_ \| | | | / __|/ _` / __| | `_ ` _ \ / _` |/ __| `__/ _ \ \ \ / / _` | `__/ __|
 / __/  | |_) | |_| | \__ \ (_| \__ \ | | | | | | (_| | (__| | | (_) | \ V / (_| | |  \__ \
|_____| | .__/ \__, | |___/\__,_|___/ |_| |_| |_|\__,_|\___|_|  \___/   \_/ \__,_|_|  |___/
        |_|    |___/
*/


libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%let speciesVal  = \'Setosa\';
%let speciesVar  =  SPECIES;
%let sepalVar    =  SEPALLENGTH;
%let sepalVal    =  50;

%utl_submit_py64_310x("
import os;
import sys;
import subprocess;
import time;
from os import path;
import pandas as pd;
import numpy as np;
from pandasql import sqldf;
mysql = lambda q: sqldf(q, globals());
from pandasql import PandaSQL;
pdsql = PandaSQL(persist=True);
import pyreadstat as ps;
sqlite3conn = next(pdsql.conn.gen).connection.connection;
sqlite3conn.enable_load_extension(True);
sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll');
mysql = lambda q: sqldf(q, globals());
iris, meta = ps.read_sas7bdat('d:/sd1/iris.sas7bdat');
print(iris);
sql = f'''
  select
    *
  from
    iris
  where
       trim(&speciesVar) = &speciesVal
   and &sepalVar         > &sepalVal''';
print(sql);
want = pdsql(sql);
print(want);
exec(open('c:/temp/fn_tosas9.py').read());
fn_tosas9(
    want
   ,dfstr='want'
   ,timeest=2
   );
");

proc print data =tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Obs    SPECIES    SEPALLENGTH                                                                                         */
/*                                                                                                                        */
/*   1     Setosa          51                                                                                             */
/*   2     Setosa          52                                                                                             */
/*   3     Setosa          54                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

libname tmp "c:/temp";
proc datasets lib=tmp nolist nodetails;
 delete want;
run;quit;

%utl_pybegin;
parmcards4;
import os
import sys
import subprocess
import time
from os import path
import pandas as pd
import numpy as np
from pandasql import sqldf
mysql = lambda q: sqldf(q, globals())
from pandasql import PandaSQL
pdsql = PandaSQL(persist=True)
import pyreadstat as ps
sqlite3conn = next(pdsql.conn.gen).connection.connection;
sqlite3conn.enable_load_extension(True);
sqlite3conn.load_extension('c:/temp/libsqlitefunctions.dll')
mysql = lambda q: sqldf(q, globals())
iris, meta = ps.read_sas7bdat('d:/sd1/iris.sas7bdat')
speciesVar = "SPECIES"
speciesVal = '"Setosa"'
sepalVar   = "SEPALLENGTH"
sepalVal   = "50"
sql = "select * from iris where " + speciesVar + " = "  \
          + speciesVal                                \
          + " and " + sepalVar + ">" + sepalVal
print(sql)
want = pdsql(sql)
print(want)
exec(open('c:/temp/fn_tosas9.py').read())
fn_tosas9(
    want
   ,dfstr='want'
   ,timeest=2
   )
;;;;
%utl_pyend;

proc print data =tmp.want;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Obs    SPECIES    SEPALLENGTH                                                                                         */
/*                                                                                                                        */
/*   1     Setosa          51                                                                                             */
/*   2     Setosa          52                                                                                             */
/*   3     Setosa          54                                                                                             */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
