Feature: 1st Party Welsh Logon

@RegressionWelsh @NewSchemaConverted
Scenario: 1st Party Welsh Logon

	Given I am on the welsh version of "Public" "test"
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	Then I see "Eich manylion rheithiwr" on the page
	
	And I set "Rhif rheithiwr – 9 digid" to "testData"
	And I set "Cyfenw'r Rheithiwr" to "testData"
	And I set "Cod post Rheithiwr" to "testData"
	
	When I click on the "Nid oes gennyf rif rheithiwr" link
	Then I see "Os nad oes gennych rif rheithiwr, cysylltwch â:" on the page
	And I do not see "::" on the page
	And I do not see ": :" on the page
	And I see "Swyddfa Ganolog Gwysio Rheithgor" on the page
	And I see "jurysummoning@justice.gov.uk" on the page
	And I see "Rhif ffôn: 0300 456 1024" on the page
	And I see "Llinell Gymraeg: 0300 303 5173" on the page
	And I see "Dydd Llun i Ddydd Iau 9am – 5pm" on the page
	And I see "Dydd Gwener 9am – 3pm" on the page
	And I see "Canfod mwy am gostau galwadau" on the page
	
	