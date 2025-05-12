Feature: Expenses_Welsh_JDB-4345_JDB-4348

@expenses @JDB-4345 @JDB-4348 
Scenario Outline: expenses_Welsh_JDB-4345_RoundUp
	
	Given I am on the welsh version of "expenses" "ithc"
	
	And I press the "Cychwyn arni" button
	
	#loseincome
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	Then I set the radio button to "Nac ydw"
	When I press the "Parhau" button
	
	#dailyearnings
	
	Then I set "£ y dydd" to "<earnings>"	
	When I press the "Parhau" button
	
	#otherexpenses
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#dailyexpenses
	Then I set "£ y dydd" to "<expenses>"	
	When I press the "Parhau" button
	
	#traveltypes
	When I check the "Beic" checkbox
	When I check the "Car" checkbox
	When I check the "Beic modur" checkbox
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	When I check the "Cerdded" checkbox
	When I press the "Parhau" button
	
	#setbikemiles
	Then I set "Milltiroedd y dydd" to "<bikeMiles>"	
	When I press the "Parhau" button
	
	#setcarmiles
	Then I set "Milltiroedd y dydd" to "<carMiles>"	
	When I press the "Parhau" button
	
	#setmotorbikemiles
	Then I set "Milltiroedd y dydd" to "<motorbikeMiles>"	
	When I press the "Parhau" button
	
	#payforparking?
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#cantclaimforparking
	When I press the "Parhau" button
	
	#publictransportcosts
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "<publicTransport>"	
	When I press the "Parhau" button
	
	#checkyouranswers
	When I press the "Parhau" button
	
	#pagetext
	
	Then I see "Gwiriwch beth allwch chi ei hawlio ar gyfer gwasanaethu ar reithgor" on the page
	Then I see "Dylech fod yn gallu hawlio" on the page
	
	And I see "<totalClaim> y dydd" on the page
	
	Then I see "Mae cyfrifiad hwn yn seiliiedig ar y canlynol:" on the page 
	Then I see "bod y manylion rydych wedi'u rhoi yn gywir" on the page
	Then I see "bod eich gwasanaeth rheithgor yn para hyd at 10 diwrnod" on the page 
	Then I see "byddwch yn y llys am o leiaf 4 awr pob dydd" on the page 
	
	Then I see "Sut wnaethom ni gyfrifo hwn" on the page 
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I see "Colli enillion ac unrhyw gostau eraill"
	
	Then I see "Gallwch hawlio £<canClaim> ar gyfer pob dydd y byddwch yn colli incwm neu bob dydd lle mae gennych gostau ychwanegol oherwydd eich bod yn gwasanaethu ar reithgor" on the page

	And I select the dropdown for "Sut mae fy nhreuliau a faint o fy enillion yr wyf wedi eu colli wedi cael eu cyfrifo?"
	
	And on Expenses I see "<earnings> fesul dydd  " under "Colli enillion"
	
	And on Expenses I see "<expenses> fesul dydd  " under "Treuliau eraill"
	
	And on Expenses I see "<earningsAndExpenses> fesul dydd " under "Cyfanswm"
	
	And on Expenses I see "£<canClaim> yw'r uchafswm y gallwch ei hawlio fesul dydd o fewn y 10 diwrnod o wasanaethu ar reithgor. Ar gyfer dyddiau sy'n fyrrach na 4 awr, mae'r swm hwn yn llai, sef £32.47" under "Cyfanswm"
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I see "Teithio"
	
	Then I see "Gallwch hawlio £<totalTravel> ar gyfer pob dydd rydych yn teithio i'r llys." on the page

	And I select the dropdown for "Sut mae fy nhreuliau teithio wedi cael eu cyfrifo?"
	
	And on Expenses I see "<carMiles> o filltiroedd ar raddfa o 31.4p y filltir  = <carExpenses>" under "Milltiroedd mewn car"
	
	And on Expenses I see "<motorbikeMiles> o filltiroedd ar raddfa o 31.4p y filltir = <motorbikeExpenses>" under "Milltiroedd ar feic modur"
	
	And on Expenses I see "<bikeMiles> o filltiroedd ar raddfa o 31.4p y filltir = <bikeExpenses>" under "Milltiroedd ar feic"
	
	And on Expenses I see "<publicTransport> y dydd" under "Tocynnau teithio"

	Then on Expenses I see "<totalTravel> y dydd" under "Cyfanswm"
	
	And I see "Nid yw hyn yn cynnwys costau parcio oherwydd byddwch angen cysylltu â'r llys yn gyntaf i ofyn a fyddant yn talu am eich costau parcio." on the page
	And I see "Pan fyddwch wedi cychwyn gwasanaethu ar reithgor, os byddwch yn cynnig dod â rheithwyr eraill i'r llys yn eich car, gallwch hawlio 4.2c ychwanegol fesul milltir ar gyfer y teithiwr cyntaf, a 3.2c ychwanegol eto ar gyfer pob teithiwr ychwanegol ar ôl hynny." on the page
	
	Then I see "Bwyd a diod" on the page 

	And I see "Gallwch hawlio £5.71 pob dydd, hyd yn oed os ydych yn dod â bwyd a diod eich hun gyda chi." on the page
	
	And I see "I gael rhagor o wybodaeth am sut mae treuliau yn cael eu cyfrifo a sut gall newidiadau i'ch gwasanaeth rheithgor effeithio ar y swm y gallwch ei hawlio, darllenwch y ddogfen beth allwch chi ei hawlio " on the page
	
   #footer

	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	#back link
	
	Then I click on the "Cliciwch i fynd yn ôl" link
	And I see "Gwiriwch eich atebion" on the page
	When I press the "Parhau" button
	
	Then I click on the "beth allwch chi ei hawlio" link
	And I see "https://www.gov.uk/jury-service" in the URL
	           
	           
	Then I press the "back" button on my browser
	
	Then I click on the "'Dod o hyd i Lys neu Dribiwnlys" link
	And I see "find-court-tribunal.service.gov.uk/" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Cychwyn eto" link
	And I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page

