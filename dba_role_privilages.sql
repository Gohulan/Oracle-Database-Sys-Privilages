
  CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "SYS"."DBA_ROLE_PRIVS" ("GRANTEE", "GRANTED_ROLE", "ADMIN_OPTION", "DELEGATE_OPTION", "DEFAULT_ROLE", "COMMON", "INHERITED") AS 
  select /*+ ordered */ decode(sa.grantee#, 1, 'PUBLIC', u1.name), u2.name,
       decode(min(bitand(nvl(option$, 0), 1)), 1, 'YES', 'NO'),
       decode(min(bitand(nvl(option$, 0), 2)), 2, 'YES', 'NO'),
       decode(min(u1.defrole), 0, 'NO',
              1, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'),'NO'),
              2, decode(min(ud.role#), NULL, 'NO', decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO')),
              3, decode(min(ud.role#), NULL, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO'), 'NO'), 'NO'),
       'NO', 'NO'
from sysauth$ sa, user$ u1, user$ u2, defrole$ ud
where sa.grantee#=ud.user#(+)
  and sa.privilege#=ud.role#(+) and u1.user#=sa.grantee#
  and u2.user#=sa.privilege#
  and bitand(nvl(option$, 0), 4) = 0
group by decode(sa.grantee#,1,'PUBLIC',u1.name),u2.name
union all
/* Commonly granted Privileges */
select /*+ ordered */ decode(sa.grantee#, 1, 'PUBLIC', u1.name), u2.name,
       decode(min(bitand(nvl(option$, 0), 16)), 16, 'YES', 'NO'),
       decode(min(bitand(nvl(option$, 0), 32)), 32, 'YES', 'NO'),
       decode(min(u1.defrole), 0, 'NO',
              1, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'),'NO'),
              2, decode(min(ud.role#), NULL, 'NO', decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO')),
              3, decode(min(ud.role#), NULL, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO'), 'NO'), 'NO'),
       'YES', decode(SYS_CONTEXT('USERENV', 'CON_ID'), 1, 'NO', 'YES')
from sysauth$ sa, user$ u1, user$ u2, defrole$ ud
where sa.grantee#=ud.user#(+)
  and sa.privilege#=ud.role#(+) and u1.user#=sa.grantee#
  and u2.user#=sa.privilege#
  and bitand(nvl(option$, 0), 8) = 8
group by decode(sa.grantee#,1,'PUBLIC',u1.name),u2.name
union all
/* Federationally granted Privileges */
select /*+ ordered */ decode(sa.grantee#, 1, 'PUBLIC', u1.name), u2.name,
       decode(min(bitand(nvl(option$, 0), 128)), 128, 'YES', 'NO'),
       decode(min(bitand(nvl(option$, 0), 256)), 256, 'YES', 'NO'),
       decode(min(u1.defrole), 0, 'NO',
              1, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'),'NO'),
              2, decode(min(ud.role#), NULL, 'NO', decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO')),
              3, decode(min(ud.role#), NULL, decode(min(u2.password), NULL, decode(min(u2.spare4), NULL, 'YES', 'NO'), 'NO'), 'NO'), 'NO'),
       'YES',
       decode(SYS_CONTEXT('USERENV', 'IS_APPLICATION_PDB'), 'YES', 'YES', 'NO')
from sysauth$ sa, user$ u1, user$ u2, defrole$ ud
where sa.grantee#=ud.user#(+)
  and sa.privilege#=ud.role#(+) and u1.user#=sa.grantee#
  and u2.user#=sa.privilege#
  and bitand(nvl(option$, 0), 64) = 64
group by decode(sa.grantee#,1,'PUBLIC',u1.name),u2.name;

   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."GRANTEE" IS 'Grantee Name, User or Role receiving the grant';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."GRANTED_ROLE" IS 'Granted role name';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."ADMIN_OPTION" IS 'Grant was with the ADMIN option';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."DELEGATE_OPTION" IS 'Grant was with the DELEGATE option';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."DEFAULT_ROLE" IS 'Role is designated as a DEFAULT ROLE for the user';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."COMMON" IS 'Role was granted commonly';
   COMMENT ON COLUMN "SYS"."DBA_ROLE_PRIVS"."INHERITED" IS 'Was role grant inherited from another container';
   COMMENT ON TABLE "SYS"."DBA_ROLE_PRIVS"  IS 'Roles granted to users and roles';
