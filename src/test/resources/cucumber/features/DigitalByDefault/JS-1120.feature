Feature: JS-1120 DBD Survey link

  @JurorTransformation
  Scenario Outline: DBD Survey Link Visible on all screens for a digital response

    Given I am on "Public" "demo"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 431   |<juror_number>| <pool_number>	| 1				        | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    And I update "<juror_number>" to set them up for digital by default

    Then I see "Reply to a jury summons" on the page

    And I set the radio button to "I am replying for myself"
    And I press the "Continue" button
    Then I see "Your juror details" on the page

	#Juror Log In
    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button

    #DBD landing screen
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #when and where to attend
    When I click on the "When and where to attend" link
    Then I see "Your start date, court address, arrival time and security information." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #how jury service works
    When I click on the "How jury service works" link
    Then I see "What jury service is and who can be called" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #support and accessibility
    When I click on the "Support and accessibility" link
    Then I see "Support and accessibility" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #employment and time off
    When I click on the "Employment and time off work" link
    Then I see "Employment and time off work" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #claiming expenses
    When I click on the "Claiming expenses" link
    Then I see "You do not get paid for doing jury service but you can claim some money back towards loss of earnings, childcare, travel, and food and drink costs." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #ask to change your dates or be excused
    When I click on the "Asking to change your dates or be excused" link
    And I see "When you respond to your summons, you can ask to change your dates or to be excused from your jury service." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #eligibility
    When I click on the "Juror eligibility" link
    And I see "Who is eligible to serve on a jury?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Back" link

    #Start response
    When I press the start your response button
    Then I see "Is the name we have for you correct?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Yes" radio button

	#Check name
    When I press the "Continue" button
    Then I see "Is this your address?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Yes" radio button

	#Check address
    When I press the "Continue" button
    Then I see "What is your phone number?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Phone details
    When I set "Main phone" to "0207 821 1818"
    And I press the "Continue" button


    Then I see "What is your email address?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Email details
    When I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button

	#DoB
    Then I see "What is your date of birth?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button

    Then I see "Confirm you're eligible for jury service" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I press the "Continue" button
    Then I see "Have you lived in the UK, Channel Islands or Isle of Man for more than five consecutive years, since your 13th birthday?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Residency Yes
    When I choose the "Yes" radio button
    And I press the "Continue" button

	#CJS no
    Then I see "Have you worked in the criminal justice system in the last 5 years?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Bail no
    Then I see "Are you currently on bail for a criminal offence?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Convictions no
    Then I see "Have you been found guilty of a criminal offence?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental health part 1 no
    Then I see "Are you being detained, looked after or treated under the Mental Health Act?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#Mental health part 2 no
    Then I see "Has it been decided that you 'lack mental capacity'?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button

	#I can attend
    Then I see "Check your start date" on the page
    And I see "Yes, I can start on" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    And I set the radio button to "Yes, I can start on"
    And  I press the "Continue" button

	#RA no
    Then I see "Will you need help when you're at the court?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "No" radio button
    And I press the "Continue" button
    Then I see "Check your answers now" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Check your answers
    When I check the "The information I have given is true to the best of my knowledge" checkbox
    And I press the "Submit" button

	#When I press the "Submit" button
    Then I see "We have sent you an email to say you have replied to your jury summons." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #Confirmation page
    Then I see "Tell us about your experience" on the page
    And I see "Help us understand how easy or difficult you found replying to your jury summons online. Your feedback will be kept confidential and help us make replying easier for everyone." on the page
    And I see "The survey takes around 5 minutes to complete." on the page
    And I see link with text "Take the survey"
    When I click on the "Take the survey" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page

    Examples:
      | juror_number	| last_name			| postcode	| email           	| pool_number	|
      | 043100181		| LNAMETWOSIXZERO	| BN7 1AA	| email@outlook.com	| 431300166		|

  @JurorTransformation
  Scenario Outline: Welsh DBD digital response content

    Given I am on the welsh version of "Public" "ithc"

    Given a bureau owned pool is created with jurors
      | court |juror_number  | pool_number	| att_date_weeks_in_future	| owner |
      | 411   |<juror_number>| <pool_number>| 5				            | 400	|

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
    And I update "<juror_number>" to set them up for digital by default

    And I set the radio button to "n ymateb dros fy hun"
    And I press the "Parhau" button
    Then I see "Eich manylion rheithiwr" on the page

	#Juror Log In
    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

    #DBD landing screen
    Then I see "Gwybodaeth am wasanaeth rheithgor" on the page
    And I see "Mae eich gwybodaeth gwŷs rheithgor ar-lein" on the page
    And I see "Rydych wedi mewngofnodi. Gallwch ddarllen yr wybodaeth isod am wasanaethu ar reithgor cyn cwblhau eich ymateb, neu fynd yn syth i'r ffurflen ymateb ar-lein. Bydd arweiniad ar gael drwy gydol y broses." on the page
    And I see "Rydych yn cael eich gwysio i gychwyn gwasanaeth rheithgor ar" on the page
    And I see "Gwybodaeth am wasanaeth rheithgor" on the page
    
    #cards
    #how jury service works
    And I see link with text "Sut mae gwasanaeth rheithgor yn gweithio"
    And I see "Beth yw gwasanaeth rheithgor, pwy gellir galw arnynt, a beth mae'n ei olygu i wasanaethu." on the page

    #when and where to attend
    And I see link with text "Pryd a ble i fynychu"
    And I see "Eich dyddiad cychwyn, cyfeiriad y llys, amser cyrraedd a gwybodaeth ddiogelwch." on the page

    #support and accessibility
    And I see link with text "Cefnogaeth a hygyrchedd"
    And I see "Gofyn am addasiadau rhesymol, cefnogaeth iaith neu gymorth gydag anghenion iechyd." on the page

    #employment and time off
    And I see link with text "Cyflogaeth a chael amser i ffwrdd o'r gwaith"
    And I see "Gwybodaeth i gyflogeion a rheithwyr sy'n hunangyflogedig" on the page

    #claiming expenses
    And I see link with text "Hawlio treuliau"
    And I see "Teithio, bwyd, colli enillion, gofal plant a chefnogaeth ariannol arall." on the page
    
    #change date or excusal
    And I see link with text "Gofyn am newid eich dyddiadau neu gael eich esgusodi"
    And I see "Pryd gallwch ofyn am ddyddiadau gwahanol neu ofyn i gael eich esgusodi o wasanaeth rheithgor." on the page

    #eligibility
    And I see link with text "Cymhwysedd rheithgor"
    And I see "Darllenwch y cwestiynau cymhwysedd a ofynnir i chi fel rhan o'ch ymateb." on the page

    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #when and where to attend
    When I click on the "Pryd a ble i fynychu" link
    Then I see "Eich dyddiad cychwyn, cyfeiriad y llys, amser cyrraedd a gwybodaeth ddiogelwch" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #how jury service works
    Then I see "Beth yw gwasanaeth rheithgor, pwy gellir galw arnynt, a beth mae'n ei olygu i wasanaethu." on the page
    When I click on the "Sut mae gwasanaeth rheithgor yn gweithio" link
    Then I see "Sut mae gwasanaeth rheithgor yn gweithio" on the page
    And I see "Beth yw gwasanaeth rheithgor a phwy all gael eu galw." on the page
    And I see "Beth yw gwasanaeth rheithgor?" on the page
    And I see "Mae gwasanaethu ar reithgor yn ddyletswydd gyhoeddus bwysig. Byddwch chi ac fel arfer 11 o bobl eraill yn ffurfio rheithgor. Gyda'ch gilydd, byddwch yn penderfynu canlyniad treial troseddol mewn Llys y Goron." on the page
    And I see "Pwy all gael ei alw i wasanaethu ar reithgor?" on the page
    And I see "Gall bob oedolyn rhwng 18 a 75 mlwydd oed sy'n byw yn y DU gael ei ddewis ar hap o'r rhestr etholiadol i wasanaethu ar reithgor." on the page
    And I see "Os byddwch yn iau na 18 neu'n hŷn na 76 ar ddiwrnod cyntaf eich gwasanaeth rheithgor, ni fyddwch yn gallu gwasanaethu ond mae'n rhaid i chi dal ymateb i'ch gwŷs." on the page
    And I see "Mae rhagor o wybodaeth ar gael yma: gwasanaeth rheithgor (agor mewn tab newydd)" on the page

    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #support and accessibility
    When I click on the "Cefnogaeth a hygyrchedd" link
    Then I see "Os oes gennych anabledd ac mae arnoch angen i ni wneud addasiadau rhesymol i'ch helpu yn ystod eich gwasanaeth rheithgor, gallwch ddweud wrthym fel rhan o'ch ymateb." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #employment and time off
    When I click on the "Cyflogaeth a chael amser i ffwrdd o'r gwaith" link
    Then I see "Gwybodaeth i gyflogeion a rheithwyr sy'n hunangyflogedig" on the page
    And I see "Bydd y dolenni yn agor mewn tabiau newydd." on the page
    And I see "Mae'n rhaid i'ch cyflogwr adael i chi wneud eich gwasanaeth rheithgor - dyma yw'r gyfraith, ond gallant ofyn i chi wneud cais i newid y dyddiadau i amser mwy cyfleus (gallwch ond gwneud hyn unwaith). Gweler yr wybodaeth am ofyn i gael newid eich dyddiadau neu gael eich esgusodi. neu gwiriwch gohirio neu gael eich esgusodi rhag cyflawni gwasanaeth rheithgor i gael mwy o fanylion." on the page
    And I see "Gall eich cyflogwr ddewis eich talu neu beidio eich talu yn ystod eich gwasanaeth. Os na fyddant yn eich talu, gallwch wneud cais i'r llys am golli enillion, sy'n destun uchafswm dyddiol. Os ydych yn hunangyflogedig, mae gennych yr hawl i hawlio'r un treuliau â phetaech yn weithiwr cyflogedig." on the page
    And I see "Gwiriwch yr wybodaeth yn yr adran 'hawlio treuliau' neu yn gwasanaeth rheithgor i gael mwy o fanylion." on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #claiming expenses
    When I click on the "Hawlio treuliau" link
    Then I see "Nid ydych yn cael tâl am wneud gwasanaeth rheithgor ond gallwch hawlio rhywfaint o arian yn ôl am golli enillion, gofal plant, teithio, a chostau bwyd a diod." on the page
    And I see "Mae'r cyfraddau wedi'u nodi yn gwasanaeth rheithgor ac mae teclyn cyfrifo hefyd i'ch helpu i gyfrifo faint y gallwch ei hawlio gan y llys: gwirio hawliadau rheithwyr ." on the page

    And I click on the "Enillion a gollwyd a chostau gofal plant neu gostau gofal arall" link
    And I see "Gallwn ad-dalu cyfanswm dyddiol ichi i dalu am:" on the page
    And I see "Golli enillion" on the page
    And I see "Costau gofal ychwanegol o ganlyniad i wasanaethu ar reithgor" on the page

    And I click on the "Colli enillion" link
    And I see "Gallwch hawlio am enillion a gollwyd os ydych un ai:" on the page
    And I see "yn gyflogedig ac ni fydd eich cyflogwr yn eich talu yn ystod eich gwasanaeth rheithgor" on the page
    And I see "yn hunangyflogedig neu'n gyfarwyddwr cwmni ar gyflog" on the page
    And I see "Mae’r cyfraddau uchaf y gallwch eu hawlio wedi’u nodi yma: gwasanaeth rheithgor . Ni allwch hawlio mwy os yw eich cyflog llawn yn uwch na'r cyfraddau hyn." on the page
    And I see "Os ydych yn gweithio ar sail rhan amser, gallwch ond hawlio am y dyddiau y byddwch yn gweithio fel arfer, hyd yn oed os byddwch yn treulio wythnos lawn yn y llys." on the page
    And I see "Er enghraifft, os ydych yn gweithio 3 diwrnod yr wythnos fel arfer, gallwch ond hawlio am golli enillion am y 3 diwrnod hwnnw, oherwydd nid ydych wedi colli enillion ar y 2 ddiwrnod arall." on the page
    And I see "Ni allwch hawlio am benwythnosau neu wyliau banc, oherwydd bod y llys ar gau." on the page

    And I click on the "Costau gofal plant neu gostau gofal" link
    And I see "Ni allwch hawlio am gostau gofal sydd gennych fel arfer, er enghraifft, fel rhan o'ch wythnos waith arferol. Ond os bydd gennych gostau gofal ychwanegol sydd wedi codi oherwydd eich bod yn gwasanaethu ar reithgor, gallwch hawlio rhywfaint o arian yn ôl am y rhain." on the page
    And I see "Rhaid ichi fod o fewn y cyfanswm lwfans cyfun dyddiol ar gyfer enillion a gollwyd a chostau gofal." on the page
    And I see "Er enghraiff, os ydych yn hawlio £64.95 ar gyfer costau gofal ychwanegol, byddwch wedi defnyddio'r lwfans yma i gyd ac ni allwch hawlio mwy ar ben hynny ar gyfer enillion a gollwyd." on the page

    And I click on the "Os ydych chi'n hawlio budd-daliadau" link
    And I see "Ni fydd eich budd-daliadau yn cael ei heffeithio am o leiaf 8 wythnos, cyn belled eich bod yn dweud wrth eich swyddog budd-daliadau neu’ch hyfforddwr gwaith am eich gwasanaeth rheithgor. Os gofynnir ichi wasanaethu ar dreial sy'n para'n hirach na 8 wythnos, bydd rhaid ichi siarad â rheolwr y rheithgor i ganfod mwy am sut bydd hyn yn effeithio ar eich budd-daliadau." on the page

    And I click on the "Costau teithio" link
    And I see "Mae'r swm y gallwch ei hawlio yn dibynnu ar sut rydych yn teithio i'r llys. Ni allwch hawlio unrhyw gostau teithio neu gostau llety o dramor. Ceir gwybodaeth am faint y gallwch ei hawlio yma: gwasanaeth rheithgor" on the page
    And I see "Rhaid ichi wirio gyda Rheolwr y Rheithgor yn y llys eich bod yn cael hawlio arian yn ôl am docyn parcio cyn ichi dalu amdano." on the page
    
    And I click on the "Tocynnau teithio" link
    And I see "Prynwch docynnau teithio dyddiol yn unig oni bai bod y llys yn dweud fel arall pan fyddwch yn dechrau eich gwasanaeth rheithgor." on the page
    And I see "Cadwch gopïau o'ch tocynnau neu dderbynebau, i'w hanfon gyda'ch hawliad. Os na fyddwch yn cadw'r rhain, efallai na fyddwn yn gallu eich ad-dalu." on the page

    And I click on the "Costau bwyd a diod" link
    And I see "Gallwch hawlio'r symiau hyn hyd yn oed os ydych yn dod â bwyd a diod eich hun. Mae'r cyfraddau wedi'u nodi yma: gwasanaeth rheithgor" on the page

    And I click on the "Pryd i hawlio" link
    And I see "Cyflwynwch eich hawliad ar ddiwedd eich gwasanaeth rheithgor. Fel arfer byddwch yn cael eich talu o fewn 7 i 10 diwrnod gwaith ar ôl ichi gyflwyno'ch ffurflen. Efallai y bydd y llys yn gallu talu eich treuliau yn ystod y treial os yw'n debygol o bara am amser hir neu os ydych yn wynebu caledi ariannol. Gwiriwch gyda rheolwr y rheithgor yn eich llys pan fyddwch yn cychwyn eich gwasanaeth." on the page

    And I click on the "Os oes gennych gwestiynau" link
    And I see "Hyd at wythnos cyn i'r gwasanaeth rheithgor gychwyn, cysylltwch â" on the page
    And I see "Yn yr wythnos cyn y gwasanaeth rheithgor ac unrhyw adeg ar ôl hynny cysylltwch â'r llys lle byddwch yn gwasanaethu ar reithgor." on the page
    And I see "Byddwch yn cael manylion cyswllt yn nes at yr amser." on the page

    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #ask to change your dates or be excused
    When I click on the "Gofyn am newid eich dyddiadau neu gael eich esgusodi" link
    And I see "Pan fyddwch yn ymateb i'ch gwŷs, gallwch ofyn i newid eich dyddiadau neu gael eich esgusodi o'ch gwasanaeth rheithgor" on the page
    And I see "Gallwch ond newid dyddiadau eich gwasanaeth unwaith, a rhaid i chi roi rheswm i ni. Fe ofynnir i chi ddarparu dyddiadau amgen o fewn y 12 mis nesaf pan fyddwch yn gallu gwasanaethu." on the page
    And I see "Mae esgusodiadau ond yn cael eu cymeradwyo mewn amgylchiadau eithriadol pan na allwch wasanaethu ar unrhyw adeg yn y 12 mis nesaf. Efallai y gofynnir i chi ddarparu tystiolaeth, ond ni fydd rhaid i chi gynnwys hyn pan fyddwch yn ymateb; byddwn yn cysylltu â chi ac yn rhoi amser i chi gasglu unrhyw beth rydyn ni ei angen." on the page
    And I see "Os oes arnoch angen mwy o wybodaeth, gweler gohirio neu gael eich esgusodi rhag cyflawni gwasanaeth rheithgor (agor mewn tab newydd)" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #eligibility
    When I click on the "Cymhwysedd rheithgor" link
    And I see "Pwy sy'n gymwys i wasanaethu ar reithgor?" on the page
    And I see "Fel rhan o'ch ymateb, gofynnir cwestiynau i chi i'n helpu i benderfynu a allwch wasanaethu ar reithgor." on the page
    And I see "Rydych yn gymwys i wasanaethu ar reithgor:" on the page
    And I see "os byddwch dros 18 oed, ac o dan 76 oed, ar y diwrnod y byddwch yn dechrau eich gwasanaeth rheithgor; ac" on the page
    And I see "rydych wedi cofrestru fel etholwr ar gyfer etholiadau seneddol neu lywodraeth leol" on the page
    And I see "rydych chi wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o bum mlynedd fan leiaf ers i chi fod yn 13 oed." on the page
    And I see "Os oes unrhyw un o'r canlynol yn berthnasol i chi, nid ydych yn gymwys i wasanaethu ar reithgor:" on the page

    And I click on the "Anhwylderau meddyliol" link
    And I see "O dan Ddeddf Iechyd Meddwl 1983, ni all rhai pobl wneud Gwasanaeth Rheithgor." on the page
    And I see "Os ydych yn cael eich cadw dan y ddeddf yn yr ysbyty, o dan orchymyn gwarchodaeth neu o dan orchymyn triniaeth gymunedol oherwydd anhwylder meddyliol, ni allwch fod ar reithgor." on the page
    And I see "Os ydych yn dioddef o anhwylder meddyliol (gan gynnwys iselder a gorbryder) ond nad ydych yn cael eich cadw, yn derbyn gofal neu'n cael eich trin o dan y Ddeddf Iechyd Meddwl, gallwch wasanaethu ar reithgor." on the page

    And I click on the "Galluedd meddyliol" link
    And I see "Os nad oes gennych y galluedd meddyliol i wasanaethu fel rheithiwr, ni allwch fod ar reithgor. Mae galluedd meddyliol yn golygu gallu gwneud penderfyniad drosoch eich hun. Dywedir nad oes gan bobl sy'n methu gwneud hyn gapasiti o dan Ddeddf Galluedd Meddyliol 2005. Rhaid i'r diffyg capasiti fod oherwydd nam neu ddiffyg ar weithrediad y meddwl neu'r ymennydd a allai fod oherwydd salwch, anaf, anabledd dysgu, neu broblemau iechyd meddwl." on the page
    And I see "I fod ar reithgor, mae'n rhaid i rywun allu:" on the page
    And I see "Deall yr wybodaeth sy'n berthnasol i'r penderfyniad y maent eisiau ei wneud." on the page
    And I see "Cofio'r wybodaeth am gyfnod digon hir i allu gwneud penderfyniad." on the page
    And I see "Ystyried yr wybodaeth sydd ar gael i wneud y penderfyniad." on the page
    And I see "Cyfathrebu'r penderfyniad drwy unrhyw fodd." on the page
    And I see "Os nad ydych yn siŵr a allwch chi wasanaethu ar rheithgor oherwydd anhwylder meddyliol neu ddiffyg galluedd meddyliol, gallwch ein ffonio ar 0300 303 5172 i gael cyngor." on the page
    
    And I click on the "Mechnïaeth" link
    And I see "Os ydych ar fechnïaeth mewn achos troseddol, ni allwch wasanaethu ar reithgor." on the page
    
    And I click on the "Euogfarnau" link
    And I see "Gallwch wasanaethu ar reithgor os oes gennych bwyntiau ar eich trwydded yrru, dirwyon goryrru neu os ydych wedi mynychu cwrs ymwybyddiaeth cyflymder, cyn belled nad ydych wedi cael unrhyw un o'r dedfrydau isod." on the page
    And I see "NI ALLWCH wasanaethu ar reithgor os ydych wedi cael unrhyw un o'r dedfrydau troseddol hyn yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw. Ni allwch wneud gwasanaeth rheithgor chwaith os ydych wedi cael un o'r dedfrydau troseddol hyn am drosedd gwasanaeth dan Ddeddf y Lluoedd Arfog 2006 unrhyw le yn y byd." on the page
    And I see "carchar am oes, cadw am oes neu y ddalfa am oes," on the page
    And I see "cadw hyd y mynno Ei Fawrhydi neu hyd y mynno'r Ysgrifennydd Gwladol," on the page
    And I see "carcharu er mwyn diogelu'r cyhoedd neu gadw er mwyn diogelu'r cyhoedd," on the page
    And I see "dedfryd estynedig o dan adran 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003 neu adran 254, 266 neu 279 Deddf Dedfrydu 2020 (gan gynnwys dedfryd o'r fath a roddwyd o ganlyniad i adran 219A, 220, 221A neu 222 Deddf y Lluoedd Arfog 2006) neu adran 210A Deddf Gweithdrefn Droseddol (Yr Alban) 1995," on the page
    And I see "cyfnod o garchar o bum mlynedd neu fwy neu gyfnod o gadw am bum mlynedd neu fwy." on the page
    And I see "Hefyd, ni allwch wasanaethu ar reithgor os ydych wedi cael un o'r dedfrydau troseddol hyn yn ystod y 10 mlynedd diwethaf:" on the page
    And I see "wedi treulio unrhyw ran o ddedfryd o garchar neu gadw" on the page
    And I see "wedi cael dedfryd o garchar wedi'i gohirio neu orchymyn cadw wedi'i ohirio" on the page
    And I see "Ni allwch wasanaethu ar reithgor os ydych yn ystod y 10 mlynedd diwethaf yng Nghymru a Lloegr wedi cael gorchymyn cymunedol (gan gynnwys gorchymyn adsefydlu cymunedol, gorchymyn cosbi cymunedol, gorchymyn cosbi cymunedol ac adsefydlu, gorchymyn trin cyffuriau a phrofi, neu orchymyn ymatal rhag cyffuriau)." on the page
    And I see "Hefyd, NI ALLWCH wasanaethu ar reithgor os ydych chi, yn y 10 mlynedd diwethaf, wedi bod yn destun unrhyw orchymyn cyfatebol dan gyfraith Yr Alban, Gogledd Iwerddon, Ynys Manaw, unrhyw un o Ynysoedd y Sianel, neu orchymyn cymunedol neu orchymyn cymunedol tramor dan Ddeddf Lluoedd Arfog 2006." on the page

    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    And I click on the "Cliciwch i fynd yn ôl" link

    #Start response - check name
    When I press the Welsh start your response button
    Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Ydy" radio button

	#Check address
    When I press the "Parhau" button
    Then I see "Eich cyfeiriad chi yw hwn?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab
    When I choose the "Ie" radio button

	#Check phone
    When I press the "Parhau" button
    Then I see "Beth yw eich rhif ffôn?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Phone details
    When I set "Prif rif ffôn" to "0207 821 1818"
    And I press the "Parhau" button

    #email
    Then I see "Beth yw eich cyfeiriad e-bost?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Email details
    When I set "Nodwch eich cyfeiriad e-bost" to "<email>"
    And I set "Nodwch eich cyfeiriad e-bost eto" to "<email>"
    And I press the "Parhau" button

	#DoB
    Then I see "Beth yw eich dyddiad geni?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
    And I set "Blwyddyn" to "1981"
    And I press the "Parhau" button

    Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I press the "Parhau" button
    Then I see "A ydych chi wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers eich pen-blwydd yn 13 oed?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Residency Yes
    When I choose the "Do" radio button
    And I press the "Parhau" button

	#CJS no
    Then I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac ydw" radio button
    And I press the "Parhau" button

	#Bail no
    Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac ydw" radio button
    And I press the "Parhau" button

	#Convictions no
    Then I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Naddo" radio button
    And I press the "Parhau" button

	#Mental health part 1 no
    Then I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Na" radio button
    And I press the "Parhau" button

	#Mental health part 2 no
    Then I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Na" radio button
    And I press the "Parhau" button

	#I can attend
    Then I see "Gwiriwch eich dyddiad dechrau" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    And I set the radio button to "Ydw,"
    And  I press the "Parhau" button

	#RA no
    Then I see "A fyddech chi angen cymorth pan fyddwch yn y llys?" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    When I choose the "Nac oes" radio button
    And I press the "Parhau" button
    Then I see "Gwiriwch eich ymatebion nawr" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

	#Check your answers
    When I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
    And I press the "Cyflwyno" button

	#When I press the "Submit" button
    Then I see "O leiaf 2 wythnos cyn ichi ddechrau gwasanaethu ar reithgor, byddwn yn anfon y canlynol atoch:" on the page
    And I see link with text "Give feedback (opens in a new window or tab)"
    When I click on the "Give feedback (opens in a new window or tab)" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page
    And I focus page to the original tab

    #Confirmation page
    Then I see "Dywedwch wrthym am eich profiad" on the page
    And I see "Helpwch ni i ddeall pa mor hawdd neu anodd oedd ymateb i'ch gwŷs rheithgor ar-lein." on the page
    And I see "Cedwir eich adborth yn gyfrinachol a bydd yn ein helpu i'w gwneud yn haws ymateb i bawb." on the page
    And I see "Mae'r arolwg yn cymryd tua 5 munud i'w gwblhau." on the page
    And I see link with text "Cwblhewch yr arolwg"
    When I click on the "Cwblhewch yr arolwg" link
    And I focus page to the new tab
    Then I see "Juror_Digital_Survey/" in the URL
    And I see "Jurors Digital Pilot Survey" on the page

    Examples:
      | juror_number	| last_name			| postcode	| email           	| pool_number	|
      | 041100181		| LNAMETWOSIXZERO	| BN7 1AA	| email@outlook.com	| 411300166		|