Feature: Expenses_Welsh_JDB-4373
	
@expenses @JDB-4373 
Scenario: expenses_Welsh_JDB-4373

	Given I am on the welsh version of "expenses" "juror-test01"
	
	And I press the "Cychwyn arni" button
	
	#page content
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	Then I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page 
	And I see "Mae hyn yn golygu incwm gan gyflogwr neu eich incwm os ydych yn hunangyflogedig. Ni fydd budd-daliadau fel y Lwfans Ceisio Gwaith yn cael ei effeithio oni bai eich bod yn gwasanaethu ar reithgor am fwy na 8 wythnos." on the page 
	Then I click on the "Mae fy nghyflogwr wedi dweud y byddant yn fy nhalu ac yn hawlio'r arian yn ôl gan y llys" link
	Then I see "Gellir ad-dalu costau treuliau ac unrhyw enillion a gollwyd i'r rheithiwr dim ond os yw'r rheithiwr wedi profi colled ariannol o ganlyniad uniongyrchol i wasanaethu ar reithgor. Ni fydd y llys yn talu iawndal i drydydd partïon fel cyflogwyr. Os bydd eich cyflogwr yn eich talu, ni allwch wneud hawliad am golli enillion." on the page
	
	#none selected by default
	
	And the radio button "Byddaf" is "unselected"
	And the radio button "Na fyddaf" is "unselected"
	
	#errors if Continue pressed with none selected
	
	When I press the "Parhau" button
	Then I see "Dewiswch byddaf neu na fyddaf" on the page	
	
	#Select Yes
	
	
	Then I set the radio button to "Byddaf"
	Then the radio button "Byddaf" is "selected"
	Then the radio button "Na fyddaf" is "unselected"

	#Select No
	
	Then I set the radio button to "Na fyddaf"
	Then the radio button "Na fyddaf" is "selected"
	Then the radio button "Byddaf" is "unselected"
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#Back link

	And I do not see link with text "Cliciwch i fynd yn ôl"