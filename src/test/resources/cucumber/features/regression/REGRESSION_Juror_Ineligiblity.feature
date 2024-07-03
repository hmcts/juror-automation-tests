Feature: Regression Test Ineligbility

#CONTENTS
#Welsh_3rd_Ineligible_Confirmation Page
#Welsh_3rd_SpecialRequirements
#Welsh_3rd_Ineligible_SpecialRequirements
#Welsh_1st_StraightThrough_MentalResidency
#Welsh_1st_Inel Email Check
#Welsh_3rd_Deferral_Inel
#Checking the word Act in Mental Health Act is capitalised
#English 1st support in court
#English 3rd support in court

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_3rd_Ineligible_Confirmation Page

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button
    Then I see "Ei fanylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

    Then I see "Eich Manylion" on the page

    When I set "Enw cyntaf" to "FirstNamea"
    And I set "Cyfenw" to "LastNameb"
    And I press the "Parhau" button

    And I set "Sut ydych chi" to "Friend"
    And I press the "Parhau" button

    And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
    And I set "Prif rif ffôn" to "02078211818"
    And I check the "Trwy e" checkbox
    When I set input field with "id" of "emailAddress" to "<email>"
    When I set input field with "id" of "emailAddressConfirmation" to "<email>"
    And I press the "Parhau" button
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page

    When I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
    And I press the "Parhau" button
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page

    When I press the "Parhau" button
    Then I see "Mae arnoch angen dweud wrthym a oes gennym yr enw cywir ar eu cyfer" on the page

    Then I set the radio button to "Ydy"
    And I press the "Parhau" button

    Then I see "Ei gyfeiriad ef yw hwn?" on the page

    When I press the "Parhau" button
    Then I see "Dewiswch un o'r opsiynau canlynol" on the page

    Then I set the radio button to "Ie"
    And I press the "Parhau" button

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
	
	#I want to set the year dynamically to current year - 40
    And I set "Blwyddyn" to "1978"
    And I press the "Parhau" button

    Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

    When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button
	
	#JDB-3107
    Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button
	
	#Residency
    And I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
	
	#check hint text content
    Then I click on the "A ydych angen cymorth i ateb hyn?" link

    And on the page I see
      | text                                                                                                                                                                               |
      | I fod yn gymwys ar gyfer gwasanaeth rheithgor, rhaid bod eu prif gyfeiriad wedi bod yn un o'r canlynol am unrhyw gyfnod o 5 mlynedd o leiaf:                                       |
      | Y DU                                                                                                                                                                               |
      | Ynysoedd y Sianel                                                                                                                                                                  |
      | Ynys Manaw                                                                                                                                                                         |
      | Rhaid bod y cyfnod hwn wedi bod ar ôl eu pen-blwydd yn 13 oed.                                                                                                                     |
      | Rhaid bod eu prif gyfeiriad wedi bod yma am o leiaf 5 mlynedd yn olynol. Efallai eu bod wedi bod yn gweithio, yn astudio, wedi ymddeol neu'n ddi-waith.                            |
      | Nid oes ots os aethant dramor ar deithiau hir neu wyliau dramor yn ystod y cyfnod hwn, cyn belled â bod eu prif gyfeiriad yma.                                                     |
      | O 15 i 22 oed, roedd eu prif gyfeiriad yn y DU, Ynysoedd y Sianel neu Ynys Manaw ond, ar ôl hynny, fe wnaethant ymgartrefu mewn gwlad arall.                                       |
      | Mae hyn yn cyfrif fel cyfnod o 5 mlynedd ac yn eu gwneud yn gymwys i wasanaethu ar reithgor.                                                                                       |
      | Os oedd ganddynt brif gyfeiriad yma am gyfnodau byrrach nad oeddent yn olynol, nid yw'r rhain yn cyfrif.                                                                           |
      | Er enghraifft, roedd ganddynt brif gyfeiriad yma am 2 flynedd. Yna, ymhellach ymlaen, bu iddynt ddychwelyd yma am 3 blynedd arall, yna ni fyddem yn cynnwys y rhain gyda'i gilydd. |
      | Ni fyddai hyn yn cyfrif fel cyfnod o 5 mlynedd ac felly ni fyddent yn gymwys i wasanaethu ar reithgor.                                                                             |
      | Os nad ydych yn siŵr o hyd neu os ydynt yn aros am benderfyniad gan Deithebau a Mewnfudo'r DU                                                                                      |
      | Rhaid i chi gysylltu â ni i gael cyngor ar eu sefyllfa benodol.                                                                                                                    |

    And I press the "Parhau" button
	
	#warning when no answer selected
    And I see "Dewiswch ydy os yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf, ers iddynt droi'n 13 oed" on the page
    And I set the radio button to "Naddo"
    Then I see "Rhowch fanylion am ble mae'r unigolyn rydych yn ymateb ar ei ran wedi byw ers ei ben-blwydd/ei phen-blwydd yn 13 mlwydd oed" on the page
    And I press the "Parhau" button
	
	#warning when "No" selected but no reason given
    Then I see error "Rhowch fanylion am ble mae'r unigolyn rydych yn ymateb ar ei ran wedi byw ers ei ben-blwydd/ei phen-blwydd yn 13 mlwydd oed"
    And I set "Rhowch fanylion am ble mae'r unigolyn rydych yn ymateb ar ei ran wedi byw ers ei ben-blwydd/ei phen-blwydd yn 13 mlwydd oed" to "Not a resident"
    And I press the "Parhau" button
	
	#CJS
    And I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    And I see "Mae hyn yn cynnwys gweithio i'r heddlu, Gwasanaeth Carchardai EM, yr Asiantaeth Troseddu Cenedlaethol, y farnwriaeth, GLlTEM neu unrhyw ran arall o'r system cyfiawnder troseddol" on the page
	
	#check hint text content
    And I click on the "Pam ein bod yn gofyn am hyn?" link
    And I see "Nid yw gweithio yn y System Cyfiawnder Troseddol yn atal unigolyn rhag gwasanaethu ar reithgor. Ond efallai byddwn yn cysylltu i ganfod mwy." on the page

    And I press the "Parhau" button
	
	#warning when no answer selected
    And I see "Dewiswch a yw'r unigolyn rydych yn ateb ar ei ran wedi gweithio yn y system cyfiawnder drosoeddol yn ystod y 5 mlynedd diwethaf" on the page
    And I set the radio button to "Ydy"
    And I press the "Parhau" button
	
	#warning when "Yes" selected but no reason given
    And I see "Ticiwch unrhyw sefydliadau mae'r unigolyn wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)" on the page
    And I check the "Yr heddlu" checkbox
    And I set "Pa heddlu?" to "London Police Force"
    And I check the "Gwasanaeth Carchardai EM" checkbox
    And I set "Pa ran o Wasanaeth Carchardai EM?" to "London Prison Service"
    And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
    And I check the "Arall" checkbox
    And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other part CJS"
    And I press the "Parhau" button
	
	#Bail
    And I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    And I see "Os yw'r unigolyn yr ydych yn ateb ar ei ran ar fechnïaeth mewn achos troseddol, ni all wasanaethu ar reithgor." on the page
	
	#warning when no answer selected
    And I press the "Parhau" button
    And I see error "Dewiswch 'Ydy' os yw'r unigolyn ar fechnïaeth am gyflawni trosedd"

    And I set the radio button to "Ydy"

	#warning when "Yes" selected but no reason given
    And I press the "Parhau" button
    And I see "Rhowch fanylion am fechnïaeth a throsedd yr unigolyn" on the page

    And I set "Rhowch fanylion" to "Bailed for crimes"
    And I press the "Parhau" button
	
	#Criminal Convictions
    And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
	
	#hint text
    And I see "Dim ond os rhoddwyd dedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol." on the page
    And I click on the "Canllawiau mewn perthynas â gwasanaethu ar reithgor os oes gennych euogfarn" link
    And on the page I see
      | text                                                                                                                                                                                                                                                                                                      |
      | Pryd y gallant wasanaethu ar reithgor                                                                                                                                                                                                                                                                     |
      | Gallant wasanaethu ar reithgor os ydynt:                                                                                                                                                                                                                                                                  |
      | wedi cael dirwy goryrru                                                                                                                                                                                                                                                                                   |
      | wedi cael pwyntiau cosb ar eu trwydded yrru                                                                                                                                                                                                                                                               |
      | wedi gorfod mynychu cwrs ymwybyddiaeth cyflymder                                                                                                                                                                                                                                                          |
      | Mae hyn yn berthnasol ar yr amod na chawsant unrhyw un o'r dedfrydau isod.                                                                                                                                                                                                                                |
      | Pryd na allant wasanaethu ar reithgor                                                                                                                                                                                                                                                                     |
      | Ni allant wasanaethu ar reithgor os ydynt wedi cael un o’r dedfrydau troseddol isod yn y DU, Ynysoedd y Sianel neu Ynys Manaw. Ni allant ychwaith wasanaethu ar reithgor os ydynt wedi cael un o'r dedfrydau troseddol hyn am drosedd gwasanaeth o dan Ddeddf y Lluoedd Arfog 2006 yn unrhyw le yn y byd: |
      | dedfryd o garchar neu gadw yn y ddalfa am 5 mlynedd neu fwy                                                                                                                                                                                                                                               |
      | dedfryd o garchar ar gyfer diogelu'r cyhoedd neu gadw yn y ddalfa er mwyn diogelu'r cyhoedd                                                                                                                                                                                                               |
      | dedfryd o garchar, y ddalfa neu gadw yn y ddalfa am oes                                                                                                                                                                                                                                                   |
      | dedfryd estynedig o dan un o adrannau 226A, 226B, 227 neu 228 Deddf Cyfiawnder Troseddol 2003, (gan gynnwys dedfryd o'r fath a osodwyd o ganlyniad i adran 219A, 220, 221A neu 222 Deddf y Lluoedd Arfog 2006) neu adran 210A Deddf Gweithdrefn Droseddol (Yr Alban) 1995                                 |
      | cadw hyd mynno Ei Fawrhydi neu hyd mynno'r Ysgrifennydd Gwladol                                                                                                                                                                                                                                           |
      | Ni allant ychwaith wasanaethu ar reithgor os ydynt wedi cael un o'r dedfrydau troseddol hyn yn ystod y 10 mlynedd diwethaf:                                                                                                                                                                               |
      | gwnaethant wasanaethu unrhyw ran o ddedfryd o garchar neu gadw yn y ddalfa                                                                                                                                                                                                                                |
      | cawsant ddedfryd o garchar ohiriedig neu orchymyn atal dros dro ar gyfer cadw yn y ddalfa                                                                                                                                                                                                                 |
      | Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf yng Nghymru a Lloegr, wedi cael gorchymyn cymunedol, gan gynnwys unrhyw un o'r canlynol:                                                                                                                               |
      | gorchymyn adsefydlu cymunedol                                                                                                                                                                                                                                                                             |
      | gorchymyn cosb gymunedol                                                                                                                                                                                                                                                                                  |
      | gorchymyn cosb ac adsefydlu cymunedol                                                                                                                                                                                                                                                                     |
      | gorchymyn trin a phrofi am gyffuriau                                                                                                                                                                                                                                                                      |
      | gorchymyn ymatal rhag cymryd cyffuriau                                                                                                                                                                                                                                                                    |
      | Ni allant ychwaith wasanaethu ar reithgor os ydynt, yn ystod y 10 mlynedd diwethaf, wedi cael:                                                                                                                                                                                                            |
      | unrhyw orchymyn debyg o dan gyfraith yr Alban, Gogledd Iwerddon, Ynys Manaw neu unrhyw un o Ynysoedd y Sianel                                                                                                                                                                                             |
      | gorchymyn cymunedol neu gymuned dramor o dan Ddeddf y Lluoedd Arfog 2006                                                                                                                                                                                                                                  |
      | Os bydd rhywun yn gwasanaethu ar reithgor pan fyddant yn gwybod na ddylent wneud hynny oherwydd euogfarn droseddol, efallai y cânt ddirwy o hyd at £5,000.                                                                                                                                                |
	
	#warning when no answer selected
    And I press the "Parhau" button
    And I see "Dewiswch 'Ydy' os yw'r unigolyn wedi'i gael yn euog o gyflawni trosedd" on the page
	
	#warning when "Yes" selected but no reason given
    And I set the radio button to "Ydy"
    Then I see "Rhowch fanylion am drosedd yr unigolyn" on the page
    And on the page I see
      | text                                            |
      | Ar gyfer pob euogfarn, rhowch fanylion am:      |
      | y drosedd neu'r troseddau a gyflawnwyd ganddynt |
      | pryd ddigwyddodd hyn                            |
      | lle cawsant yr euogfar                          |
      | hyd y ddedfryd                                  |
    And I press the "Parhau" button
    And I see error "Rhowch fanylion am drosedd yr unigolyn"
    And I set text area with "id" of "convictedDetails" to "Convicted for crimes"
    And I press the "Parhau" button
	
	#Mental Health
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
	
	#hint text
    And on the page I see
      | text                                                                              |
      | Dewiswch ie, os ydynt o dan y Ddeddf Iechyd Meddwl:                               |
      | yn cael eich cadw (neu eich anfon i ysbyty meddwl) neu'n debygol o gael eich cadw |
      | yn breswylwydd mewn ysbyty oherwydd anhwylder meddyliol                           |
      | yn destun gwarcheidiaeth neu orchymyn triniaeth gymunedol                         |

    And I click on the "Angen help i ateb hwn?" link

    Then on the page I see
      | text                                                                                                                                                                                           |
      | Ni all person fod ar reithgor os yw un o'r datganiadau hyn yn berthnasol.                                                                                                                      |
      | Os oes ganddynt broblemau iechyd meddwl (gan gynnwys iselder a phryder) ond nid ydynt yn cael ei cadw, eu gwarchod neu eu trin o dan y Ddeddf Iechyd Meddwl, gallant barhau i fod ar reithgor. |
      | (Os ydynt o'r farn nad ydynt yn gall cwblhau gwasanaeth rheithgor oherwydd problemau iechyd meddwl sylweddol, gallwch ofyn iddynt gael eu hesgusodi neu am gael newid y dyddiad                |

    And I press the "Parhau" button
	
	#warning when no answer selected
    And I see "Dewiswch 'ie' os yw'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl" on the page
    And I set the radio button to "Ie"
    Then I see "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" on the page
    And I press the "Parhau" button
	
	#warning when "Yes" selected but no reason given
    And I see error "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl"
    And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" to "Sectioned"
    And I press the "Parhau" button
	
	#MHQ2
    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'" on the page
	
	#hint text
    And I press the "Parhau" button
	
	#warning when no answer selected
    And I see "Dewiswch ie os penderfynwyd nad oes gan y person yr ydych yn eiriol drosto y 'gallu meddyliol'" on the page
    When I set the radio button to "Ie"
    Then I see "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" on the page
    And I press the "Parhau" button
    And I see error "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol"
    And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "Lacks capacity"
    And I press the "Parhau" button

	#Can you attend
    And I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
    And I press the "Parhau" button

	#Special Reqs
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	##JDB-3092
    And I set the radio button to "Nac oes"
    And I set the radio button to "Oes"
    And I see "Disgrifiwch anabledd neu nam yr unigolyn." on the page

    And I check the "Symudedd cyfyngedig" checkbox
    And I check the "Nam ar y clyw" checkbox
    And I check the "Clefyd siwgr" checkbox
    And I check the "Nam difrifol ar ei olwg" checkbox
    And I check the "Anabledd dysgu" checkbox
    And I check the "Arall" checkbox
    And I set "Rhowch fanylion os gwelwch yn dda" to "Other special requirements"
    And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "More detail about special requirements"
    And I click on the "Pam ein bod yn gofyn am hyn?" link

    Then I see "Os byddwch yn dweud wrthym fod gan yr unigolyn rydych yn ymateb ar ei ran nam neu anabledd, byddwn yn gwneud popeth y gallwn i ddiwallu ei anghenion yn yr adeilad llys pan fydd yn cyflawni ei wasanaeth rheithgor. Weithiau byddwn yn gwneud trefniadau i unigolyn ymweld â’r llys ymlaen llaw i gynllunio pa gymorth a chyfleusterau bydd ei angen. Byddwn yn gwneud ein gorau i'w helpu gyda symud o amgylch y llys, gweld neu glywed popeth, neu unrhyw gymorth arbennig arall bydd yr unigolyn rydych yn ymateb ar ei ran angen." on the page
    And I see "Mae rhai o’r adeiladau llys yn hen ac mae’n anoddach i gael mynediad atynt. Os ydych chi’n dweud wrthym am anabledd neu nam yr unigolyn nawr, gallwn wirio p’un a yw’r llys ble fydd yn cyflawni ei wasanaeth rheithgor yn addas iddynt neu beidio." on the page
    And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
    And I see "Rhif ffôn: 0300 456 1024" on the page
    And I see "Llinell Gymraeg: 0300 303 5173" on the page

    When I press the "Parhau" button

    Then I see "Gwiriwch eich ymatebion nawr" on the page
    And I see "Symudedd cyfyngedig, Nam ar y clyw, Clefyd siwgr, Nam difrifol ar ei olwg, Anabledd dysgu" on the page
    And I see "Other special requirements" on the page
    And I see "More detail about special requirements" on the page
    And I see text "Ydy" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
    And I see text "Ie" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?"
    And I see text "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
    And I see text "Ydy" in the same row as "A yw'r unigolyn ar fechn"
    And I see text "Ydy" in the same row as "A yw'r unigolyn wedi'i gael yn euog o drosedd?"
    And I see text "Ie" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?"

    Then I see text "Naddo" in the same row as "A yw'r unigolyn rydych yn ymateb ar ei ran wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers ei ben-blwydd yn 13 oed?"

    Then I see text "Friend" in the same row as "Eich perthynas "

    Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox

    When I press the "Cyflwyno" button

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "<juror_number>" on the page
	
	#JDB-3044
    And I see "Rydym wedi anfon e-bost i ddweud eich bod wedi ymateb i'r wŷs hon." on the page
    And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs" on the page

    And I see "Byddwn nawr yn gwirio'ch atebion. Mae eich atebion yn golygu efallai na all yr unigolyn rydych wedi ymateb ar ei ran wasanaethu ar reithgor." on the page
    And I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os gallant wasanaethu ar reithgor ai peidio." on the page
    And I see "Efallai byddwn yn cysylltu i drafod y cymorth bydd ei angen ar yr unigolyn rydych wedi ymateb ar ei ran er mwyn iddynt allu gwasanaethu ar reithgor." on the page

    And I see "Os gallant wasanaethu ar reithgor, o leiaf pythefnos cyn iddo ddechrau byddwn yn anfon y dogfennau canlynol atynt:" on the page
    And I see "llythyr yn cadarnhau dyddiad y gwasanaeth rheithgor" on the page
    And I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddant yn mynd iddo" on the page
	
	#JDB-3704
    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
    Then I see "Rydym wedi anfon e-bost i ddweud eich bod wedi ymateb i'r wŷs hon." on the page
    Then I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs" on the page
    Then I see "Beth fydd yn digwydd nesaf" on the page
    Then I see "Byddwn nawr yn gwirio'ch atebion. Mae eich atebion yn golygu efallai na all yr unigolyn rydych wedi ymateb ar ei ran wasanaethu ar reithgor." on the page
    Then I see "Byddwn yn ysgrifennu at yr unigolyn rydych wedi ymateb ar ei ran yn y 7 diwrnod nesaf i roi gwybod iddynt os gallant wasanaethu ar reithgor ai peidio." on the page
    Then I see "Os gallant wasanaethu ar reithgor, o leiaf pythefnos cyn iddo ddechrau byddwn yn anfon y dogfennau canlynol atynt:" on the page
    Then I see "llythyr yn cadarnhau dyddiad y gwasanaeth rheithgor" on the page
    Then I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddant yn mynd iddo" on the page
    Then I see "Paratoi ar gyfer gwasanaeth rheithgor" on the page
    Then I see "Mae'r wybodaeth isod hefyd yn y neges e-bost rydym wedi'i hanfon." on the page
    Then I see "Gallwch chi, neu'r unigolyn rydych wedi ymateb ar ei ran, wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eu bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
    Then I see "Rhagor o wybodaeth am wasanaethu ar reithgor. Gallwch darllenwch y rheolau ynghylch trafod y treial a chanfod sut i hawlio am gostau." on the page
    Then I see "Chyfrifo pa dreuliau a lwfansau y gallwch eu hawlio." on the page
    Then I do not see "Eich Canllaw i'r Gwasanaeth Rheithgor (PDF 85KB)" on the page
    Then I see "Beth yw eich barn am y gwasanaeth hwn? (30 eiliad o'ch amser)" on the page

    And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page
    And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link
	
	#residency
    And I see "Ydy" in the same row as "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	
	#MHQ1
    And I see "Ie" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl"
	
	#MHQ2
    And I see "Ie" in the same row as "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'"
	
	#bail
    And I see "Ydy" in the same row as "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?"
	
	#crimes
    And I see "Ydy" in the same row as "A yw'r unigolyn wedi'i gael yn euog o drosedd?"

	#MHQ1
    And I see "Ie" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl"

    Examples:
      | juror_number | last_name         | postcode | email      | pool_number |
      | 045700019    | LNAMESEVENNINESIX | CH1 2AN  | a@eeee.com | 457300019   |


  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_3rd_SpecialRequirements

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button
    Then I see "Ei fanylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

    Then I see "Eich Manylion" on the page

    When I set "Enw cyntaf" to "FirstNamea"
    And I set "Cyfenw" to "LastNameb"
    And I press the "Parhau" button

    And I set "Sut ydych chi" to "Friend"
    And I press the "Parhau" button

    And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
    And I set "Prif rif ffôn" to "02078211818"
    And I check the "Trwy e" checkbox
    When I set input field with "id" of "emailAddress" to "<email>"
    When I set input field with "id" of "emailAddressConfirmation" to "<email>"
    And I press the "Parhau" button
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page

    When I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
    And I press the "Parhau" button
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page

    When I press the "Parhau" button
    Then I see "Mae arnoch angen dweud wrthym a oes gennym yr enw cywir ar eu cyfer" on the page

    Then I set the radio button to "Ydy"
    And I press the "Parhau" button

    Then I see "Ei gyfeiriad ef yw hwn?" on the page

    When I press the "Parhau" button
    Then I see "Dewiswch un o'r opsiynau canlynol" on the page

    Then I set the radio button to "Ie"
    And I press the "Parhau" button

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
	
	#I want to set the year dynamically to current year - 40
    And I set "Blwyddyn" to "1978"
    And I press the "Parhau" button

    Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

    When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button
	
	#JDB-3107
    Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button
	
	#Residency
    And I set the radio button to "Do"
    And I press the "Parhau" button
	
	#CJS
    And I set the radio button to "Ydy"
    Then I see "Dewiswch unrhyw sefydliadau y mae'r unigolyn rydych yn ymateb ar ei ran wedi gweithio iddynt." on the page
    And I check the "Yr heddlu" checkbox
    And I set "Pa heddlu?" to "London Police Force"
    And I check the "Gwasanaeth Carchardai EM" checkbox
    And I set "Pa ran o Wasanaeth Carchardai EM?" to "London Prison Service"
    And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
    And I check the "Arall" checkbox
    And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other part CJS"
    And I press the "Parhau" button
	
	#Bail
    And I set the radio button to "Nac ydy"
    And I press the "Parhau" button

	#Criminal Convictions
    And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
    And I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#Mental Health
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
    And I set the radio button to "Na"
    And I set the radio button to "Ie"
    And I see "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" on the page
    And I set the radio button to "Na"
    And I press the "Parhau" button

    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
    When I set the radio button to "Na"
    And I press the "Parhau" button

	#Can you attend
    And I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
    And I press the "Parhau" button

	#Special Reqs
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	##JDB-3092
    And I set the radio button to "Nac oes"
    And I set the radio button to "Oes"
    And I see "Disgrifiwch anabledd neu nam yr unigolyn." on the page

    And I check the "Symudedd cyfyngedig" checkbox
    And I check the "Nam ar y clyw" checkbox
    And I check the "Clefyd siwgr" checkbox
    And I check the "Nam difrifol ar ei olwg" checkbox
    And I check the "Anabledd dysgu" checkbox
    And I check the "Arall" checkbox
    And I set "Rhowch fanylion os gwelwch yn dda" to "Other special requirements"
    And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "More detail about special requirements"
    And I click on the "Pam ein bod yn gofyn am hyn?" link

    Then I see "Os byddwch yn dweud wrthym fod gan yr unigolyn rydych yn ymateb ar ei ran nam neu anabledd, byddwn yn gwneud popeth y gallwn i ddiwallu ei anghenion yn yr adeilad llys pan fydd yn cyflawni ei wasanaeth rheithgor. Weithiau byddwn yn gwneud trefniadau i unigolyn ymweld â’r llys ymlaen llaw i gynllunio pa gymorth a chyfleusterau bydd ei angen. Byddwn yn gwneud ein gorau i'w helpu gyda symud o amgylch y llys, gweld neu glywed popeth, neu unrhyw gymorth arbennig arall bydd yr unigolyn rydych yn ymateb ar ei ran angen." on the page
    And I see "Mae rhai o’r adeiladau llys yn hen ac mae’n anoddach i gael mynediad atynt. Os ydych chi’n dweud wrthym am anabledd neu nam yr unigolyn nawr, gallwn wirio p’un a yw’r llys ble fydd yn cyflawni ei wasanaeth rheithgor yn addas iddynt neu beidio." on the page
    And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
    And I see "Rhif ffôn: 0300 456 1024" on the page
    And I see "Llinell Gymraeg: 0300 303 5173" on the page

    When I press the "Parhau" button

    Then I see "Gwiriwch eich ymatebion nawr" on the page
    And I see "Symudedd cyfyngedig, Nam ar y clyw, Clefyd siwgr, Nam difrifol ar ei olwg, Anabledd dysgu" on the page
    And I see "Other special requirements" on the page
    And I see "More detail about special requirements" on the page
    And I see text "Ydy" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
    And I see text "Na" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?"
    And I see text "Na" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
    Then I see text "Do" in the same row as "A yw'r unigolyn rydych yn ymateb ar ei ran wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers ei ben-blwydd yn 13 oed?"

    Then I see text "Friend" in the same row as "Eich perthynas "

    Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
    When I press the "Cyflwyno" button

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "<juror_number>" on the page
	
	#JDB-3131 ST + RA
    And I see "Os gallant wasanaethu ar reithgor, o leiaf pythefnos cyn iddo ddechrau byddwn yn anfon y dogfennau canlynol atynt:" on the page
	
	#HTML
    And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page
    And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link

    And I see "Ydy" in the same row as "person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
    And I see "Na" in the same row as "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl"
    And I see "Na" in the same row as "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?"

    Examples:
      | juror_number | last_name       | postcode | email      | pool_number |
      | 045700020    | LNAMESIXSIXZERO | CH1 2AN  | a@eeee.com | 457300020   |

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_3rd_Ineligible_SpecialRequirements

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button
    Then I see "Ei fanylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button

    Then I see "Eich Manylion" on the page

    When I set "Enw cyntaf" to "FirstNamea"
    And I set "Cyfenw" to "LastNameb"
    And I press the "Parhau" button

    And I set "Sut ydych chi" to "Friend"
    And I press the "Parhau" button

    And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
    And I set "Prif rif ffôn" to "02078211818"
    And I check the "Trwy e" checkbox
    When I set input field with "id" of "emailAddress" to "<email>"
    When I set input field with "id" of "emailAddressConfirmation" to "<email>"
    And I press the "Parhau" button
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page

    When I set the radio button to "Nid yw'r unigolyn yn gallu ymateb dros ei hun"
    And I press the "Parhau" button
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page

    When I press the "Parhau" button
    Then I see "Mae arnoch angen dweud wrthym a oes gennym yr enw cywir ar eu cyfer" on the page

    Then I set the radio button to "Ydy"
    And I press the "Parhau" button

    Then I see "Ei gyfeiriad ef yw hwn?" on the page

    When I press the "Parhau" button
    Then I see "Dewiswch un o'r opsiynau canlynol" on the page

    Then I set the radio button to "Ie"
    And I press the "Parhau" button

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
	
	#I want to set the year dynamically to current year - 40
    And I set "Blwyddyn" to "1978"
    And I press the "Parhau" button

    Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page

    When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button
	
	#JDB-3107
    Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button
	
	#Residency
    And I set the radio button to "Naddo"
    And I set "Rhowch fanylion" to "Not a resident"
    And I press the "Parhau" button
	
	#CJS
    And I set the radio button to "Ydy"
    Then I see "Dewiswch unrhyw sefydliadau y mae'r unigolyn rydych yn ymateb ar ei ran wedi gweithio iddynt." on the page
    And I check the "Yr heddlu" checkbox
    And I set "Pa heddlu?" to "London Police Force"
    And I check the "Gwasanaeth Carchardai EM" checkbox
    And I set "Pa ran o Wasanaeth Carchardai EM?" to "London Prison Service"
    And I check the "Yr Asiantaeth Troseddu Cenedlaethol" checkbox
    And I check the "Arall" checkbox
    And I set "Pa ran arall o’r System Cyfiawnder Troseddol?" to "Other part CJS"
    And I press the "Parhau" button
	
	#Bail
    And I set the radio button to "Ydy"
    And I set "Rhowch fanylion" to "Bailed for crimes"
    And I press the "Parhau" button
	
	#Criminal Convictions
    And I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
    And I set the radio button to "Ydy"
    And I set text area with "id" of "convictedDetails" to "Convicted for crimes"
    And I press the "Parhau" button
	
	#Mental Health
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
    And I set the radio button to "Ie"
    And I set "Eglurwch sut y maent yn cael eu cadw dan glo, sut ofal maent yn ei gael neu sut maent yn cael eu trin o dan y Ddeddf Iechyd Meddwl" to "Sectioned"
    And I press the "Parhau" button

    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
    When I set the radio button to "Ie"
    And I set "Eglurwch yn gryno pam y penderfynwyd nad oes ganddynt alluedd meddyliol" to "Lacks capacity"
    And I press the "Parhau" button

	#Can you attend
    And I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
    And I press the "Parhau" button

	#Special Reqs
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
	
	##JDB-3092
    And I set the radio button to "Nac oes"
    And I set the radio button to "Oes"
    And I see "Disgrifiwch anabledd neu nam yr unigolyn." on the page

    And I check the "Symudedd cyfyngedig" checkbox
    And I check the "Nam ar y clyw" checkbox
    And I check the "Clefyd siwgr" checkbox
    And I check the "Nam difrifol ar ei olwg" checkbox
    And I check the "Anabledd dysgu" checkbox
    And I check the "Arall" checkbox
    And I set "Rhowch fanylion os gwelwch yn dda" to "Other special requirements"
    And I set "Rhowch wybod inni am unrhyw drefniadau arbennig neu gymorth bydd yr unigolyn rydych yn ymateb ar ei ran ei angen wrth iddo wasanaethu ar reithgor" to "More detail about special requirements"
    And I click on the "Pam ein bod yn gofyn am hyn?" link

    Then I see "Os byddwch yn dweud wrthym fod gan yr unigolyn rydych yn ymateb ar ei ran nam neu anabledd, byddwn yn gwneud popeth y gallwn i ddiwallu ei anghenion yn yr adeilad llys pan fydd yn cyflawni ei wasanaeth rheithgor. Weithiau byddwn yn gwneud trefniadau i unigolyn ymweld â’r llys ymlaen llaw i gynllunio pa gymorth a chyfleusterau bydd ei angen. Byddwn yn gwneud ein gorau i'w helpu gyda symud o amgylch y llys, gweld neu glywed popeth, neu unrhyw gymorth arbennig arall bydd yr unigolyn rydych yn ymateb ar ei ran angen." on the page
    And I see "Mae rhai o’r adeiladau llys yn hen ac mae’n anoddach i gael mynediad atynt. Os ydych chi’n dweud wrthym am anabledd neu nam yr unigolyn nawr, gallwn wirio p’un a yw’r llys ble fydd yn cyflawni ei wasanaeth rheithgor yn addas iddynt neu beidio." on the page
    And I see "Os ydych yn pryderu am unrhyw beth arall ynghylch y gwasanaeth rheithgor o ran nam neu anabledd sydd gan yr unigolyn rydych yn ymateb ar ei ran, yna cysylltwch â ni." on the page
    And I see "Rhif ffôn: 0300 456 1024" on the page
    And I see "Llinell Gymraeg: 0300 303 5173" on the page

    When I press the "Parhau" button

    Then I see "Gwiriwch eich ymatebion nawr" on the page
    And I see "Symudedd cyfyngedig, Nam ar y clyw, Clefyd siwgr, Nam difrifol ar ei olwg, Anabledd dysgu" on the page
    And I see "Other special requirements" on the page
    And I see "More detail about special requirements" on the page

    Then I see text "Naddo" in the same row as "A yw'r unigolyn rydych yn ymateb ar ei ran wedi byw yn y Deyrnas Unedig, Ynysoedd y Sianel neu Ynys Manaw am gyfnod parhaus o bum mlynedd neu fwy ers ei ben-blwydd yn 13 oed?"
	
#	Then I see text "Friend" in the same row as "Eich perthynas â'r unigolyn a gafodd yr wŷs"
    And I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
    And I press the "Cyflwyno" button
    Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page

    Then I see "<juror_number>" on the page
	
	#JDB-3131 ST + INEL + RA
    And I see "Os gallant wasanaethu ar reithgor, o leiaf pythefnos cyn iddo ddechrau byddwn yn anfon y dogfennau canlynol atynt:" on the page

    Examples:
      | juror_number | last_name | postcode | email      | pool_number |
      | 045700021    | DOE       | CH1 2AN  | a@eeee.com | 457300021   |

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_1st_StraightThrough_MentalResidency

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "n ymateb dros fy hun"
    And I press the "Parhau" button
    Then I see "Eich manylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button
    Then I see "A yw'r enw sydd gennym ar eich cyfer chi yn gywir?" on the page
	
	#Juror's details
    And I set the radio button to "Ydy"
    When I press the "Parhau" button
    Then I see "Eich cyfeiriad chi yw hwn?" on the page
	
	#Juror's address
    And I see "A fydd eich cyfeiriad chi yn newid yn fuan?" on the page
    And I set the radio button to "Ie"
    When I press the "Parhau" button
    Then I see "Beth yw eich rhif ffôn?" on the page
	
	#Juror's phone
    And I see "Darparwch rif ffôn yn y DU y gallwn ei ddefnyddio i gysylltu â chi rhwng 9am a 5pm, dydd Llun i ddydd Gwener." on the page
    When I set "Prif rif ffôn" to "02078211818"
    And I press the "Parhau" button
    Then I see "Beth yw eich cyfeiriad e-bost?" on the page
	
	#Juror's email
    When I see "Pam fod arnom angen eich cyfeiriad e-bost?" on the page
    And I set "Nodwch eich cyfeiriad e-bost" to "email@outlook.com"
    And I set "Nodwch eich cyfeiriad e-bost eto" to "email@outlook.com"
    And I press the "Parhau" button
    Then I see "Beth yw eich dyddiad geni?" on the page
	
	#DoB and JDB-3409
    And I see "Cymorth gyda'ch dyddiad geni" on the page
    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
    And I set "Blwyddyn" to "1978"
    And I press the "Parhau" button
    Then I see "Cadarnhau a ydych yn gymwys i wasanaethu ar reithgor" on the page
	
	#Do you qualify for jury service?
    When I press the "Parhau" button
	
	#Residency
    Then I see "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page

	#hint text
    And I click on the "A ydych angen cymorth i ateb hyn?" link
    And on the page I see
      | text                                                                                                                                                                            |
      | I fod yn gymwys ar gyfer gwasanaeth rheithgor, rhaid bod eich prif gyfeiriad wedi bod yn un o'r canlynol am unrhyw gyfnod o 5 mlynedd o leiaf:                                  |
      | Y DU                                                                                                                                                                            |
      | Ynysoedd y Sianel                                                                                                                                                               |
      | Ynys Manaw                                                                                                                                                                      |
      | Rhaid bod y cyfnod hwn wedi bod ar ôl eich pen-blwydd yn 13 oed.                                                                                                                |
      | Beth sy'n cyfrif fel cyfnod o 5 mlynedd                                                                                                                                         |
      | Rhaid bod eich prif gyfeiriad wedi bod yma am o leiaf 5 mlynedd yn olynol. Efallai eich bod wedi bod yn gweithio, yn astudio, wedi ymddeol neu'n ddi-waith.                     |
      | Does dim ots os aethoch chi dramor ar deithiau hir neu wyliau yn ystod y cyfnod hwn, cyn belled â bod eich prif gyfeiriad yma.                                                  |
      | Enghraifft                                                                                                                                                                      |
      | Rhwng 15 a 22 oed, roedd eich prif gyfeiriad yn y DU, Ynysoedd y Sianel neu Ynys Manaw ond, ar ôl hynny, gwnaethoch ymgartrefu mewn gwlad arall.                                |
      | Mae hyn yn cyfrif fel cyfnod o 5 mlynedd ac yn eich gwneud yn gymwys i wasanaethu ar reithgor.                                                                                  |
      | Beth sydd ddim yn cyfrif                                                                                                                                                        |
      | Os oedd gennych brif gyfeiriad yma am gyfnodau byrrach nad oeddent yn olynol, nid yw'r rhain yn cyfrif.                                                                         |
      | Er enghraifft, roedd gennych brif gyfeiriad yma am 2 flynedd. Yna, ymhellach ymlaen, bu ichi ddychwelyd yma am 3 blynedd arall, yna ni fyddem yn cynnwys y rhain gyda'i gilydd. |
      | Ni fyddai hyn yn cyfrif fel cyfnod o 5 mlynedd ac felly ni fyddech yn gymwys i wasanaethu ar reithgor.                                                                          |
      | Os nad ydych yn siŵr o hyd neu os ydych yn aros am benderfyniad gan Deithebau a Mewnfudo'r DU                                                                                   |
      | Rhaid i chi gysylltu â ni i gael cyngor ar eich sefyllfa benodol.                                                                                                               |

	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewiswch do os yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf, ers i chi droi'n 13 oed" on the page

	#warning if No selected but no reason provided
    And I set the radio button to "Naddo"
    And I press the "Parhau" button
    And I see "Rhowch fanylion am ble rydych wedi byw ers eich pen-blwydd yn 13 mlwydd oed" on the page

    And I set the radio button to "Do"
    And I press the "Parhau" button

	#CJS
    And I see "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page

	#hint text
    And on the page I see
      | text                                                                                                                                                                              |
      | Mae hyn yn cynnwys gweithio i'r heddlu, Gwasanaeth Carchardai EM, yr Asiantaeth Troseddu Cenedlaethol, y farnwriaeth, GLlTEM neu unrhyw ran arall o'r system cyfiawnder troseddol |
	
	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewiswch a ydych wedi gweithio yn y system cyfiawnder troseddol yn ystod y 5 mlynedd diwethaf" on the page
	
	#warning if No selected but no reason provided
    And I set the radio button to "Ydw"
    And I press the "Parhau" button

    And I see "Dewiswch unrhyw sefydliadau rydych wedi gweithio iddynt." on the page
    And I see "Ticiwch unrhyw sefydliadau rydych wedi gweithio iddynt yn uniongyrchol (nid fel trydydd parti neu is-gontractwr)" on the page
    And I set the radio button to "Nac ydw"
    And I press the "Parhau" button
	
	#Bail
    And I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
			   
	#hint text
    And I see "Os ydych ar fechnïaeth mewn achos troseddol, ni allwch wasanaethu ar reithgor." on the page
	
	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewiswch Do os ydych ar fechnïaeth ar hyn o bryd am gyflawni trosedd" on the page
	
	#warning if Yes selected but no reason provided
    And I set the radio button to "Ydw"
    And I press the "Parhau" button
    And I see "Rhowch fanylion am eich mechnïaeth a'ch trosedd" on the page

    And I set "Rhowch fanylion" to "I am on bail for crimes"
    And I press the "Parhau" button
	
	#Convictions
    And I see "Ydych chi wedi'ch cael yn euog o drosedd?" on the page
	
	
	#hint text
    And on the page I see
      | text                                                                                                                 |
      | Dim ond os cawsoch ddedfryd o garchar, gorchymyn cymunedol neu ddedfryd o garchar ohiriedig y mae hyn yn berthnasol. |

	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewiswch 'Do' os cawsoch eich cael yn euog o drosedd" on the page

	#warning if Yes selected but no reason provided
    And I set the radio button to "Do"
    And I press the "Parhau" button

    And I see "Rhowch fanylion am eich trosedd" on the page

    And I set the radio button to "Naddo"
    And I press the "Parhau" button
	
	#Mental health sectioned
    And I see "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?" on the page

	#hint text
    And on the page I see
      | text                                                                              |
      | Dewiswch 'ie' yn unig, o dan Ddeddf Galluedd Meddyliol 1983, os ydych             |
      | yn cael eich cadw (neu eich anfon i ysbyty meddwl) neu'n debygol o gael eich cadw |
      | yn breswylwydd mewn ysbyty oherwydd anhwylder meddyliol                           |
      | yn destun gwarcheidiaeth neu orchymyn triniaeth gymunedol                         |

    And I click on the "Angen help i ateb hwn?" link
    And on the page I see
      | text                                                                                                                                                                                                               |
      | Ni allwch fod ar reithgor os ydi un o'r datganiadau hyn yn berthnasol i chi.                                                                                                                                       |
      | Os oes gennych broblemau iechyd meddwl (yn cynnwys iselder a phryder) ond nid ydych yn cael eich cadw, eich gwarchod neu'n cael eich trin o dan y Ddeddf Galluedd Meddyliol, gallwch ddal i wasanaethu ar reithgor |
      | (Os ydych yn teimlo na allwch chi gyflawni gwasanaeth rheithgor oherwydd problem iechyd meddwl sylweddol, gallwch barhau i ofyn am gael eich esgusodi neu newid eich dyddiadau.)                                   |

	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewisiwch 'ie' os ydych yn cael eich cadw, eich gwarchod neu eich trin o dan Ddeddf Iechyd Meddwl" on the page
	
	#warning if Yes selected but no reason provided
    And I set the radio button to "Ie"
    And I press the "Parhau" button
    And I see "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" on the page
    And I see error "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl"
    And I set "Eglurwch sut yr ydych yn cael eich cadw dan glo, sut ofal ydych yn ei gael neu sut yr ydych yn cael eich trin o dan y Ddeddf Iechyd Meddwl" to "I am sectioned"
    And I press the "Parhau" button
	
	#Mental health capacity
    And I see "A benderfynwyd nad oes gennych y gallu meddyliol?" on the page

	#hint text
    And I see "Ystyr hyn yw na allwch chi wneud penderfyniadau dros eich hun yn gyfreithiol" on the page
    Then I click on the "Angen help i ateb hwn?" link
    And on the page I see
      | text                                                                                                                                |
      | Os nad oes y gallu meddyliol gan rywun, dydyn nhw ddim yn gallu:                                                                    |
      | gwneud eu penderfyniadau eu hunain                                                                                                  |
      | deall a chadw gwybodaeth                                                                                                            |
      | cyfathrebu meddyliau a phenderfyniadau i bobl eraill                                                                                |
      | Ardystiwyd rhai pobl yn feddygol o dan Ddeddf Galluedd Meddyliol 1983 nad oes ganddynt y gallu meddyliol oherwydd damwain neu anaf. |
      | Efallai bod yn rhaid penodi rhywun arall i wneud penderfyniadau ar eu rhan                                                          |
      | Os nad oes gan rywun y gallu meddyliol, ni allant wasanaethu ar reithgor                                                            |

	#warning if continue without selecting an option
    And I press the "Parhau" button
    And I see "Dewiswch 'ie' os penderfyniwyd nad oes gennych y 'gallu meddyliol'" on the page

	#warning if Yes selected but no reason provided
    And I set the radio button to "Ie"
    And I press the "Parhau" button
    And I see "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" on the page
    And I see error "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol"
    And I set "Eglurwch yn gryno pam y penderfynwyd nad oes gennych alluedd meddyliol" to "I lack capacity"
    And I press the "Parhau" button
	
	#Can you attend
    And I set the radio button to "Ydw, rydw i'n gallu dechrau"
    And I press the "Parhau" button
	
	#Special Requirements
    And I set the radio button to "Nac oes"
    When I press the "Parhau" button
	
	#Check your answers page
    Then I see "Gwiriwch eich ymatebion nawr" on the page
	
	#residency
    And I see text "Do" in the same row as "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?"
	
	#detained under MH act
    And I see text "Ie" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	
	#lack capacity
    And I see text "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"
	
	#CJS
    And I see text "Nac ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
	
	#Bail
    And I see text "Ie" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
	
	#criminal offence
    And I see text "Na" in the same row as "Ydych chi wedi'ch cael yn euog o drosedd?"

	#JDB-3086 Checking no as well
    And I see text "Ydw" in the same row as "ar hyn o bryd am gyflawni trosedd?"
    And I click on the "Newid" link in the same row as "ar hyn o bryd am gyflawni trosedd?"
    Then I see "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    When I set the radio button to "Nac ydw"
    And I press the "Parhau" button
    Then I see text "Nac ydw" in the same row as "ar hyn o bryd am gyflawni trosedd?"
	
	#submit
    Then I check the "Mae'r wybodaeth a roddais uchod yn wir hyd eithaf fy ngwybodaeth." checkbox
    When I press the "Cyflwyno" button

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "<juror_number>" on the page
	
	#check html download
    And I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" on the page
    And I click on the "Lawrlwythwch gopi o'ch ymateb i'r wŷs HTML" link

    And I see "Do" in the same row as "Ers i chi droi'n 13 oed, a yw eich prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?"
    And I see "Nac ydw" in the same row as "A ydych chi wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?"
    And I see "Nac ydw" in the same row as "Ydych chi ar fechnïaeth ar hyn o bryd am gyflawni trosedd?"
    And I see "Naddo" in the same row as "Ydych chi wedi'ch cael yn euog o drosedd?"
    And I see "Ie" in the same row as "Ydych chi'n cael eich cadw, yn cael eich gwarchod neu eich trin o dan y Ddeddf Galluedd Meddyliol?"
    And I see "Ie" in the same row as "A benderfynwyd nad oes gennych y gallu meddyliol?"

    Examples:
      | juror_number | last_name | postcode | email      | pool_number |
      | 045700022    | LNAME1327 | CH1 2AN  | a@eeee.com | 457300022   |

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_1st_Inel_Email_Check

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    Given auto straight through processing has been enabled new schema

    And I have submitted a first party Welsh ineligibilty response
      | part_no        | pool_number   | last_name   | postcode   | email   |
      | <juror_number> | <pool_number> | <last_name> | <postcode> | <email> |

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "Os byddwn yn cysylltu â chi, efallai bydd angen i chi ddarparu eich rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atoch." on the page
    Then I see "Rydym wedi anfon neges e-bost atoch i gadarnhau eich bod wedi ymateb i’ch gwŷs rheithgor." on the page
    Then I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs" on the page
    Then I see "Beth fydd yn digwydd nesaf" on the page
    Then I see "Byddwn nawr yn gwirio'ch atebion. Mae eich atebion yn golygu efallai na allwch wasanaethu ar reithgor." on the page
    Then I see "Byddwn yn ysgrifennu atoch yn y 7 diwrnod nesaf i roi gwybod ichi os gallwch wasanaethu ar reithgor ai peidio" on the page
    Then I see "Os gallwch chi wasanaethu ar reithgor, o leiaf 2 wythnos cyn ichi ddechrau byddwn yn anfon y canlynol atoch:" on the page
    Then I see "llythyr yn cadarnhau dyddiad eich gwasanaeth rheithgor" on the page
    Then I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddwch yn mynd iddo" on the page
    Then I see "Paratoi ar gyfer gwasanaeth rheithgor" on the page
    Then I see "Mae'r wybodaeth isod hefyd yn y neges e-bost rydym wedi'i hanfon atoch" on the page
    Then I see "Gallwch wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eich bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
    Then I see "Rhagor o wybodaeth am wasanaethu ar reithgor. Gallwch darllenwch y rheolau ynghylch trafod y treial a chanfod sut i hawlio am gostau." on the page
    Then I see "Chyfrifo pa dreuliau a lwfansau y gallwch eu hawlio." on the page
    Then I do not see "Eich Canllaw i'r Gwasanaeth Rheithgor (PDF 85KB)" on the page
    Then I see "Beth yw eich barn am y gwasanaeth hwn? (30 eiliad o'ch amser)" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    And I click on "<juror_number>" in the same row as "<juror_number>"
    Then I see "Summoned" on the page

    And I press the "Process reply" button
    And I press the "Continue" button
    And I see error "Please select a response process type"
    And I set the radio button to "Disqualify"
    And I press the "Continue" button
    And I press the "Continue" button
    And I see error "Select the reason why you're disqualifying this juror"
    And I set the radio button to "B - Bail"
    And I press the "Continue" button
    And I see "Disqualified" on the page

    Examples:
      | juror_number | last_name | postcode | email      | pool_number |
      | 045700023    | LNAME436  | CH1 2AN  | e@mail.com | 457300023   |

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: Welsh_3rd_Deferral_Inel

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I see "Rwy'n ymateb ar ran rhywun arall" on the page
    And I see "Rwy'n ymateb dros fy hun" on the page
    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button
    Then I see "Ei fanylion rheithiwr" on the page

    When I set "Rhif rheithiwr" to "<juror_number>"
    When I set "Cyfenw" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button
	
	#3rd Party Name
    When I see "Eich Manylion" on the page
    When I set "Enw cyntaf" to "FirstNameA"
    And I set "Cyfenw" to "LastNameB"
    And I press the "Parhau" button
    Then I see "Eich perthynas â'r unigolyn" on the page
	
	#3rd Party Relationship
    When I see "Eich Manylion" on the page
    And I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Relationship"
    And I press the "Parhau" button
	
	#3rd party Contact
    When I see "Eich manylion cyswllt" on the page
    And I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
    And I set "Prif rif ffôn" to "0207 821 1818"
    And I check the "Trwy e-bost" checkbox
    And I set "Nodwch gyfeiriad e-bost" to "<email>"
    And I set "Nodwch gyfeiriad e-bost eto" to "<email>"
    And I press the "Parhau" button
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
	
	#Why Replying
    When I set the radio button to "Nid yw'r unigolyn yma"
    And I press the "Parhau" button
	
	#Juror's Name
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
    And I set the radio button to "Ydy"
    When I press the "Parhau" button
	
	#Juror's Address
    Then I see "Ei gyfeiriad ef yw hwn?" on the page
    And I set the radio button to "Ie"
    When I press the "Parhau" button
    Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page
	
	#Juror's DOB
    And I set "Diwrnod" to "01"
    And I set "Mis" to "01"
    And I set "Blwyddyn" to "1990"
    And I press the "Parhau" button
	
	#Check juror address
    When I see "Manylion y Rheithiwr" on the page
    And I press the "Parhau" button
    Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
	
	#Checking field JDB-3106
    And I set the radio button to "Rhoi cyfeiriad e-bost gwahanol ar gyfer y rheithiwr"
    And I see "Nodwch gyfeiriad e-bost" on the page

    And I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button

	#Qualify for jury service JDB-3107
    When I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button
	
	#Residency
    Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Do"
    And I press the "Parhau" button
	
	#CJS
    Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    When I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#Bail
    Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Ydy"
    And I set "Rhowch fanylion" to "testBailWelshToMakeInellgibile"
    And I press the "Parhau" button
	
	#Convictions
    Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#Mental Health Sectioned
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Na"
    And I press the "Parhau" button
	
	#Mental Health Capacity
    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page
    When I see "Cymhwysedd" on the page
    And I set the radio button to "Na"
    And I press the "Parhau" button
	
	#can you attend
    Then I see "Gwiriwch eich dyddiad dechrau" on the page
    When I set the radio button to "Nac ydi, rhaid newid y dyddiad"
    And I press the "Parhau" button
    Then I see "Dywedwch wrthym pam fod angen dyddiad arall arnynt ar gyfer y gwasanaeth rheithgor" on the page
	
	#reasons for deferral request
    When I set text area with "id" of "deferralReason" to "Reasons for deferral request"
    And I press the "Parhau" button
    Then I see "Dewiswch 3 dydd Llun pan allant ddechrau gwasanaeth rheithgor" on the page

    When I set the "First" single date field to a Monday "6" weeks in the future
    When I set the "Second" single date field to a Monday "7" weeks in the future
    When I set the "Third" single date field to a Monday "8" weeks in the future

    And I press the "Parhau" button
	
	#confirm
    When I set the radio button to "Ydw"
    When I press the "Parhau" button
	
	#Special Reqs
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
    When I set the radio button to "Nac oes"
    When I press the "Parhau" button
	
	#Check your answers page
    Then I see "Gwiriwch eich ymatebion nawr" on the page

    Then I check the "wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
    When I press the "Cyflwyno" button

    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page
    Then I see "<juror_number>" on the page
    Then I see "Rhif rheithiwr yr unigolyn yr ydych wedi ymateb ar ei ran yw" on the page
    Then I see "Os byddwn yn cysylltu â nhw, efallai bydd angen iddynt ddarparu eu rhif rheithiwr. Mae'r rhif hefyd ar y llythyr bu inni anfon atynt." on the page
    Then I see "Rydym wedi anfon e-bost i ddweud eich bod wedi ymateb i'r wŷs hon." on the page
    Then I see "Lawrlwythwch gopi o'ch ymateb i'r wŷs" on the page

    Then I see "Byddwn nawr yn gwirio'ch atebion. Mae eich atebion yn golygu efallai na all yr unigolyn rydych wedi ymateb ar ei ran wasanaethu ar reithgor." on the page
    Then I see "Byddwn yn ysgrifennu at yr unigolyn yn y 7 diwrnod nesaf i roi gwybod iddynt:" on the page
	
	#JDB-3610 missing "Os ydynt..."
    Then I see "Os gallant wasanaethu ar reithgor, o leiaf pythefnos cyn iddo ddechrau byddwn yn anfon y dogfennau canlynol atynt:" on the page
    Then I see "llythyr yn cadarnhau dyddiad y gwasanaeth rheithgor" on the page
    Then I see "pecyn gwybodaeth am fod yn rheithiwr a'r llys byddant yn mynd iddo" on the page
    Then I see "Paratoi ar gyfer gwasanaeth rheithgor" on the page
    Then I see "Gallwch chi, neu'r unigolyn rydych wedi ymateb ar ei ran, wylio fideo am beth sy'n digwydd wrth fod yn rheithiwr ar YouTube, fel eu bod yn gwybod beth i'w ddisgwyl. Mae'r fideo'n para 13 munud." on the page
    Then I see "Rhagor o wybodaeth am wasanaethu ar reithgor. Gallwch darllenwch y rheolau ynghylch trafod y treial a chanfod sut i hawlio am gostau." on the page
    Then I see "Chyfrifo pa dreuliau a lwfansau y gallwch eu hawlio." on the page

    Then I do not see "Eich Canllaw i'r Gwasanaeth Rheithgor (PDF 85KB)" on the page
    Then I see "Beth yw eich barn am y gwasanaeth hwn? (30 eiliad o'ch amser)" on the page

    Examples:
      | juror_number | last_name       | postcode | email      | pool_number |
      | 045700024    | LNAMESIXSIXZERO | CH1 2AN  | a@eeee.com | 457300024   |

  @RegressionWelsh @NewSchemaConverted
  Scenario Outline: THIS IS A WELSH 3rd SUPPORT IN COURT RESPONSE

    Given I am on the welsh version of "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "ADDRESS_LINE_4" as "LONDON" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema
	
	#Reply to jury summons
    Then I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page

    And I set the radio button to "Rwy'n ymateb ar ran rhywun arall"
    And I press the "Parhau" button

    Then I see "Ei fanylion rheithiwr" on the page
    When I set "Rhif rheithiwr – 9 digid" to "<juror_number>"
    When I set "Cyfenw'r Rheithiwr" to "<last_name>"
    When I set "Cod post Rheithiwr" to "<postcode>"
    And I press the "Parhau" button
	
	#3rd party name
    Then I see "Beth yw eich enw?" on the page
    When I set "Enw cyntaf" to "FirstNameA"
    And I set "Cyfenw" to "LastNameB"
    And I press the "Parhau" button
	
	#relationship
    Then I see "Eich perthynas â'r unigolyn" on the page
    When I set "Sut ydych chi'n adnabod yr unigolyn rydych yn ymateb ar ei ran?" to "Friend"
    And I press the "Parhau" button
	
	#contact
    Then I see "Eich manylion cyswllt" on the page
    When I check the "Dros y ffôn (rhifau yn y DU yn unig)" checkbox
    And I check the "Trwy e-bost" checkbox
    And I set "Prif rif ffôn" to "0207 821 1818"
    And I set "Nodwch gyfeiriad e-bost" to "<email>"
    And I set "Nodwch gyfeiriad e-bost eto" to "<email>"
    And I press the "Parhau" button
	
	#reason
    Then I see "Pam ydych chi'n ymateb ar ran yr unigolyn arall?" on the page
    And I set the radio button to "Nid yw'r unigolyn yma"
    And I press the "Parhau" button
	
	#
    Then I see "A yw'r enw sydd gennym ar ei gyfer yn gywir?" on the page
    And I set the radio button to "Ydy"
    And I press the "Parhau" button

	#
    Then I see "Ei gyfeiriad ef yw hwn?" on the page
    And I set the radio button to "Ie"
    And I press the "Parhau" button
	
	#dob
    Then I see "Nodwch ddyddiad geni'r unigolyn rydych chi'n ymateb ar ei ran" on the page

    When I set "Diwrnod" to "27"
    And I set "Mis" to "04"
    And I set "Blwyddyn" to "1981"
    And I press the "Parhau" button
	
	#contact juror
    Then I see "Efallai bydd yn rhaid inni gysylltu â'r unigolyn i ofyn rhagor o gwestiynau neu roi rhagor o wybodaeth iddynt am eu gwasanaeth rheithgor" on the page
    When I set the radio button to "Defnyddio'r rhif ffôn rydych eisoes wedi'i ddarparu i gysylltu â chi"
    When I set the radio button to "Defnyddio'r cyfeiriad e-bost rydych eisoes wedi'i ddarparu i gysylltu â chi"
    And I press the "Parhau" button

	#
    Then I see "Cadarnhau a yw'r unigolyn yn gymwys i wasanaethu ar reithgor" on the page
    And I press the "Parhau" button
	
	#residency
    Then I see "Ers iddynt droi'n 13 oed, a yw eu prif gyfeiriad wedi bod yn y DU, Ynysoedd y Sianel neu Ynys Manaw am unrhyw gyfnod o 5 mlynedd o leiaf?" on the page
    When I set the radio button to "Do"
    And I press the "Parhau" button
	
	#cjs
    Then I see "A yw'r person yr ydych yn ymateb ar ei ran wedi gweithio yn y system cyfiawnder troseddol yn y 5 mlynedd diwethaf?" on the page
    When I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#bail
    Then I see "A yw'r unigolyn ar fechnïaeth ar hyn o bryd am gyflawni trosedd?" on the page
    When I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#crim offence
    Then I see "A yw'r unigolyn wedi'i gael yn euog o drosedd?" on the page
    When I set the radio button to "Nac ydy"
    And I press the "Parhau" button
	
	#MHQ1
    Then I see "A ydi'r person yr ydych yn ymateb ar ei ran yn cael ei gadw, ei warchod neu ei drin o dan y Ddeddf Iechyd Meddwl?" on the page
    When I set the radio button to "Na"
    And I press the "Parhau" button
	
	#MHQ2
    Then I see "A wnaed penderfyniad nad oes gan y person yr ydych yn ymateb ar ei ran y 'gallu meddyliol'?" on the page

    When I set the radio button to "Na"
    And I press the "Parhau" button
	
	#
    Then I see "Gwiriwch eich dyddiad dechrau" on the page
    When I set the radio button to "Ydi, mae'r unigolyn yn gallu dechrau"
    And I press the "Parhau" button
	
	#support in court
	#3608
    Then I see "A fydd yr unigolyn rydych yn ymateb ar ei ran angen cymorth pan fydd yn y llys?" on the page
    When I set the radio button to "Oes"
    And I press the "Parhau" button
    Then I see "Disgrifiwch anabledd neu nam yr unigolyn" on the page

    When I set the radio button to "Nac oes"
    And I press the "Parhau" button
	
	#check answers
    Then I see "Gwiriwch eich ymatebion nawr" on the page
    Then I check the "Hyd gwn i, mae'r wybodaeth rwyf wedi ei rhoi am yr unigolyn rwyf yn ymateb ar ei ran yn gywir." checkbox
    When I press the "Cyflwyno" button

	#confirmation
    Then I see "Rydych wedi cwblhau'r broses ymateb" on the page

    Examples:
      | juror_number | pool_number | last_name       | postcode | email      |
      | 045700025    | 457300025   | LNAMETWOSIXZERO | CH1 2AN  | e@eeee.com |

  @RegressionSingle @NewSchemaConverted
  Scenario Outline: 1st Party Ineligible

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 457   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I press the "Continue" button
    Then I see "Enter your first name" on the page
    And I see "Enter your last name" on the page

    When I set "First name" to "FirstNamea"
    And I set "Last name" to "LastNameb"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page
    And I press the "Continue" button

    When I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I see "Your Details" on the page
    And I press the "Continue" button
    Then I see "Choose a way for us to contact you" on the page
    When I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
    Then I see "Why are you replying for the other person?" on the page
	
	#Why are you replying for juror
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    Then I see "Is the name we have for them correct?" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    Then I see "Is this their address?" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
    Then I see "Confirm if the person is eligible for jury service" on the page
	
	#Does the person you're answering for qualify for jury service?
    And I press the "Continue" button
	
	#Eligibility questions
    And I choose the "No" radio button
    And I set "Provide details" to "Residency"
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I check the "Police service" checkbox
    And I set "Which police service?" to "London Met Police Force"
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I set "Provide details" to "Bail"
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I set text area with "id" of "convictedDetails" to "Criminal Convictions"
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I set "Provide details about how they're being detained, looked after or treated under the Mental Health Act" to "Mental Health Sectioned"
    And I press the "Continue" button

    And I choose the "Yes" radio button
    And I set "Provide brief details about why it was decided they lack mental capacity" to "Mental Health Capacity"
    And I press the "Continue" button

    Then I set the radio button to "Yes, they can start on"
    And I press the "Continue" button
	
	#Help in court
    And I choose the "Yes" radio button
    And I check the "Diabetes" checkbox
    And I press the "Continue" button

	#Check your answers
    Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox

    When I press the "Submit" button
	
	#JDB-3031
	#JDB-3704
    Then I see "You have completed your reply" on the page
    Then I see "If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them." on the page
    Then I see "We have sent an email to say you have replied to this jury summons." on the page
    Then I see "Download a copy of your summons reply" on the page
    Then I see "We'll now check your answers. Your answers might mean that the person you've replied for is not able to do jury service." on the page
    Then I see "We'll write to the person you replied for in the next 7 days to let them know if they are able to do jury service." on the page
    And I see "We may get in touch to talk about the help they need so they can do jury service." on the page
    And I see "If they can do jury service, at least 2 weeks before it starts we'll send them:" on the page
    And I see "a letter confirming the date of their jury service" on the page
    And I see "an information pack about being a juror and the court they're going to" on the page
    And I see "Getting ready for jury service" on the page
    And I see "The information below is also in the email that we have sent." on the page
    And I see "You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch." on the page
    And I see "Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
    And I see "What did you think of this service? (Takes 30 seconds)" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "test"

    Given I am on "Bureau" "test"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "NEEDS REVIEW"

    Examples:
      | juror_number | last_name         | postcode | email             | pool_number |
      | 045700026    | LNAMENINEFOURFIVE | CH1 2AN  | email@outlook.com | 457300026   |

  @Regression @NewSchemaConverted
  Scenario Outline: New CJS Options 3rd party

    Given I am on "Public" "test"

    Given a bureau owned pool is created with jurors
      | court | juror_number   | pool_number   | att_date_weeks_in_future | owner |
      | 452   | <juror_number> | <pool_number> | 5                        | 400   |

    And juror "<juror_number>" has "LAST_NAME" as "<last_name>" new schema
    And juror "<juror_number>" has "POSTCODE" as "<postcode>" new schema

    And I set the radio button to "I am replying for someone else"
    And I press the "Continue" button
    Then I see "Their juror details" on the page

    When I set "9-digit juror number" to "<juror_number>"
    When I set "Juror last name" to "<last_name>"
    When I set "Juror postcode" to "<postcode>"
    And I press the "Continue" button
    Then I see "What is your name?" on the page
	
	#3rd Party Name
    When I set "First name" to "FirstNamea"
    And I set "Last name" to "LastNameb"
    And I press the "Continue" button
    Then I see "Your relationship to the person" on the page
	
	#Relationship to juror
    When I see "Your Details" on the page

    When I set "How do you know the person you're replying for?" to "Friend"
    And I press the "Continue" button
    Then I see "Your contact information" on the page
	
	#3rd Party Contact
    When I check the "By phone (UK Numbers only)" checkbox
    And I set "Main phone" to "0207 821 1818"
    And I check the "By email" checkbox
    And I set "Enter your email address" to "<email>"
    And I set "Enter your email address again" to "<email>"
    And I press the "Continue" button
    Then I see "Why are you replying for the other person?" on the page
	
	#Why are you replying for juror
    When I set the radio button to "The person is not here"
    And I press the "Continue" button
	
	#Check juror name
    Then I see "Is the name we have for them correct?" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button
	
	#Check juror address
    Then I see "Is this their address?" on the page
    When I choose the "Yes" radio button
    And I press the "Continue" button

    Then I see "Give the date of birth for the person you're replying for" on the page
	
	#DoB
    When I see "Juror Details" on the page
    And I set "Day" to "27"
    And I set "Month" to "04"
    And I set "Year" to "1981"
    And I press the "Continue" button
    Then I see "We might need to get in touch with the person to ask them more questions or give them information about their jury service" on the page
	
	#Contacting the juror
    When I see "Juror Details" on the page
    And I set the radio button to "Use the phone number that you have already given to contact you"
    And I set the radio button to "Use the email address that you have already given to contact you"
    And I press the "Continue" button
	
	#Does the person you're answering for qualify for jury service?
    Then I see "Confirm if the person is eligible for jury service" on the page
    And I press the "Continue" button
	
	#Eligibility questions
    And I choose the "Yes" radio button
    And I press the "Continue" button
	
	#CJS Emp
    And I choose the "Yes" radio button
    And I check the "Police service" checkbox
    And I set "Which police service?" to "London Met Police Force"
    And I check the "HM Prison Service" checkbox
    And I set "Which part of HM Prison Service" to "Wandsworth Prison"
    And I check the "the National Crime Agency" checkbox
    And I check the "the Judiciary" checkbox
    And I check the "HM Courts & Tribunal Service" checkbox
    And I check the "Other" checkbox
    And I set "Which other part of the Criminal Justice System?" to "Another part of the CJS"
    And I press the "Continue" button

    And I choose the "No" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button
    And I choose the "No" radio button
    And I press the "Continue" button

    Then I set the radio button to "Yes, they can start on"
    And I press the "Continue" button

	#Help in court
    And I choose the "No" radio button
    And I press the "Continue" button

	#Check your answers
    And I see text "Yes" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
    And I see text "Police service" in the same row as "Have you worked in the criminal justice system in the last 5 years?"
    And I see text "London Met Police Force" in the same row as "Have you worked in the criminal justice system in the last 5 years?"

    Then I check the "The answers I have given for the person I'm replying for are true as far as I know." checkbox

    When I press the "Submit" button
	
	#JDB-3031
	#JDB-3704
    Then I see "You have completed your reply" on the page
    Then I see "If we get in touch with them, they may need to give their juror number. It's also on the letter we sent them." on the page
    Then I see "We have sent an email to say you have replied to this jury summons." on the page
    Then I see "Download a copy of your summons reply" on the page
    And I see "a letter confirming the date of their jury service" on the page
    And I see "an information pack about being a juror and the court they're going to" on the page
    And I see "Getting ready for jury service" on the page
    And I see "The information below is also in the email that we have sent." on the page
    And I see "You or the person you've replied for, can watch this video on YouTube about what happens when you're a juror, so they know what to expect. The video takes 13 minutes to watch." on the page
    And I see "Learn more about jury service. You can read the rules about discussing the trial and find out how to claim expenses." on the page
    And I do not see "Your Guide to Jury Service (PDF 85KB)" on the page
    And I see "What did you think of this service? (Takes 30 seconds)" on the page

    Given I am on "Bureau" "test"
    And I log in as "MODTESTBUREAU"

    When I click on the "Search" link
    And I set "Juror number" to "<juror_number>"
    And I press the "Search" button
    Then I see "<juror_number>" on the page

    And I click link with ID "selectAllLink"
    And I press the "Send to..." button
    And I set input field with "id" of "sendToOfficer" to "CPASS"
    And I press the "Send" button
    And I press the "Send" button
    Then I see "Your work" on the page

    Then I click on the "Sign out" link
    Given I am on "Bureau" "test"
    When I log in as "CPASS"
    Then I see "<juror_number>" on the page
    Then I see "<juror_number>" has reply type indicator "NEEDS REVIEW"

    Examples:
      | juror_number | last_name | postcode | email             | pool_number |
      | 045200135    | DOE       | SW1H 9AJ | email@outlook.com | 452300134   |