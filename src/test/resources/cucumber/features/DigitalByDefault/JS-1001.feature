Feature: DBD Information Cards

  @JurorTransformationMulti
  Scenario Outline: JS-1000 DBD - Where and when to attend Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "When and where to attend" on the page

    When I click on the "When and where to attend" link
    Then I see "Your start date, court address, arrival time and security information." on the page
    And I see "You are summoned to start jury service on" on the page
    And I validate the attendance date is "5" weeks in the future
    And I see "at" on the page
    And I see "The Crown Court At Lewes" on the page
    And I see "The Law Courts" on the page
    And I see "182 High Street" on the page
    And I see "Lewes" on the page
    And I see "East Sussex" on the page
    And I see "BN7 1YB" on the page
    And I see "You should allow extra time to go through security at court." on the page
    And I see "Information on this and what you can and can't take it can be found here: www.gov.uk/entering-court-or-tribunal-building" on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "ATTENDINFO" on the page

    When I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	  | postcode	| pool_number  | environment   |
      | 043100116		| ATTENDINFO  | CH1 2AN		| 431309160    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: JS-1001 DBD - Juror Service Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    Then I see "How jury service works" on the page

    When I click on the "How jury service works" link
    Then I see "What jury service is and who can be called" on the page
    And I see "What is jury service?" on the page
    And I see "Jury service is an important public duty. You and usually 11 other people will form a jury. Together, you'll decide the result of a criminal trial in the Crown court." on the page
    And I see "Who can be called for jury service?" on the page
    And I see "Every adult aged 18 to 75 years that lives in the UK can be picked at random for jury service from the electoral roll." on the page
    And I see "If you are going to be under 18 or over 76 on the first day of your jury service, you will be unable to serve but you must still reply to your summons." on the page
    And I see "There is more information at www.gov.uk/jury-service" on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "SERVICEINFO" on the page

    When I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	  | postcode	| pool_number  | environment   |
      | 043100110		| SERVICEINFO | CH1 2AN		| 431309165    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: JS-1002 DBD - Support and Accessibility Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "Support and accessibility" on the page

    When I click on the "Support and accessibility" link
    Then I see "Support and accessibility" on the page
    And I see "If you have a disability and need us to make reasonable adjustments to help you during your jury service, you can tell us as part of your response." on the page
    And I see "For more information, please visit www.gov.uk/jury-service/request-reasonable-adjustments" on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "ACCESSIBILITYINFO" on the page

    When I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	        | postcode	| pool_number  | environment   |
      | 043100111		| ACCESSIBILITYINFO | CH1 2AN   | 431309166    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: JS-1003 DBD - Employment and time off work Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "Employment and time off work" on the page

    When I click on the "Employment and time off work" link
    Then I see "Employment and time off work" on the page
    And I see "Information for employees and self-employed jurors" on the page
    And I see "Your employer has to let you do jury service – it's the law, but they can ask you to apply to change the dates to a more convenient time (you can only do this once). See the information about asking to change your dates or be excused, or check www.gov.uk/jury-service/delaying-or-being-excused-from-jury-service for more details." on the page
    And I see "Your employer can choose whether or not to pay you during your service. If they do not pay you, you can claim for loss of earnings from the court, subject to a daily maximum. If you are self-employed, you have the right to claim the same allowances as if you were an employee." on the page
    And I see "Check the information in the 'claiming expenses' section or at www.gov.uk/jury-service for more details." on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "EMPLOYMENTINFO" on the page

    When I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	     | postcode	| pool_number  | environment   |
      | 043100112		| EMPLOYMENTINFO | CH1 2AN  | 431309167    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: JS-1004 DBD - Claiming expenses Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "Claiming expenses" on the page

    When I click on the "Claiming expenses" link
    Then I see "You do not get paid for doing jury service but you can claim some money back towards loss of earnings, childcare, travel, and food and drink costs." on the page
    And I see "The rates are set out on www.gov.uk/jury-service and there's also a calculator to help you work out what you may be able to claim from the court: www.gov.uk/check-juror-claims" on the page

    When I click on the "Loss of earnings and extra childcare or care costs" link
    Then  I see "We can reimburse you a single maximum daily amount to cover both:" on the page
    And I see "Loss of earnings" on the page
    And I see "Additional care costs due to jury service" on the page

