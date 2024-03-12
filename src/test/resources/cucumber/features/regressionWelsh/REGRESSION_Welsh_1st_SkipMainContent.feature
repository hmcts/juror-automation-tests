Feature: Welsh_1st_SkipMainContent

@RegressionWelsh @JDB-3413 @JDB-3609 @JDB-3357 @JDB-3590 @JDB-3515 
Scenario Outline: Welsh 1st Party Straight Through with Skip to Main Content Checks

	Given I am on the welsh version of "Public" "juror-test02"
	Given the juror numbers have not been processed
		| part_no 	| pool_no 	| owner |
		| <part_no> |<pool_no>	| 400 	|
		
	And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
	And "<juror_number>" has "FIRST_NAME" as "FNAMESEVENONETHREE"


	#And "<juror_number>" has "FIRST_NAME" as "FNAMEEIGHTFIVEFIVE"
	And juror "<juror_number>" has "ADDRESS_LINE_1" as "855 STREET NAME"
	#And "<juror_number>" has "Address2" as "ANYTOWN"
	#And "<juror_number>" has "Address3" as ""
	And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON"
	And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

	#JDB-3357 Skip to main content check
	#Reply to jury summons
	
	When I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	When I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ymateb i wŷs rheithgor" on the page
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
	
	And I set the radio button to "n ymateb dros fy hun"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Eich manylion rheithiwr" on the page
	
	When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
	When I set "Cyfenw'r Rheithiwr" to "<last_name>"
	When I set "Cod post Rheithiwr" to "<postcode>"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	And I set the radio button to "Ydy"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Eich cyfeiriad chi yw hwn?" on the page
	And I set the radio button to "Ie"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Beth yw eich rhif ffôn?" on the page
	
	When I set "Prif rif ffôn" to "02078211818"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	When I set "Nodwch eich cyfeiriad e-bost" to "<email>"
	When I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Beth yw eich dyddiad geni?" on the page
	
	When I set "Diwrnod" to "27"
	And I set "Mis" to "04"
	And I set "Blwyddyn" to "1981"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	
	Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page

	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	When I set the radio button to "Do"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
	
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
	
	When I set the radio button to "Nac ydw"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	
	When I set the radio button to "Naddo"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
	
	When I set the radio button to "Na"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Gwiriwch eich dyddiad dechrau" on the page
	
	When I set the radio button to "Ydw, rydw i'n gallu dechrau"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
	
	When I set the radio button to "Nac oes"
	And I press the "Parhau" button
	
	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth" checkbox
	
	When I press the "Cyflwyno" button

	#JDB-3357 Skip to main content check

	Then I hit the tab key
	Then I see "Ymlaen i'r prif gynnwys" on the page
	Then the page language is "cy"
	Then I click on the "Ymlaen i'r prif gynnwys" link
	Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
	
	#JDB-3609
	
	Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
	And I see "Rhagor o wybodaeth am wasanaethu ar reithgor. Gallwch darllenwch y rheolau ynghylch trafod y treial a chanfod sut i hawlio am gostau." on the page
	And I see "Chyfrifo pa dreuliau a lwfansau y gallwch eu hawlio." on the page

Examples:
	|part_no	|pool_no	|last_name	|postcode	|email 		| 
	|641500914	|415170401	|DOE		|SW1H 9AJ	|e@eeee.com	|