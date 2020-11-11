
  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "SYS"."DBA_SYS_PRIVS" ("GRANTEE", "PRIVILEGE", "ADMIN_OPTION", "COMMON", "INHERITED") AS 
  select u.name,spm.name,decode(min(mod(option$, 2)),1,'YES','NO'),
       'NO', 'NO'
from  sys.system_privilege_map spm, sys.sysauth$ sa, user$ u
where sa.grantee#=u.user# and sa.privilege#=spm.privilege
  and bitand(nvl(option$, 0), 4) = 0
group by u.name,spm.name
union all
/* Commonly granted Privileges */
select u.name,spm.name,decode(min(bitand(option$, 16)),16,'YES','NO'),
       'YES', decode(SYS_CONTEXT('USERENV', 'CON_ID'), 1, 'NO', 'YES')
from  sys.system_privilege_map spm, sys.sysauth$ sa, user$ u
where sa.grantee#=u.user# and sa.privilege#=spm.privilege
  and bitand(option$,8) = 8
group by u.name,spm.name
union all
/* Federationally granted Privileges */
select u.name,spm.name,decode(min(bitand(option$, 128)),128,'YES','NO'),
       'YES',
       decode(SYS_CONTEXT('USERENV', 'IS_APPLICATION_PDB'), 'YES', 'YES', 'NO')
from  sys.system_privilege_map spm, sys.sysauth$ sa, user$ u
where sa.grantee#=u.user# and sa.privilege#=spm.privilege
  and bitand(option$,64) = 64
group by u.name,spm.name;

   COMMENT ON COLUMN "SYS"."DBA_SYS_PRIVS"."GRANTEE" IS 'Grantee Name, User or Role receiving the grant';
   COMMENT ON COLUMN "SYS"."DBA_SYS_PRIVS"."PRIVILEGE" IS 'System privilege';
   COMMENT ON COLUMN "SYS"."DBA_SYS_PRIVS"."ADMIN_OPTION" IS 'Grant was with the ADMIN option';
   COMMENT ON COLUMN "SYS"."DBA_SYS_PRIVS"."COMMON" IS 'Privilege is common';
   COMMENT ON COLUMN "SYS"."DBA_SYS_PRIVS"."INHERITED" IS 'Was role grant inherited from another container';
   COMMENT ON TABLE "SYS"."DBA_SYS_PRIVS"  IS 'System privileges granted to users and roles';
