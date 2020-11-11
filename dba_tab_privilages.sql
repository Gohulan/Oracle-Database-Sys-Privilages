
  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "SYS"."DBA_TAB_PRIVS" ("GRANTEE", "OWNER", "TABLE_NAME", "GRANTOR", "PRIVILEGE", "GRANTABLE", "HIERARCHY", "COMMON", "TYPE", "INHERITED") AS 
  select ue.name, u.name, o.name,
       ur.name, tpm.name,
       decode(mod(oa.option$,2), 1, 'YES', 'NO'),
       decode(bitand(oa.option$,2), 2, 'YES', 'NO'), 'NO',
       decode (o.type#, 1, 'INDEX',
                        2, 'TABLE',
                        3, 'CLUSTER',
                        4, 'VIEW',
                        5, 'SYNONYM',
                        6, 'SEQUENCE',
                        7, 'PROCEDURE',
                        8, 'FUNCTION',
                        9, 'PACKAGE',
                       10, 'NON-EXISTENT',
                       11, 'PACKAGE BODY',
                       12, 'TRIGGER',
                       13, 'TYPE',
                       14, 'TYPE BODY',
                       19, 'TABLE PARTITION',
                       20, 'INDEX PARTITION',
                       21, 'LOB',
                       22, 'LIBRARY',
                       23, 'DIRECTORY',
                       24, 'QUEUE',
                       25, 'IOT',
                       26, 'REPLICATION OBJECT GROUP',
                       27, 'REPLICATION PROPAGATOR',
                       28, 'JAVA SOURCE',
                       29, 'JAVA CLASS',
                       30, 'JAVA RESOURCE',
                       31, 'JAVA JAR',
                       32, 'INDEXTYPE',
                       33, 'OPERATOR',
                       34, 'TABLE SUBPARTITION',
                       35, 'INDEX SUBPARTITION',
                       57, 'EDITION',
                       66, 'SCHEDULER JOB',
                       68, 'JOB CLASS',
                       74, 'SCHEDULE',
                       82, '(Data Mining) MODEL',
                       92, 'CUBE DIMENSION',
                       93, 'CUBE',
                       94, 'MEASURE FOLDER',
                       95, 'CUBE BUILD PROCESS',
                      100, 'FILE WATCHER',
                      101, 'DESTINATION',
                      114, 'SQL TRANSLATION PROFILE',
                      150, 'HIERARCHY',
                      151, 'ATTRIBUTE DIMENSION',
                      152, 'ANALYTIC VIEW', 'UNKNOWN'),
       'NO'
from sys.objauth$ oa, sys."_CURRENT_EDITION_OBJ" o, sys.user$ u, sys.user$ ur,
     sys.user$ ue, table_privilege_map tpm
where oa.obj# = o.obj#
  and oa.grantor# = ur.user#
  and oa.grantee# = ue.user#
  and oa.col# is null
  and oa.privilege# = tpm.privilege
  and u.user# = o.owner#
  and bitand(nvl(oa.option$, 0), 4) = 0
union all
/* Commonly granted Privileges */
select ue.name, u.name, o.name,
       ur.name, tpm.name,
       decode(bitand(oa.option$,16), 16, 'YES', 'NO'),
       decode(bitand(oa.option$,32), 32, 'YES', 'NO'), 'YES',
       decode (o.type#, 1, 'INDEX',
                        2, 'TABLE',
                        3, 'CLUSTER',
                        4, 'VIEW',
                        5, 'SYNONYM',
                        6, 'SEQUENCE',
                        7, 'PROCEDURE',
                        8, 'FUNCTION',
                        9, 'PACKAGE',
                       10, 'NON-EXISTENT',
                       11, 'PACKAGE BODY',
                       12, 'TRIGGER',
                       13, 'TYPE',
                       14, 'TYPE BODY',
                       19, 'TABLE PARTITION',
                       20, 'INDEX PARTITION',
                       21, 'LOB',
                       22, 'LIBRARY',
                       23, 'DIRECTORY',
                       24, 'QUEUE',
                       25, 'IOT',
                       26, 'REPLICATION OBJECT GROUP',
                       27, 'REPLICATION PROPAGATOR',
                       28, 'JAVA SOURCE',
                       29, 'JAVA CLASS',
                       30, 'JAVA RESOURCE',
                       31, 'JAVA JAR',
                       32, 'INDEXTYPE',
                       33, 'OPERATOR',
                       34, 'TABLE SUBPARTITION',
                       35, 'INDEX SUBPARTITION',
                       48, 'RESOURCE CONSUMER GROUP',
                       57, 'EDITION',
                       66, 'SCHEDULER JOB',
                       68, 'JOB CLASS',
                       74, 'SCHEDULE',
                       82, '(Data Mining) MODEL',
                       92, 'CUBE DIMENSION',
                       93, 'CUBE',
                       94, 'MEASURE FOLDER',
                       95, 'CUBE BUILD PROCESS',
                      100, 'FILE WATCHER',
                      101, 'DESTINATION',
                      114, 'SQL TRANSLATION PROFILE',
                      150, 'HIERARCHY',
                      151, 'ATTRIBUTE DIMENSION',
                      152, 'ANALYTIC VIEW', 'UNKNOWN'),
       decode(SYS_CONTEXT('USERENV', 'CON_ID'), 1, 'NO', 'YES')
from sys.objauth$ oa, sys."_CURRENT_EDITION_OBJ" o, sys.user$ u, sys.user$ ur,
     sys.user$ ue, table_privilege_map tpm
