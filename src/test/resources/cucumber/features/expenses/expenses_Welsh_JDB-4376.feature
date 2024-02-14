Feature: Expenses_Welsh_JDB-4376
	
@expenses @JDB-4376 
Scenario: expenses_Welsh_JDB-4376
	
	Given I am on the welsh version of "expenses" "juror-test01"

    And I press the "Cychwyn arni" button
	
	Then I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page
    Then I set the radio button to "Na fyddaf"
	When I press the "Parhau" button
	
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	
	Then I see "A fydd gwasanaethu ar reithgor yn golygu y bydd gennych gostau ychwanegol na fyddai'n codi fel arfer?" on the page
 
	And I click on the "Hawlio Treuliau ar gyfer gofal plant neu gofal ar gyfer oedolion hŷn / bregus" link
	And I see "Gallwch hawlio am gostau ychwanegol sy'n codi ar gyfer gofal plant neu gostau gofal ar gyfer oedolyn hŷn / bregus yn ystod y cyfnod pan fyddwch yn gwasanaethu ar reithgor." on the page
	   
	Then I see "Ni allwch wneud hawliad am gostau y byddwch yn eu talu fel arfer" on the page 

	
	And I see "os ydych yn gweithio ac yn talu am ofalwr plant fel arfer, ni allwch wneud hawliad am y dyddiau y byddwch yn gweithio fel arfer." on the page 

	Then I see "Os bydd rhywun yn cymryd gwyliau blynyddol i ofalu am eich plentyn" on the page
	And I see "Ni allwch hawlio eu cyflog yn ôl oherwydd byddai eu cyflogwr fel arfer yn eu talu ar gyfer eu gwyliau blynyddol." on the page 
	
	Then I see "Os bydd eich ffrindiau neu'ch teulu yn darparu gofal ac yn codi tâl arnoch am wneud hynny" on the page
	Then I see "Gallwch hawlio hyd at £2.50 yr awr, fesul plentyn neu oedolyn tuag at y gost hon." on the page 
	Then I see "Gallwch hawlio hyd at 8 awr ar gyfer pob diwrnod rydych chi yn y llys." on the page 
	And I see "Rhaid i'r unigolyn hwn ddarparu llythyr i'r llys sy'n nodi eu manylion llawn a'r dyddiadau a'r amseroedd mae'n nhw wedi gofalu am eich plentyn neu unrhyw oedolyn cyn y bydd y treuliau yn cael eu talu." on the page 
	
	#footer
	
	And I see "All content is available under the Open Government Licence v3.0, except where otherwise stated" on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#back link
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	And I see "A fydd gwasanaethu ar reithgor yn golygu y bydd gennych gostau ychwanegol na fyddai'n codi fel arfer?" on the page
	And I set the radio button to "Na fydd"
	When I press the "Parhau" button
	And I see "Sut byddwch yn teithio i'r llys?" on the page