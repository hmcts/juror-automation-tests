Feature: JS-742 Digital Responses Completed by User Report

  @JurorTransformation
  Scenario Outline: Digital Responses Completed by User Report

    Given I am on "Bureau" "test"

    Given paper responses are deleted new schema

    Given a bureau owned pool is created with jurors
      | court  | juror_number  	  | pool_number	     | att_date_weeks_in_future	| owner |
      | 415    | <juror_number1>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number2>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number3>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number4>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number5>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number6>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number7>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number8>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number9>  | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number10> | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number11> | <pool_number>    | 5				        | 400	|
      | 415    | <juror_number12> | <pool_number>    | 5				        | 400	|

#    #the following is to test volume, not required for nightly reg runs
##      | 415    | <juror_number20>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number21>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number22>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number23>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number24>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number25>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number26>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number27>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number28>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number29>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number30>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number31>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number32>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number33>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number34>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number35>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number36>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number37>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number38>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number39>  | <pool_number>    | 5				        | 400	|
##      | 415    | <juror_number40>  | <pool_number>    | 5				        | 400	|



    #DIGITAL completed by BUREAU USER (YES display in report) MODTESTBUREAU
    And a digital summons reply has been entered for the summoned juror "<juror_number1>" new schema
    And the "processing_status" for juror "<juror_number1>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number1>" is set to "today" new schema

    #DIGITAL completed by BUREAU USER (YES display in report) ARAMIS1
    And a digital summons reply has been entered for the summoned juror "<juror_number9>" new schema
    And the "processing_status" for juror "<juror_number9>" is set to "CLOSED" new schema
    And the "staff_login" for juror "<juror_number9>" is set to "ARAMIS1" new schema
    And the "completed_at" for juror "<juror_number9>" is set to "today" new schema

    #DIGITAL completed by BUREAU USER (YES display in report) CPASS
    And a digital summons reply has been entered for the summoned juror "<juror_number10>" new schema
    And the "processing_status" for juror "<juror_number10>" is set to "CLOSED" new schema
    And the "staff_login" for juror "<juror_number10>" is set to "CPASS" new schema
    And the "completed_at" for juror "<juror_number10>" is set to "today" new schema

    #DIGITAL completed by BUREAU USER (YES display in report) TeamPickListUser
    And a digital summons reply has been entered for the summoned juror "<juror_number11>" new schema
    And the "processing_status" for juror "<juror_number11>" is set to "CLOSED" new schema
    And the "staff_login" for juror "<juror_number11>" is set to "TeamPickListUser" new schema
    And the "completed_at" for juror "<juror_number11>" is set to "today" new schema

    #DIGITAL completed by BUREAU USER (YES display in report) NEWUSER1
    And a digital summons reply has been entered for the summoned juror "<juror_number12>" new schema
    And the "processing_status" for juror "<juror_number12>" is set to "CLOSED" new schema
    And the "staff_login" for juror "<juror_number12>" is set to "NEWUSER1" new schema
    And the "completed_at" for juror "<juror_number12>" is set to "today" new schema

    #DIGITAL completed by COURT USER (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number2>" new schema
    And the "processing_status" for juror "<juror_number2>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number2>" is set to "today" new schema
    And the "staff_login" for juror "<juror_number2>" is set to "MODTESTCOURT" new schema

    #PAPER completed by BUREAU USER (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number3>" new schema
    And the "processing_status" for juror "<juror_number3>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number3>" is set to "today" new schema
    And the "reply_type" for juror "<juror_number3>" is set to "Paper" new schema

    #PAPER completed by COURT USER (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number4>" new schema
    And the "processing_status" for juror "<juror_number4>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number4>" is set to "today" new schema
    And the "reply_type" for juror "<juror_number4>" is set to "Paper" new schema
    And the "staff_login" for juror "<juror_number4>" is set to "MODTESTCOURT" new schema

    #DIGITAL at TO DO status (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number5>" new schema

    #DIGITAL at AWAITING CONTACT status (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number6>" new schema
    And the "processing_status" for juror "<juror_number6>" is set to "AWAITING_CONTACT" new schema

    #DIGITAL completed by AUTO (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number7>" new schema
    And the "processing_status" for juror "<juror_number7>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number7>" is set to "today" new schema
    And the "staff_login" for juror "<juror_number7>" is set to "AUTO" new schema

    #DIGITAL completed not in this month (NO display in report)
    And a digital summons reply has been entered for the summoned juror "<juror_number8>" new schema
    And the "processing_status" for juror "<juror_number8>" is set to "CLOSED" new schema
    And the "completed_at" for juror "<juror_number8>" is set to "-90 mondays time" new schema

    #######the following is to test volume, not required for nightly reg runs
    #DIGITAL completed by BUREAU USER (YES display in report) CPASS20