where oa.obj# = o.obj#
  and oa.grantor# = ur.user#
  and oa.grantee# = ue.user#
  and oa.col# is null
  and oa.privilege# = tpm.privilege
  and u.user# = o.owner#
  and bitand(oa.option$,8) = 8
union all
/* Federationally granted Privileges */
select ue.name, u.name, o.name,
       ur.name, tpm.name,
       decode(bitand(oa.option$,128), 128, 'YES', 'NO'),
       decode(bitand(oa.option$,256), 256, 'YES', 'NO'), 'YES',
       decode (o.type#, 1, 'INDEX',
                        2, 'TABLE',
                        3, 'CLUSTER',
                        4, 'VIEW',
                        5, 'SYNONYM',
                        6, 'SEQUENCE',
                        7, 'PROCEDURE',
                        8, 'FUNCTION',
                        9, 'PACKAGE',
                       10, 'NON-EXISTENT',
                       11, 'PACKAGE BODY',
                       12, 'TRIGGER',
                       13, 'TYPE',
                       14, 'TYPE BODY',
                       19, 'TABLE PARTITION',
                       20, 'INDEX PARTITION',
                       21, 'LOB',
                       22, 'LIBRARY',
                       23, 'DIRECTORY',
                       24, 'QUEUE',
                       25, 'IOT',
                       26, 'REPLICATION OBJECT GROUP',
                       27, 'REPLICATION PROPAGATOR',
                       28, 'JAVA SOURCE',
                       29, 'JAVA CLASS',
                       30, 'JAVA RESOURCE',
                       31, 'JAVA JAR',
                       32, 'INDEXTYPE',
                       33, 'OPERATOR',
                       34, 'TABLE SUBPARTITION',
                       35, 'INDEX SUBPARTITION',
                       48, 'RESOURCE CONSUMER GROUP',
                       57, 'EDITION',
                       66, 'SCHEDULER JOB',
                       68, 'JOB CLASS',
                       74, 'SCHEDULE',
                       82, '(Data Mining) MODEL',
                       92, 'CUBE DIMENSION',
                       93, 'CUBE',
                       94, 'MEASURE FOLDER',
                       95, 'CUBE BUILD PROCESS',
                      100, 'FILE WATCHER',
                      101, 'DESTINATION',
                      114, 'SQL TRANSLATION PROFILE',
                      150, 'HIERARCHY',
                      151, 'ATTRIBUTE DIMENSION',
                      152, 'ANALYTIC VIEW', 'UNKNOWN'),
       decode(SYS_CONTEXT('USERENV', 'IS_APPLICATION_PDB'), 'YES', 'YES', 'NO')
from sys.objauth$ oa, sys."_CURRENT_EDITION_OBJ" o, sys.user$ u, sys.user$ ur,
     sys.user$ ue, table_privilege_map tpm
where oa.obj# = o.obj#
  and oa.grantor# = ur.user#
  and oa.grantee# = ue.user#
  and oa.col# is null
  and oa.privilege# = tpm.privilege
  and u.user# = o.owner#
  and bitand(oa.option$,64) = 64
union all
/* Locally granted User privileges */
select ue.name, 'SYS', u.name,
       ur.name, upm.name,
       decode(bitand(ua.option$,1), 1, 'YES', 'NO'),
       'NO',
       'NO',
       'USER',
       'NO'
from sys.userauth$ ua, sys.user$ u, sys.user$ ur,
     sys.user$ ue, sys.user_privilege_map upm
where ua.user# = u.user#
  and ua.grantor# = ur.user#
  and ua.grantee# = ue.user#
  and ua.privilege# = upm.privilege
  and bitand(nvl(ua.option$, 0), 4) = 0
union all
/* Commonly granted User privileges */
select ue.name, 'SYS', u.name,
       ur.name, upm.name,
       decode(bitand(ua.option$,16), 16, 'YES', 'NO'),
       'NO',
       'YES',
       'USER',
       decode(SYS_CONTEXT('USERENV', 'CON_ID'), 1, 'NO', 'YES')
from sys.userauth$ ua, sys.user$ u, sys.user$ ur,
     sys.user$ ue, sys.user_privilege_map upm
where ua.user# = u.user#
  and ua.grantor# = ur.user#
  and ua.grantee# = ue.user#
  and ua.privilege# = upm.privilege
  and bitand(ua.option$,8) = 8
union all
/* Federationally granted User privileges */
select ue.name, 'SYS', u.name,
       ur.name, upm.name,
       decode(bitand(ua.option$,128), 128, 'YES', 'NO'),
       'NO',
       'YES',
       'USER',
       decode(SYS_CONTEXT('USERENV', 'IS_APPLICATION_PDB'), 'YES', 'YES', 'NO')
from sys.userauth$ ua, sys.user$ u, sys.user$ ur,
     sys.user$ ue, sys.user_privilege_map upm
where ua.user# = u.user#
  and ua.grantor# = ur.user#
  and ua.grantee# = ue.user#
  and ua.privilege# = upm.privilege
  and bitand(ua.option$,64) = 64;

   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."GRANTEE" IS 'User to whom access was granted';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."OWNER" IS 'Owner of the object';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."TABLE_NAME" IS 'Name of the object';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."GRANTOR" IS 'Name of the user who performed the grant';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."PRIVILEGE" IS 'Table Privilege';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."GRANTABLE" IS 'Privilege is grantable';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."HIERARCHY" IS 'Privilege is with hierarchy option';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."COMMON" IS 'Privilege was granted commonly';
   COMMENT ON COLUMN "SYS"."DBA_TAB_PRIVS"."INHERITED" IS 'Was privilege grant inherited from another container';
   COMMENT ON TABLE "SYS"."DBA_TAB_PRIVS"  IS 'All grants on objects in the database';
