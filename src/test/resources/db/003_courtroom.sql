UPDATE juror_mod.court_location set assembly_room = null;
commit;

delete FROM juror_mod.trial;
commit;

delete FROM juror_mod.courtroom;
commit;

INSERT INTO juror_mod.courtroom (loc_code, room_number, description)
VALUES ('421', 'Navail', 'Not Available'),
       ('435', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('435', 'CT10', 'Court 10'),
       ('442', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('435', 'Court', 'COURT ROOM'),
       ('451', 'COURT4', 'Court 4'),
       ('421', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('442', 'Court ', 'COURT ROOM'),
       ('435', 'COURT3', 'Court 3'),
       ('451', 'COURT3', 'Court 3'),
       ('452', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('435', 'Navail', 'Not Available'),
       ('452', 'Court ', 'COURT ROOM'),
       ('417', 'Court ', 'COURT ROOM'),
       ('451', 'COURT6', 'Court 6'),
       ('451', 'COURT8', 'Court 8'),
       ('451', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('435', 'COURT1', 'Court 1'),
       ('417', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('452', 'Navail', 'Not Available'),
       ('435', 'COURT4', 'Court 4'),
       ('451', 'COURT2', 'Court 2'),
       ('457', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('452', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('457', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('417', 'Navail', 'Not Available'),
       ('421', 'Court ', 'COURT ROOM'),
       ('421', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('435', 'COURT9', 'Court 9'),
       ('451', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('415', 'Court ', 'COURT ROOM'),
       ('435', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('417', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('435', 'COURT6', 'Court 6'),
       ('451', 'COURT1', 'Court 1'),
       ('435', 'COURT7', 'Court 7'),
       ('451', 'Court', 'COURT ROOM'),
       ('451', 'Navail', 'Not Available'),
       ('457', 'Navail', 'Not Available'),
       ('451', 'COURT9', 'Court 9'),
       ('451', 'COURT5', 'Court 5'),
       ('415', 'ChkOut', 'PARTICIPANT CHECKED OUT'),
       ('451', 'COURT7', 'Court 7'),
       ('442', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('442', 'Navail', 'Not Available'),
       ('435', 'COURT5', 'Court 5'),
       ('451', 'CT10', 'Court 10'),
       ('457', 'Court ', 'COURT ROOM'),
       ('415', 'Navail', 'Not Available'),
       ('435', 'COURT8', 'Court 8'),
       ('415', 'Asmbly', 'JURY ASSEMBLY ROOM'),
       ('435', 'COURT2', 'Court 2');
commit;