Examples:
	|earnings	|expenses	|canClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#noroundup
	|43.83		|54.22		|64.95		|98.05				|20.15			|2.5		|0.79		|2.5			|0.79				|2.5      |0.24			|21.97		|92.63		|
#backendroundupwithdecplaces
	|29.87		|57.00		|64.95		|86.87				|20.99			|2.8		|0.88		|2.8			|0.88				|2.9      |0.28			|23.03		|93.69		|
#backendroundupwholenumbers
	|29			|57			|64.95		|86					|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|92.47		|
#earningsandinputexpensestotallessthan64.95
	|20			|14.50		|34.50		|34.50				|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|62.02		|
#displaysearningsandexpenses30
	|20			|10			|30.00		|30					|21				|1			|0.31		|1				|0.31				|2	      |0.19			|21.81		|57.52		|
#displaystravel21.80
	|20			|14.50		|34.50		|34.50				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|62.01		|
	
@expenses @JDB-4345 @JDB-4348 
Scenario Outline: expensesJDB-4345_earnings>64.95andexpenses=0
	
	Given I am on the welsh version of "expenses" "bau-test2"
	
	And I press the "Cychwyn arni" button
	
	#loseincome
	
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	
	Then I set the radio button to "Nac ydw"
	When I press the "Parhau" button
	
	#dailyearnings
	
	Then I set "£ y dydd" to "<earnings>"	
	When I press the "Parhau" button
	
	#otherexpenses
	
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#dailyexpenses
	
	Then I set "£ y dydd" to "<expenses>"	
	When I press the "Parhau" button
	
	#traveltypes
	
	When I check the "Beic" checkbox
	When I check the "Car" checkbox
	When I check the "Beic modur" checkbox
	When I check the "Trafnidiaeth gyhoeddu" checkbox
	When I check the "Cerdded" checkbox
	When I press the "Parhau" button
	
	#setbikemiles
	
	Then I set "Milltiroedd y dydd" to "<bikeMiles>"	
	When I press the "Parhau" button
	
	#setcarmiles
	
	Then I set "Milltiroedd y dydd" to "<carMiles>"	
	When I press the "Parhau" button
	
	#setmotorbikemiles
	
	Then I set "Milltiroedd y dydd" to "<motorbikeMiles>"	
	When I press the "Parhau" button
	
	#payforparking?
	
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#cantclaimforparking
	
	When I press the "Parhau" button
	
	#publictransportcosts
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "<publicTransport>"	
	When I press the "Parhau" button
	
	#checkyouranswers
	
	When I press the "Parhau" button
	
	#pagetext
	
	Then I see "Dylech fod yn gallu hawlio" on the page
	
	And I see "£<totalClaim> y dydd" on the page
	
	Then I see "Mae cyfrifiad hwn yn seiliiedig ar y canlynol:" on the page 
	Then I see "bod y manylion rydych wedi'u rhoi yn gywir" on the page
	Then I see "bod eich gwasanaeth rheithgor yn para hyd at 10 diwrnod" on the page
	Then I see "byddwch yn y llys am o leiaf 4 awr pob dydd" on the page 
	
	Then I see "Sut wnaethom ni gyfrifo hwn" on the page 
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I see "Colli enillion ac unrhyw gostau eraill"
	
	Then I see "Gallwch hawlio £<canClaim> ar gyfer pob dydd y byddwch yn colli incwm neu bob dydd lle mae gennych gostau ychwanegol oherwydd eich bod yn gwasanaethu ar reithgor" on the page 
	
	Then I select the dropdown for "Sut mae fy nhreuliau a faint o fy enillion yr wyf wedi eu colli wedi cael eu cyfrifo?"
	
	And on Expenses I see "<earnings> fesul dydd" under "Colli enillion"
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I do not see "Treuliau eraill"
	
	And on Expenses I see "<earningsAndExpenses> fesul dydd" under "Cyfanswm"
	
	And I see "£64.95 yw'r uchafswm y gallwch ei hawlio fesul dydd o fewn y 10 diwrnod o wasanaethu ar reithgor. Ar gyfer dyddiau sy'n fyrrach na 4 awr, mae'r swm hwn yn llai, sef £32.47" on the page
	
	Then I do not see "Teithio" on the page 
	
	Then I do not see link with text "Sut mae fy nhreuliau teithio wedi cael eu cyfrifo?"
	
	And I do not see "Milltiroedd mewn car" on the page
	
	And I do not see "Milltiroedd ar feic modur" on the page
	
	And I do not see "Milltiroedd ar feic" on the page
	
	And I do not see "Tocynnau teithio" on the page

	Then I do not see "£<totalTravel> fesul dydd" on the page
	
	And I do not see "Nid yw hyn yn cynnwys costau parcio oherwydd byddwch angen cysylltu â'r llys yn gyntaf i ofyn a fyddant yn talu am eich costau parcio." on the page
	And I do not see "Pan fyddwch wedi cychwyn gwasanaethu ar reithgor, os byddwch yn cynnig dod â rheithwyr eraill i'r llys yn eich car, gallwch hawlio 4.2c ychwanegol fesul milltir ar gyfer y teithiwr cyntaf, a 3.2c ychwanegol eto ar gyfer pob teithiwr ychwanegol ar ôl hynny." on the page
	
	Then I see "Bwyd a diod" on the page 

	And I see "Gallwch hawlio £5.71 pob dydd, hyd yn oed os ydych yn dod â bwyd a diod eich hun gyda chi." on the page
	And I see "I gael rhagor o wybodaeth am sut mae treuliau yn cael eu cyfrifo a sut gall newidiadau i'ch gwasanaeth rheithgor effeithio ar y swm y gallwch ei hawlio, darllenwch y ddogfen beth allwch chi ei hawlio " on the page
	
   	#footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Polisi preifatrwydd" on the page
	
	Then I click on the "beth allwch chi ei hawlio" link
	And I see "https://www.gov.uk/jury-service" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "'Dod o hyd i Lys neu Dribiwnlys" link
	And I see "find-court-tribunal.service.gov.uk/" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Cychwyn eto" link
	And I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page