#    When I click on the "Loss of earnings" link
#    Then I see "You can claim for loss of earnings if you’re either:" on the page
#    And I see "employed and your employer will not pay you during jury service" on the page
#    And I see "self-employed or a paid company director" on the page
#    And I see "The maximum rates you can claim are shown on www.gov.uk/jury-service. You cannot claim more if your full pay is higher than these rates." on the page
#    And I see "If you work part time you can only claim for days you normally work, even if you spend a full week in court. For example, if you normally work 3 days a week, you can only claim loss of earnings for those 3 days, as you’ve not lost earnings on the other 2 days." on the page
#    And I see "You cannot claim for weekends or bank holidays because the court is closed." on the page

    When I click on the "Childcare or care costs" link
    Then I see "You cannot claim for care costs you normally have, for example as part of your usual working week. But if you'll have additional care costs that are only due to jury service, you can claim some money towards these." on the page
    And I see "You must be within the combined maximum daily allowance for loss of earnings and caring costs." on the page
    And I see "For example, if you're claiming £64.95 for extra care costs, you'll have used up all this allowance and cannot claim any more on top for loss of earnings." on the page

    When I click on the "If you claim benefits" link
    Then I see "Your benefits will not be affected for at least 8 weeks, as long as you tell your benefits officer or work coach about your jury service. If you're asked to serve on a longer trial, when you arrive at court, you'll need to speak with the jury manager to find out how your benefits will be affected." on the page

    When I click on the "Travel costs" link
    Then I see "How much you can claim depends on how you travel to court. You cannot claim any travel or accommodation expenses from abroad. Information on how much you can claim is available from www.gov.uk/jury-service" on the page
    And I see "You must check with your jury manager at the court that you can claim for parking before you pay for it." on the page

    When I click on the "Travel tickets" link
    Then I see "Only buy daily travel tickets unless the court tells you otherwise when you start jury service." on the page
    And I see "Keep copies of your tickets or receipts, to submit with your claim. If you do not keep these, we may not be able to pay you back." on the page

    When I click on the "Food and drink costs" link
    Then I see "You can claim these amounts even if you bring your own food and drink. The rates are set out on www.gov.uk/jury-service" on the page

    When I click on the "When to claim" link
    Then I see "Submit your claim at the end of jury service. You'll usually be paid 7 to 10 working days after submitting your claim form. The court may be able to pay your expenses during the trial if it's likely to last a long time or if you're facing financial hardship. Check with the jury manager at your court when you start." on the page

    When I click on the "If you have questions" link
    Then I see "Up to a week before jury service starts please contact:" on the page
    And I see "Jury Central Summoning Bureau" on the page
    And I see "jurysummoning@justice.gov.uk" on the page
    And I see "Telephone: 0300 456 1024" on the page
    And I see "Monday to Thursday 9am to 5pm" on the page
    And I see "Friday 9am to 3pm" on the page
    And I see link with text "Find out about call charges"
    And I see "In the week before jury service and any point after that, contact the court where you'll be doing jury service. You'll be sent contact details nearer the time." on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "EXPENSEINFO" on the page

    And I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	  | postcode  | pool_number  | environment   |
      | 043100115		| EXPENSEINFO | CH1 2AN   | 431309170    | ithc          |


  @JurorTransformationMulti
  Scenario Outline: JS-1005 DBD - Ask to change your dates Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "Asking to change your dates or be excused" on the page

    When I click on the "Asking to change your dates or be excused" link
    And I see "When you respond to your summons, you can ask to change your dates or to be excused from your jury service." on the page
    And I see "You can only change the dates of your service once and you'll need to give us a reason. You will be asked to provide some alternative dates within 12 months when you could serve." on the page
    And I see "Excusals are only granted in exceptional circumstances when you cannot serve at any time in the following 12 months. You may be asked to provide evidence, but you won't need to include this when you respond; we'll contact you and give you time to gather anything we need." on the page
    And I see "If you need more information, please see www.gov.uk/jury-service/delaying-or-being-excused-from-jury-service" on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "DATESINFO" on the page

    And I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	| postcode	| pool_number  | environment   |
      | 043100113		| DATESINFO | CH1 2AN   | 431309168    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: JS-1008 DBD - Eligibility Info

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "Juror eligibility" on the page

    When I click on the "Juror eligibility" link
    And I see "Who is eligible to serve on a jury?" on the page
    And I see "As part of your response, you'll be asked questions to help us decide whether you can do jury service." on the page
    And I see "You qualify for jury service if" on the page
    And I see "you will be at least 18 years old, and under 76 years old, on the day that you start your jury service" on the page
    And I see "you are registered as a parliamentary or local government elector" on the page
    And I see "you have lived in the United Kingdom, the Channel Islands or the Isle of Man for any period of at least five years since you were 13 years old" on the page
    And I see "If any of the following applies to you, you do not qualify for jury service:" on the page

    And I see "Mental disorders" on the page
    And I see "Under the Mental Health Act 1983, some people can not do Jury Service." on the page
    And I see "If you are detained (this is sometimes called being 'sectioned'), in hospital, under a guardianship order or under a community treatment order because of a mental disorder, you can not be on a jury." on the page
    And I see "If you suffer from a mental disorder (including depression and anxiety) but you are not being detained, looked after or treated under the Mental Health Act, you can still be on a jury" on the page

    And I see "Mental capacity" on the page
    And I see "If you lack the mental capacity to serve as a juror, you can not be on a jury." on the page
    And I see "Mental capacity means being able to make a decision for yourself." on the page
    And I see "People who cannot do this are said to lack capacity under the Mental Capacity Act 2005" on the page
    And I see "The lack of capacity must be because of an impairment of or disturbance in the functioning of the mind or brain which may be due to illness, injury, learning disability, or mental health problems." on the page
    And I see "To be on a jury, a person must be able to:" on the page
    And I see "Understand the information that relates to the decision they want to make." on the page
    And I see "Remember the information long enough to be able to make the decision." on the page
    And I see "Weigh up the information available to make the decision." on the page
    And I see "Communicate the decision by any means." on the page
    And I see "If you are not sure if you can do Jury Service because of a mental disorder or lack of mental capacity, you can phone us on 0300 456 1024 for advice." on the page

    And I see "Bail" on the page
    And I see "If you are on bail in criminal proceedings, you can not do Jury Service." on the page

    And I see "Convictions" on the page
    And I see "You can do Jury Service if you have points on your driving licence, speeding fines or have been to a speed awareness course, as long as you have not received any of the sentences below." on the page
    And I see "You can not do Jury Service if you have ever had one of these criminal sentences in the United Kingdom, the Channel Islands or the Isle of Man. You also can not do jury service if you've had one of these criminal sentences for a service offence under the Armed Forces Act 2006 anywhere in the world." on the page
    And I see "to imprisonment for life, detention for life or custody for life," on the page
    And I see "to detention during his Majesty’s pleasure or during the pleasure of the Secretary of State," on the page
    And I see "to imprisonment for public protection or detention for public protection," on the page
    And I see "to an extended sentence under section 226A, 226B, 227 or 228 of the Criminal Justice Act 2003 or section 254, 266 or 279 of the Sentencing Act 2020 (including such a sentence imposed as a result of section 219A, 220, 221A or 222 of the Armed Forces Act 2006) or section 210A of the Criminal Procedure (Scotland) Act 1995," on the page
    And I see "to a term of imprisonment of five years or more or a term of detention of five years or more." on the page
    And I see "Also, you can not do Jury Service if you have had one of these criminal sentences in the last 10 years:" on the page
    And I see "served any part of a sentence of imprisonment or detention" on the page
    And I see "received a suspended sentence of imprisonment or a suspended order for detention" on the page
    And I see "You can not do jury service if in the last 10 years in England and Wales you have had a community order (including a community rehabilitation order, community punishment order, community punishment and rehabilitation order, drug treatment and testing order, or a drug abstinence order)." on the page
    And I see "You can not do jury service if in the last 10 years you have had any similar order under the law of Scotland, Northern Ireland, Isle of Man, any of the Channel Islands, or a community or overseas community order under the Armed Forces Act 2006." on the page

    When I press the "Start your response" button
    And I see "Is the name we have for you correct?" on the page
    And I see "ELIGIBILITYINFO" on the page

    And I click on the "Back" link
    Then I see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	      | postcode  | pool_number  | environment   |
      | 043100114		| ELIGIBILITYINFO | CH1 2AN   | 431309169    | ithc          |

  @JurorTransformationMulti
  Scenario Outline: Cannot access info cards after submitting a response

    Given I am on "Public" "<environment>"

    Given a bureau owned pool is created with jurors
      | court |juror_number   | pool_number	    | att_date_weeks_in_future	| owner |
      | 431   |<juror_number1>| <pool_number>	| 5				            | 400	|

    Given I update "<juror_number1>" to set them up for digital by default
    Given juror "<juror_number1>" has "LAST_NAME" as "<last_name>" new schema
    Given juror "<juror_number1>" has "POSTCODE" as "<postcode>" new schema

    When I have submitted a first party English straight through response
      | part_no			 | pool_number  | last_name	 | postcode	| email  |
      | <juror_number1>	 | <pool_number>| <last_name>|<postcode>| <email>|

    Given I am on "Public" "<environment>"

    And I see "Reply to a jury summons" on the page
    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button

    When I set "9-digit juror number" to "<juror_number1>"
    And I set "Juror last name" to "<last_name>"
    And I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    And I see "already replied" on the page
    And I do not see "Your jury summons information is online" on the page

    Examples:
      | juror_number1	| last_name	| postcode  | pool_number  | environment   | email                |
      | 043100119		| CHECKINFO | CH1 2AN   | 431309161    | ithc          | CHECKINFO@email.com  |