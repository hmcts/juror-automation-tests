Feature: Data for Andy

  Scenario: Data for Andy

    Given I am on "Bureau" "demo"

    Given a bureau owned pool is created with jurors
      | court |juror_number | pool_number| att_date_weeks_in_future	    | owner |
      | 415   |041525101    | 415251101  | 10				            | 400	|
      | 415   |041525102    | 415251101  | 10				            | 400	|
      | 415   |041525103    | 415251101  | 10				            | 400	|
      | 415   |041525104    | 415251101  | 10				            | 400	|
      | 415   |041525105    | 415251101  | 10				            | 400	|
      | 415   |041525106    | 415251101  | 10				            | 400	|
      | 415   |041525107    | 415251101  | 10				            | 400	|
      | 415   |041525108    | 415251101  | 10				            | 400	|
      | 415   |041525109    | 415251101  | 10				            | 400	|
      | 415   |041525110    | 415251101  | 10				            | 400	|
      | 415   |041525111    | 415251101  | 10				            | 400	|
      | 415   |041525112    | 415251101  | 10				            | 400	|
      | 415   |041525113    | 415251101  | 10				            | 400	|
      | 415   |041525114    | 415251101  | 10				            | 400	|
      | 415   |041525115    | 415251101  | 10				            | 400	|
      | 415   |041525116    | 415251101  | 10				            | 400	|
      | 415   |041525117    | 415251101  | 10				            | 400	|
      | 415   |041525118    | 415251101  | 10				            | 400	|
      | 415   |041525119    | 415251101  | 10				            | 400	|
      | 415   |041525120    | 415251101  | 10				            | 400	|


  And juror "041525101" has "FIRST_NAME" as "JOHN" new schema
  And juror "041525101" has "LAST_NAME" as "JONES" new schema

  And juror "041525102" has "FIRST_NAME" as "SARAH" new schema
  And juror "041525102" has "LAST_NAME" as "SUMMERS" new schema

  And juror "041525103" has "FIRST_NAME" as "ASHA" new schema
  And juror "041525103" has "LAST_NAME" as "AKANI" new schema

  And juror "041525104" has "FIRST_NAME" as "HARRIET" new schema
  And juror "041525104" has "LAST_NAME" as "HOLMES" new schema

  And juror "041525105" has "FIRST_NAME" as "KADE" new schema
  And juror "041525105" has "LAST_NAME" as "KNIGHT" new schema

  And juror "041525106" has "FIRST_NAME" as "LANDON" new schema
  And juror "041525106" has "LAST_NAME" as "LANDON" new schema

  And juror "041525107" has "FIRST_NAME" as "CARTER" new schema
  And juror "041525107" has "LAST_NAME" as "CRANE" new schema

  And juror "041525108" has "FIRST_NAME" as "MILO" new schema
  And juror "041525108" has "LAST_NAME" as "MORROW" new schema

  And juror "041525109" has "FIRST_NAME" as "PANKAJ" new schema
  And juror "041525109" has "LAST_NAME" as "PARMAR" new schema

  And juror "041525110" has "FIRST_NAME" as "VALERIE" new schema
  And juror "041525110" has "LAST_NAME" as "VANCE" new schema

  And juror "041525111" has "FIRST_NAME" as "TREY" new schema
  And juror "041525111" has "LAST_NAME" as "THOMAS" new schema

  And juror "041525112" has "FIRST_NAME" as "ETHAN" new schema
  And juror "041525112" has "LAST_NAME" as "ELMERS" new schema

  And juror "041525113" has "FIRST_NAME" as "DEAN" new schema
  And juror "041525113" has "LAST_NAME" as "DRURY" new schema

  And juror "041525114" has "FIRST_NAME" as "GORAN" new schema
  And juror "041525114" has "LAST_NAME" as "GARCIA" new schema

  And juror "041525115" has "FIRST_NAME" as "JAMIE" new schema
  And juror "041525115" has "LAST_NAME" as "JENSON" new schema

  And juror "041525116" has "FIRST_NAME" as "OLIVIA" new schema
  And juror "041525116" has "LAST_NAME" as "OBAN" new schema

  And juror "041525117" has "FIRST_NAME" as "RYAN" new schema
  And juror "041525117" has "LAST_NAME" as "REGIS" new schema

  And juror "041525118" has "FIRST_NAME" as "UMER" new schema
  And juror "041525118" has "LAST_NAME" as "UDDIN" new schema

  And juror "041525119" has "FIRST_NAME" as "FRANK" new schema
  And juror "041525119" has "LAST_NAME" as "FERRIER" new schema

  And juror "041525120" has "FIRST_NAME" as "YASMIN" new schema
  And juror "041525120" has "LAST_NAME" as "YOUNG" new schema