Examples:
	|earnings	|expenses	|canClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#earnings>64.95andexpenses=0	
	|70.00		|0.00		|64.95		|70.00				|0				|0			|0			|0				|0					|0		  |0			|0			|70.66		|


@expenses @JDB-4345 @JDB-4348
Scenario Outline: expensesJDB-4345_0earningsandexpenses>or<64.95
	
	Given I am on the welsh version of "expenses" "ithc"

	And I press the "Cychwyn arni" button
	
	#loseincome
	
	Then I set the radio button to "Byddaf"
	When I press the "Parhau" button
	
	#earnmorethan
	
	Then I set the radio button to "Nac ydw"
	When I press the "Parhau" button
	
	#dailyearnings
	
	Then I set "£ y dydd" to "<earnings>"	
	When I press the "Parhau" button
	
	#otherexpenses
	
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#dailyexpenses
	
	Then I set "£ y dydd" to "<expenses>"	
	When I press the "Parhau" button
	
	#traveltypes
	
	When I check the "Beic" checkbox
	When I check the "Car" checkbox
	When I check the "Beic modur" checkbox
	When I check the "Trafnidiaeth gyhoeddus" checkbox
	When I check the "Cerdded" checkbox
	When I press the "Parhau" button
	
	#setbikemiles
	
	Then I set "Milltiroedd y dydd" to "<bikeMiles>"	
	When I press the "Parhau" button
	
	#setcarmiles
	
	Then I set "Milltiroedd y dydd" to "<carMiles>"	
	When I press the "Parhau" button
	
	#setmotorbikemiles
	
	Then I set "Milltiroedd y dydd" to "<motorbikeMiles>"	
	When I press the "Parhau" button
	
	#payforparking?
	
	Then I set the radio button to "Bydd"
	When I press the "Parhau" button
	
	#cantclaimforparking
	
	When I press the "Parhau" button
	
	#publictransportcosts
	
	Then I set "Cost eich holl docynnau mewn £ fesul dydd" to "<publicTransport>"	
	When I press the "Parhau" button
	
	#checkyouranswers
	
	When I press the "Parhau" button
	
	#pagetext
	
	Then I see "Dylech fod yn gallu hawlio" on the page
	
	And I see "£<totalClaim> y dydd" on the page
	
	Then I see "Mae cyfrifiad hwn yn seiliiedig ar y canlynol:" on the page 
	Then I see "bod y manylion rydych wedi'u rhoi yn gywir" on the page
	Then I see "bod eich gwasanaeth rheithgor yn para hyd at 10 diwrnod" on the page 
	Then I see "byddwch yn y llys am o leiaf 4 awr pob dydd" on the page 
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I see "Colli enillion ac unrhyw gostau eraill"
	
	Then I see "Gallwch hawlio £<canClaim> ar gyfer pob dydd y byddwch yn colli incwm neu bob dydd lle mae gennych gostau ychwanegol oherwydd eich bod yn gwasanaethu ar reithgor" on the page 
	
	Then I select the dropdown for "Sut mae fy nhreuliau a faint o fy enillion yr wyf wedi eu colli wedi cael eu cyfrifo?"
	
	And under the "Sut wnaethom ni gyfrifo hwn" heading I do not see "<earnings> fesul dydd"
	
	And on Expenses I see "<expenses> fesul dydd" under "Treuliau eraill"
	
	And on Expenses I see "<earningsAndExpenses> fesul dydd" under "Cyfanswm"
	
	And I see "£<upperClaim> yw'r uchafswm y gallwch ei hawlio fesul dydd o fewn y 10 diwrnod o wasanaethu ar reithgor. Ar gyfer dyddiau sy'n fyrrach na 4 awr, mae'r swm hwn yn llai, sef £32.47" on the page
	
	Then I see "Gallwch hawlio £<totalTravel> ar gyfer pob dydd rydych yn teithio i'r llys." on the page 
	
	Then I click on the "Sut mae fy nhreuliau teithio wedi cael eu cyfrifo?" link
	
	And on Expenses I see "<carMiles>  o filltiroedd ar gyfradd o 31.4p fesul milltir = <carExpenses>" under "Milltiroedd mewn car"
	
	And on Expenses I see "<motorbikeMiles> o filltiroedd ar gyfradd o 31.4p fesul milltir = <motorbikeExpenses>" under "Milltiroedd ar feic modur"
	
	And on Expenses I see "<bikeMiles> o filltiroedd ar gyfradd o 31.4p fesul milltir = <bikeExpenses>" under "Milltiroedd ar feic"
	
	And on Expenses I see "<publicTransport> fesul dydd" under "Tocynnau teithio"

	Then on Expenses I see "<totalTravel> fesul dydd" under "Cyfanswm"
	
	And I see "Nid yw hyn yn cynnwys costau parcio oherwydd byddwch angen cysylltu â'r llys yn gyntaf i ofyn a fyddant yn talu am eich costau parcio." on the page
	And I see "Pan fyddwch wedi cychwyn gwasanaethu ar reithgor, os byddwch yn cynnig dod â rheithwyr eraill i'r llys yn eich car, gallwch hawlio 4.2c ychwanegol fesul milltir ar gyfer y teithiwr cyntaf, a 3.2c ychwanegol eto ar gyfer pob teithiwr ychwanegol ar ôl hynny." on the page
	
	Then I see "Bwyd a diod" on the page 

	And I see "Gallwch hawlio £5.71 pob dydd, hyd yn oed os ydych yn dod â bwyd a diod eich hun gyda chi." on the page
	
	And I see "I gael rhagor o wybodaeth am sut mae treuliau yn cael eu cyfrifo a sut gall newidiadau i'ch gwasanaeth rheithgor effeithio ar y swm y gallwch ei hawlio, darllenwch y ddogfen beth allwch chi ei hawlio" on the page
	
   #footer
	
	And I see the Gov licence description on the page
	And I see "Cwcis" on the page
	And I do not see "Privacy policy" on the page
	
	Then I click on the "beth allwch chi ei hawlio" link
	And I see "www.gov.uk/jury-service" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "'Dod o hyd i Lys neu Dribiwnlys" link
	And I see "find-court-tribunal.service.gov.uk/" in the URL
	
	Then I press the "back" button on my browser

	Then I click on the "Cychwyn eto" link
	And I see "A fyddwch yn colli unrhyw incwm wrth ichi wasanaethu ar reithgor?" on the page

Examples:
	|earnings	|expenses	|canClaim	|upperClaim	|earningsAndExpenses|publicTransport|carMiles	|carExpenses|motorbikeMiles	|motorbikeExpenses	|bikeMiles|bikeExpenses	|totalTravel|totalClaim	|
#earnings0expenses<64.95
	|0.00		|14.55		|14.55		|64.95		|14.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|42.06		|
#earnings0andexpenses>64.94
	|0.00		|70.55		|64.95		|64.95		|70.55				|20.99			|1			|0.31		|1				|0.31				|2	      |0.19			|21.80		|92.46		|
