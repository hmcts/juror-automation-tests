Feature: JM-252_Validation_and_Errors

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Create New Pool - Continue With No Input
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #enter a pool request

    When I navigate to the pool request screen
    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"
    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    And I see the attendance date of the pool

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 150                           |

    When I save the new pool request

    #Can see the pool request courts table tabs and fields

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #check error on continue with no input

    When I press the "Continue" button
    Then I see "Enter the name or location code for a court" on the page
    And I see "Court name or location is missing" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | Crown        | Crown court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | Civil        | Civil court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | High         | High court      | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Create New Pool - Continue With Invalid loc_code
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #enter a pool request

    When I navigate to the pool request screen
    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"
    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    And I see the attendance date of the pool

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 150                           |

    When I save the new pool request

    #Can see the pool request courts table tabs and fields

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #check error on continue with invalid loc_code

    Then I set input field with "ID" of "courtNameOrLocation" to "1234"
    When I press the "Continue" button
    Then I see "Please check the court name or location" on the page
    And I see "This court does not exist. Please enter a name or code of an existing court" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | Crown        | Crown court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | Civil        | Civil court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | High         | High court      | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Create New Pool - Continue With Invalid Court Name
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #enter a pool request

    When I navigate to the pool request screen
    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"
    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    And I see the attendance date of the pool

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 150                           |

    When I save the new pool request

    #Can see the pool request courts table tabs and fields

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #check error on continue with invalid court name

    Then I set input field with "ID" of "courtNameOrLocation" to "the moon"
    When I press the "Continue" button
    Then I see "Please check the court name or location" on the page
    And I see "This court does not exist. Please enter a name or code of an existing court" on the page

    Examples:
      | user	        |  selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | Crown        | Crown court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | Civil        | Civil court     | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | High         | High court      | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Number Of Deferrals - Continue With No Input
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I set the radio button to "<courtType>"

    #check page content
    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #change number of deferrals
    When I click the change link for the court deferrals

    #error on continue with no input
    Then I set "Number of deferred jurors to include in this pool" to ""
    When I press the "Continue" button
    Then I see "Number of deferrals is missing" on the page


    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | 457       | 045700001     | 457300001   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | 457       | 045700001     | 457300001   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | 457       | 045700001     | 457300001   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Number Of Deferrals - Continue An Invalid Input
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no       | part_no         | no_weeks|
      |<courtCode> | <pool_number> | <juror_number>  | 9       |

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I set the radio button to "<courtType>"

    #check page content
    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #change number of deferrals
    When I click the change link for the court deferrals

    #error on continue with invalid input
    When I set "Number of deferred jurors to include in this pool" to "-1"
    When I press the "Continue" button
    Then I see "Number of deferrals cannot be negative" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | 457       | 045700002     | 457300002   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | 457       | 045700002     | 457300002   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | 457       | 045700002     | 457300002   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Number Of Deferrals - Number > Number of Defs Available
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I set the radio button to "<courtType>"

    #check page content
    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #change number of deferrals
    When I click the change link for the court deferrals

    #error when number > number of defs available
    When I set "Number of deferred jurors to include in this pool" to "10000"
    When I press the "Continue" button
    Then I see "Number of deferrals is too high" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode | juror_number| pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | 457       | 045700003   | 457300003   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | 457       | 045700003   | 457300003   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | 457       | 045700003   | 457300003   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Number Of Deferrals - Zero Deferrals
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I set the radio button to "<courtType>"

    #check page content
    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #change number of deferrals
    When I click the change link for the court deferrals

    #insert new pool
    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no      | part_no         | no_weeks|
      |<courtCode> | <pool_number>| <juror_number>  | 9       |

    #select 0 deferrals
    When I set "Number of deferred jurors to include in this pool" to "0"
    When I press the "Continue" button

    Then I do not see "Number of deferrals is missing" on the page
    Then I do not see "Number of deferrals cannot be negative" on the page
    Then I do not see "Number of deferrals is too high" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode | juror_number | pool_number  |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | 457       | 045700004    | 457300004    |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | 457       | 045700004    | 457300004    |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | 457       | 045700004    | 457300004    |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Number Of Deferrals - One Deferral
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button
    Then I set the radio button to "<courtType>"

    #check page content
    And on the page I see
      | text|
      |Request a new pool|
      |Court name or location code|
      |<displayCourt>             |
      |Attendance date            |
      |Pool type                  |
      |Crown court                |
      |High court                 |
      |Civil court                |
      |Number of jurors required in total|
      |Number of court deferrals to include in this pool|

    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page

    #go back and select 1 deferral
    When I click the change link for the court deferrals
    When I set "Number of deferred jurors to include in this pool" to "1"
    When I press the "Continue" button
    Then I do not see "Number of deferrals is missing" on the page
    Then I do not see "Number of deferrals cannot be negative" on the page
    Then I do not see "Number of deferrals is too high" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | 457       | 045700005     | 457300005   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | 457       | 045700005     | 457300005   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | 457       | 045700005     | 457300005   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Continue - No Selections
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #error on Continue with no selections made
    When I press the "Continue" button
    Then I see "Pool type is missing" on the page
    And I see "Select a pool type" on the page
    And I see "Number of jurors required is missing" on the page
    And I see "Enter the number of jurors required" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Continue - Only Number of Jurors
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page
    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #error on Continue with only number of jurors entered
    Then I set "Number of jurors required in total" to "150"
    When I press the "Continue" button
    Then I see "Pool type is missing" on the page
    And I see "Select a pool type" on the page
    And I do not see "Number of jurors required is missing" on the page
    And I do not see "Enter the number of jurors required" on the page
    Examples:
      | user	        | selectedCourt    | displayCourt     | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Continue - Only Pool Type Set
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page
    #select court

    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #error on Continue with only pool type set
    Then I set "Number of jurors required in total" to ""
    And I set the radio button to "<courtType>"
    When I press the "Continue" button
    Then I do not see "Pool type is missing" on the page
    And I do not see "Select a pool type" on the page
    And I see "Number of jurors required is missing" on the page
    And I see "Enter the number of jurors required" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | Crown        | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | Civil        | 415       |
      | MODTESTBUREAU	| CHESTER          | Chester          | High         | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Continue - Complete New Pool Fields
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #change number of deferrals
    When I click the change link for the court deferrals
    When I set "Number of deferred jurors to include in this pool" to "1"
    When I press the "Continue" button
    Then I do not see "Number of deferrals is missing" on the page
    Then I do not see "Number of deferrals cannot be negative" on the page
    Then I do not see "Number of deferrals is too high" on the page

    Then I set "Number of jurors required in total" to "150"
    And I set the radio button to "<courtType>"

    Then I press the "Continue" button
    And I do not see "Pool type is missing" on the page
    And I do not see "Select a pool type" on the page
    And I do not see "Number of jurors required is missing" on the page
    And I do not see "Enter the number of jurors required" on the page

    #check pool request
    Then I see "Check your pool request" on the page
    And I see the attendance date of the pool
    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 149                           |

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700006     | 457300006   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700006     | 457300006   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700006     | 457300006   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - No Pool Number
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no       | part_no         | no_weeks|
      |<courtCode> | <pool_number> | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 149                           |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see "Please enter a pool number" on the page

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700007     | 457300007   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700007     | 457300007   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700007     | 457300007   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Pool Number Does Not Contain Court Location Code
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 149                           |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I set "Pool number" to "999999999"
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number must use court location code"

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700008     | 457300008   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700008     | 457300008   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700008     | 457300008   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Pool Number Does Not Contain Months Of Attendance Date
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no       | part_no         | no_weeks|
      |<courtCode> | <pool_number> | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 150                           |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 149                           |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I set "Pool number" to "457240000"
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number must use month of attendance date"

    Then I set "Pool number" to "457500000"
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number must use year of attendance date"

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700009     | 457300009   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700009     | 457300009   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700009     | 457300009   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Pool Number Too Long
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no        | part_no         | no_weeks|
      |<courtCode> | <pool_number>  | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "50"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 50                            |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 49                            |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I set "Pool number" to "45723060100"
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number must have a maximum of 9 characters"

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700010     | 457300010   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700010     | 457300010   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700010     | 457300010   |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Pool Number Too Short
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no      | part_no         | no_weeks|
      |<courtCode> | <pool_number>| <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "50"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 50                            |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 49                            |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I set "Pool number" to "45723060"
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number must have a minimum of 9 characters"

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700011     | 457300011   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700011     | 457300011   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700011     | 457300011   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Pool Number Already in Use
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court         |juror_number  	    | pool_number	    | att_date_weeks_in_future	| owner |
      | <courtCode>   |<juror_number> 	    | <pool_number>     | 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      |owner       | pool_no       | part_no         | no_weeks|
      |<courtCode> | <pool_number> | <juror_number>  | 9       |

    #create a pool so there is always one there for this court/year/month
    When I navigate to the pool request screen
    And I create a "<courtType>" court pool request for court "<courtCode>", "9" weeks in the future

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "50"
    Then I press the "Continue" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 50                            |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 49                            |

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page
    Then I input a pool number that is already being used
    Then I press the "Change" button

    Then I see "Pool number is wrong" on the page
    And I see error "Pool number is already being used"

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 045700012     | 457300012   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 045700012     | 457300012   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 045700012     | 457300012   |

  @JurorTransformation @NewSchemaConverted
  Scenario Outline: Errors and Warnings on Change Pool Number - Valid Pool Number
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 457	  |<juror_number>| <pool_number>| 5				            | 400	|

    #insert new pool
    Given a deferral is inserted for an existing juror new schema
      | owner| pool_no        | part_no        | no_weeks|
      | 457  | <pool_number> | <juror_number>  | 9       |

    #Can see the pool request courts table tabs and fields
    When I navigate to the pool request screen

    #create a pool here so that there is always at least 1 for this court/year/month - required for later step
    And I create a "Crown" court pool request for court "457", "9" weeks in the future

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "1"

    Then I set the radio button to "<courtType>"
    And I set "Number of jurors required in total" to "50"
    Then I press the "Continue" button

    #Change pool no
    Then I click the change link for the pool number
    And I see "Change pool number" on the page

    Then I insert a valid pool number for court "457"
    Then I press the "Change" button

    #check pool request
    And I see the attendance date of the pool
    And I do not see "Attendance time" on the page
    Then I see "Check your pool request" on the page

    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | additionalRequirements | None                          |
      | totalJurorsRequired    | 50                            |
      | numberOfDeferrals      | 1                             |
      | additionalJurors       | 49                            |

    #Request Pool
    And I submit the pool request

    And I should see the newly created pool request
      | court          | <displayCourt> |
      | jurorsRequired | 49             |

    And the pool created in this test is deleted new schema

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtType    | courtTypeFull   | courtCode | juror_number  | pool_number   |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Crown        | Crown court     | 457       | 041500047     | 415300130     |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | Civil        | Civil court     | 457       | 041500047     | 415300130     |
      | MODTESTBUREAU	| SWANSEA          | Swansea Crown Court          | High         | High court      | 457       | 041500047     | 415300130     |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to assure that a warning appears if the attendance date is set to a weekend date
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen
    When I click the link to the new pool screen
    And I set the radio button to "Request new pool"
    And I press the "Continue" button

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    When I click the change link for the attendance date
    And I set the attendance date to a weekend
    Then I should see a warning stating I have selected a weekend
    When I click the link to continue from the warning page

    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    When I change the pool type to "Civil"

    And I set the number of jurors to "10"
    And I press the "Continue" button
    Then I should see a warning stating I have selected a weekend
    When I click the link to continue from the warning page
    Then I should be taken to the check pool request page
    And I should see the details of the pool
      | courtName              | <displayCourt> (<courtCode>)  |
      | poolType               | <courtTypeFull>               |
      | totalJurorsRequired    | 10                            |
      | numberOfDeferrals      | 0                             |
      | additionalJurors       | 10                            |

    Examples:
      | user	        | selectedCourt    | displayCourt     | courtTypeFull   | courtCode |
      | MODTESTBUREAU	| CHESTER          | Chester          | Civil court     | 415       |

  @JurorTransformationMulti @NewSchemaConverted
  Scenario Outline: Test to assure that a warning appears if the attendance date is set to a bank holiday date
    Given I am on "Bureau" "test"

    And I log in as "<user>"

    When I navigate to the pool request screen

    When I press the "Create pool" button
    And I set the radio button to "Request new pool"
    And I press the "Continue" button
    Then I see "Select a court for this pool" on the page

    #select court
    Then I set input field with "ID" of "courtNameOrLocation" to "<selectedCourt>"
    Then I click on the "<displayCourt> (<courtCode>)" link
    Then I press the "Continue" button

    When I click the change link for the attendance date

    And I create a bank holiday "6" weeks in the future for court/bureau "<courtCode>" new schema

    When I set the "Change the attendance date for this pool" date to a Monday "6" weeks in the future

    And I press the "Change" button

    Then I should see a warning stating I have selected a bank holiday

    When I click the link to continue from the warning page

    Then I see "Request a new pool" on the page

    #complete new pool fields
    Then I click the change link for the court deferrals
    Then I change the number of court deferrals to "0"

    Then I set the radio button to "<courtTypeFull>"
    And I set "Number of jurors required in total" to "150"
    Then I press the "Continue" button

    Then I should see a warning stating I have selected a bank holiday

    When I click the link to continue from the warning page

    #check pool request
    Then I see "Check your pool request" on the page

    And I should see the details of the pool with a bank holiday date
      | courtName              | <displayCourt> (<courtCode>) |
      | poolType               | <courtTypeFull>              |
      | totalJurorsRequired    | 150                          |
      | numberOfDeferrals      | 0                            |
      | additionalJurors       | 150                          |

    # Can submit the new pool request
    When I save the new pool request
    Then I should be taken to the pool summary page

    And I should see the newly created pool request
      | court          | <displayCourt>  |
      | jurorsRequired | 150             |

    Then I delete bank holiday new schema

    Examples:
      | user          | selectedCourt | courtCode | displayCourt | courtTypeFull |
      | MODTESTBUREAU | COVENTRY      | 417       | Coventry     | Crown court   |