#    And a digital summons reply has been entered for the summoned juror "<juror_number20>" new schema
#    And the "processing_status" for juror "<juror_number20>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number20>" is set to "CPASS1" new schema
#    And the "completed_at" for juror "<juror_number20>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS2
#    And a digital summons reply has been entered for the summoned juror "<juror_number21>" new schema
#    And the "processing_status" for juror "<juror_number21>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number21>" is set to "CPASS2" new schema
#    And the "completed_at" for juror "<juror_number21>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS3
#    And a digital summons reply has been entered for the summoned juror "<juror_number22>" new schema
#    And the "processing_status" for juror "<juror_number22>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number22>" is set to "CPASS3" new schema
#    And the "completed_at" for juror "<juror_number22>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS4
#    And a digital summons reply has been entered for the summoned juror "<juror_number23>" new schema
#    And the "processing_status" for juror "<juror_number23>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number23>" is set to "CPASS4" new schema
#    And the "completed_at" for juror "<juror_number23>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS5
#    And a digital summons reply has been entered for the summoned juror "<juror_number24>" new schema
#    And the "processing_status" for juror "<juror_number24>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number24>" is set to "CPASS5" new schema
#    And the "completed_at" for juror "<juror_number24>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS6
#    And a digital summons reply has been entered for the summoned juror "<juror_number25>" new schema
#    And the "processing_status" for juror "<juror_number25>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number25>" is set to "CPASS6" new schema
#    And the "completed_at" for juror "<juror_number25>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS7
#    And a digital summons reply has been entered for the summoned juror "<juror_number26>" new schema
#    And the "processing_status" for juror "<juror_number26>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number26>" is set to "CPASS7" new schema
#    And the "completed_at" for juror "<juror_number26>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS8
#    And a digital summons reply has been entered for the summoned juror "<juror_number27>" new schema
#    And the "processing_status" for juror "<juror_number27>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number27>" is set to "CPASS8" new schema
#    And the "completed_at" for juror "<juror_number27>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS9
#    And a digital summons reply has been entered for the summoned juror "<juror_number28>" new schema
#    And the "processing_status" for juror "<juror_number28>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number28>" is set to "CPASS9" new schema
#    And the "completed_at" for juror "<juror_number28>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS10
#    And a digital summons reply has been entered for the summoned juror "<juror_number29>" new schema
#    And the "processing_status" for juror "<juror_number29>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number29>" is set to "CPASS10" new schema
#    And the "completed_at" for juror "<juror_number29>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS11
#    And a digital summons reply has been entered for the summoned juror "<juror_number30>" new schema
#    And the "processing_status" for juror "<juror_number30>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number30>" is set to "CPASS11" new schema
#    And the "completed_at" for juror "<juror_number30>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS12
#    And a digital summons reply has been entered for the summoned juror "<juror_number31>" new schema
#    And the "processing_status" for juror "<juror_number31>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number31>" is set to "CPASS12" new schema
#    And the "completed_at" for juror "<juror_number31>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS13
#    And a digital summons reply has been entered for the summoned juror "<juror_number32>" new schema
#    And the "processing_status" for juror "<juror_number32>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number32>" is set to "CPASS13" new schema
#    And the "completed_at" for juror "<juror_number32>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS14
#    And a digital summons reply has been entered for the summoned juror "<juror_number33>" new schema
#    And the "processing_status" for juror "<juror_number33>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number33>" is set to "CPASS14" new schema
#    And the "completed_at" for juror "<juror_number33>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS15
#    And a digital summons reply has been entered for the summoned juror "<juror_number34>" new schema
#    And the "processing_status" for juror "<juror_number34>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number34>" is set to "CPASS15" new schema
#    And the "completed_at" for juror "<juror_number34>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS16
#    And a digital summons reply has been entered for the summoned juror "<juror_number35>" new schema
#    And the "processing_status" for juror "<juror_number35>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number35>" is set to "CPASS16" new schema
#    And the "completed_at" for juror "<juror_number35>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS17
#    And a digital summons reply has been entered for the summoned juror "<juror_number36>" new schema
#    And the "processing_status" for juror "<juror_number36>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number36>" is set to "CPASS17" new schema
#    And the "completed_at" for juror "<juror_number36>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS18
#    And a digital summons reply has been entered for the summoned juror "<juror_number37>" new schema
#    And the "processing_status" for juror "<juror_number37>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number37>" is set to "CPASS18" new schema
#    And the "completed_at" for juror "<juror_number37>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS19
#    And a digital summons reply has been entered for the summoned juror "<juror_number38>" new schema
#    And the "processing_status" for juror "<juror_number38>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number38>" is set to "CPASS19" new schema
#    And the "completed_at" for juror "<juror_number38>" is set to "today" new schema
#    #DIGITAL completed by BUREAU USER (YES display in report) CPASS20
#    And a digital summons reply has been entered for the summoned juror "<juror_number39>" new schema
#    And the "processing_status" for juror "<juror_number39>" is set to "CLOSED" new schema
#    And the "staff_login" for juror "<juror_number39>" is set to "CPASS20" new schema
#    And the "completed_at" for juror "<juror_number39>" is set to "today" new schema

    When I log in as "<user>"
    And I press the "Apps" button
    And I click on the "Reporting" link
    And I click on the "Digital responses completed" link
    And I press the "Continue" button

    Then I see "1" in the same row as "Modtestbureau"
    Then I see "1" in the same row as "Aramis1"
    Then I see "1" in the same row as "Cpass"
    Then I see "1" in the same row as "Teampicklistuser"
    Then I see "1" in the same row as "Updated New"
    Then I see "5" in the same row as "Total"
    Then the total number of Digital responses completed in the selected month is "5"

    When I press the "Print" button
    And I focus page to the new tab
    Then I see "/print" in the URL

    And I focus page to the original tab
    And I press the "Export data" button
    #cannot validate the export

    Examples:
      | user          | juror_number1  | juror_number2  | juror_number3 | juror_number4 | juror_number5 | juror_number6 | juror_number7 | juror_number8 | juror_number9 | juror_number10 | juror_number20 | juror_number21  | juror_number22 | juror_number23 | juror_number24 | juror_number25 | juror_number26 | juror_number27 | juror_number28 | juror_number29 | juror_number30  | juror_number31  | juror_number32 | juror_number33 | juror_number34 | juror_number35 | juror_number36 | juror_number37 | juror_number38 | juror_number39 | juror_number40 | juror_number11 | juror_number12 | pool_number   |
      | MODTESTBUREAU | 041531091      | 041531092      | 041531093     | 041531094     | 041531095     | 041531096     | 041531097     | 041531098     | 041531099     | 041531100      | 041531020      | 041531021       | 041531022      | 041531023      | 041531024      | 041531025      | 041531026      | 041531027      | 041531028      | 041531029      | 041531030       | 041531031       | 041531032      | 041531033      | 041531034      | 041531035      | 041531036      | 041531037      | 041531038      | 041531039      | 041531040      | 041531101      | 041531102      | 415304679     |
