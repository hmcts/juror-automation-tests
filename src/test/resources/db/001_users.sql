--delete from juror_mod.user_courts;
--commit;
--
--delete from juror_mod.user_roles;
--commit;

TRUNCATE TABLE juror_mod.users CASCADE;
commit;

INSERT INTO juror_mod.users (owner, user_type, username, email, name, active, version, approval_limit)
VALUES ('400', 'BUREAU', 'MODTESTBUREAU', 'MODTESTBUREAU@email.gov.uk', 'MODTESTBUREAU', true, 1, 0),
       ('415', 'COURT', 'MODTESTCOURT', 'MODTESTCOURT@email.gov.uk', 'MODTESTCOURT', true, 1, 0),
       ('400', 'SYSTEM', 'AUTO', 'AUTO@email.gov.uk', 'AUTO', true, 1, 0),
       ('400', 'BUREAU', 'TeamPickListUser', 'TeamPickListUser@email.gov.uk', 'TeamPickListUser', true, 1, 0),
       ('400', 'BUREAU', 'AutomationStaffTWO', 'AutomationStaffTWO@email.gov.uk', 'AutomationStaffTWO', true, 1, 0),
       ('400', 'SYSTEM', 'SYSTEM', 'SYSTEM@email.gov.uk', 'SYSTEM', true, 1, 0),
       ('416', 'COURT', 'SJOUSER1', 'SJOUSER1@email.gov.uk', 'SJOUSER1', true, 1, 0),
       ('415', 'COURT', 'SJOUSER', 'SJOUSER@email.gov.uk', 'SJOUSER', true, 1, 0),
       ('400', 'BUREAU', 'CPASS', 'CPASS@email.gov.uk', 'CPASS', true, 1, 0),
       ('400', 'BUREAU', 'NEWUSER', 'NEWUSER@email.gov.uk', 'NEWUSER', true, 1, 0),
       ('400', 'BUREAU', 'ARAMIS1', 'ARAMIS1@email.gov.uk', 'ARAMIS1', true, 1, 0),
       ('415', 'COURT', 'CMANAGER', 'CMANAGER@email.gov.uk', 'CMANAGER', true, 1, 1000),
       ('415', 'COURT', 'CMANAGER2', 'CMANAGER2@email.gov.uk', 'CMANAGER2', true, 1, 1000),
       ('415', 'COURT', 'MODCOURT', 'MODCOURT@email.gov.uk', 'MODCOURT', true, 1, 0);
commit;

INSERT INTO juror_mod.user_roles (username, role)
VALUES ('MODTESTBUREAU', 'TEAM_LEADER'),
       ('CPASS', 'TEAM_LEADER'),
       ('SJOUSER1', 'SENIOR_JUROR_OFFICER'),
       ('SJOUSER', 'SENIOR_JUROR_OFFICER'),
       ('CMANAGER', 'MANAGER'),
       ('CMANAGER2', 'MANAGER');
commit;

INSERT INTO juror_mod.user_courts (username, loc_code)
VALUES ('MODTESTBUREAU', '400'),
       ('MODTESTCOURT', '415'),
       ('MODCOURT', '415'),
       ('MODCOURT', '769'),
       ('MODCOURT', '416'),
       ('AUTO', '400'),
       ('TeamPickListUser', '400'),
       ('AutomationStaffTWO', '400'),
       ('SYSTEM', '400'),
       ('SJOUSER1', '416'),
       ('SJOUSER', '415'),
       ('CPASS', '400'),
       ('ARAMIS1', '400'),
       ('CMANAGER', '415'),
       ('CMANAGER2', '415'),
       ('NEWUSER', '400');
commit;