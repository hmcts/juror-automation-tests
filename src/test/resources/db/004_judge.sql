delete from JUROR_MOD.JUDGE;
commit;

INSERT INTO juror_mod.judge ("owner", code, description, telephone_number, is_active, last_used)
VALUES ('435', 'DRED', 'DREDD', NULL, false, NULL),
       ('421', 'AITK', 'PATRICIA H AITKEN', NULL, false, NULL),
       ('452', 'AITK', 'PATRICIA H AITKEN', NULL, false, NULL),
       ('435', 'LAWW', 'HIGHCOURT', NULL, false, NULL),
       ('435', 'JUDD', 'LAWSON', NULL, false, NULL),
       ('400', 'AITK', 'PATRICIA H AITKEN', NULL, false, NULL),
       ('442', 'AITK', 'PATRICIA H AITKEN', NULL, false, NULL),
       ('457', 'DEED', 'JOHN', NULL, false, NULL),
       ('451', 'DRED', 'DREDD', NULL, false, NULL),
       ('417', 'AITK', 'PATRICIA H AITKEN', NULL, false, NULL),
       ('415', 'AITK', 'PATRICIA H AITKEN', NULL, false, '2024-03-01 10:06:42.04449');
commit;