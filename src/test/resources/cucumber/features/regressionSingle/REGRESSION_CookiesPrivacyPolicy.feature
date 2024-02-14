Feature: Regression JDB-4528 Cookies and Privacy Policy

@Cookies @JDB-4860 
Scenario: Analytics Cookies opt in
	
	Given I am looking at cookies on "Public" "bau-test"
	
	#new cookies banner
	
	And I see "Cookies on Reply to a jury summons" on the page
	And I see "We use some essential cookies to make this service work." on the page
	And I see "We’d also like to use analytics cookies so we can understand how you use the service and make improvements." on the page
	And I see "Accept analytics cookies" on the page
	
	#accept cookies
	
	And I press the "Accept analytics cookies" button
	And I see "Hide cookie message" on the page
	And I see "You’ve accepted analytics cookies. You can change your cookie settings at any time." on the page
	And I do not see "Cookies on Reply to a jury summons" on the page
	And I do not see "We use some essential cookies to make this service work." on the page
	And I do not see "We’d also like to use analytics cookies so we can understand how you use the service and make improvements." on the page
	
	And I press the "Hide cookie message" button
	
	Then I do not see "Hide cookie message" on the page
	And I do not see "You’ve accepted analytics cookies. You can change your cookie settings at any time." on the page
	
@RegressionSingle @JDB-4860 
Scenario: Analytics Cookies opt out

	Given I am looking at cookies on "Public" "bau-test"
	
	#new cookies banner
	
	And I see "Cookies on Reply to a jury summons" on the page
	And I see "We use some essential cookies to make this service work." on the page
	And I see "We’d also like to use analytics cookies so we can understand how you use the service and make improvements." on the page
	And I see "Accept analytics cookies" on the page
	
	#reject cookies
	
	And I press the "Reject analytics cookies" button
	And I see "Hide cookie message" on the page
	And I see "You’ve rejected analytics cookies. You can change your cookie settings at any time." on the page
	And I do not see "Cookies on Reply to a jury summons" on the page
	And I do not see "We use some essential cookies to make this service work." on the page
	And I do not see "We’d also like to use analytics cookies so we can understand how you use the service and make improvements." on the page
	
	And I press the "Hide cookie message" button
	
	And I do not see "Hide cookie message" on the page
	And I do not see "You’ve rejected analytics cookies. You can change your cookie settings at any time." on the page


@RegressionSingle @JDB-4528 
Scenario: English View Cookies
	
	Given I am looking at cookies on "Public" "bau-test"
	
	#new cookies banner
	
	And I see "Cookies on Reply to a jury summons" on the page
	And I see link with text "View cookies"
   	Then I click on the "View cookies" link
   	Then I click on the "How we use cookies" link
   	
   	And I see "Cookies" on the page
   	And I see "Small files (known as 'cookies') are put onto your computer to collect information about how you browse the site." on the page
   	And I see "Cookies are used to:" on the page
	And I see "measure how you use the website so it can be updated and improved based on your needs" on the page
	And I see "remember the notifications you've seen so that you're not shown them again" on the page
	And I see "GOV.UK cookies are not used to identify you personally." on the page
	And I see "You'll normally see a message on the site before a cookie is stored on your computer." on the page
	And I see "Find out more about how to manage cookies" on the page
	And I click on the "how to manage cookies" link
	And I see "aboutcookies.org" in the URL
	Then I press the "back" button on my browser
	And I see "How cookies are used" on the page
	And I see "Measuring website usage (Google Analytics)" on the page
	And I see "We use Google Analytics to capture data about how our website is being used by the people who visit it. This includes information about how long you spend on each of the pages on our website and the activity you undertake while you are on there." on the page	
	And I see "Google Analytics can capture demographic information about your age, gender, location and language preferences." on the page
	And I see "The reports give us information on the device you are using to access the website, what browser you are using and the version of operating system you are running. This helps us to make sure the website works for everyone." on the page
	And I see "We specifically track how many times our PDF content is downloaded, how many times users exit the site through external links and how many people access the ‘Find out more’ information that are listed against some questions on our website." on the page
	And I see "All data we capture is anonymous and there is no personally identifiable data available to us." on the page
	And I see "We use this information to improve the service and performance as well as wider analysis" on the page
	And I see "The following cookies are used:" on the page
	And I see "This helps us identify how you use GOV.UK so we can make the site better" in the same row as "_gat"
	And I see "1 minute" in the same row as "_gat"
#	And I see "This helps us identify unique users of GOV.UK so we can make the site better" in the same row as "_ga"
	And I see "2 years" in the same row as "_ga"
#	And I see "This helps us identify unique users of GOV.UK so we can make the site better" in the same row as "_gid"
	And I see "24 hours" in the same row as "_gid"
	And I see "You can opt out of Google Analytics cookies" on the page
	And I click on the "out of Google Analytics cookies" link
	And I see "/cookie-settings" in the URL
	Then I press the "back" button on my browser
	And I see "Sessions" on the page
	And I see "A cookie is set to record your session activity." on the page
	And I see "Keeps track of whether you're logged in or not" in the same row as "sessionID"
	And I see "When you close your browser" in the same row as "sessionID"
	And I see "Used to direct you to the same server for each request" in the same row as "ApplicationGatewayAffinity"
	And I see "When you close your browser" in the same row as "ApplicationGatewayAffinity"
	And I see "Our feedback survey" on the page
	And I see "We use SmartSurvey to enable users of the service to provide feedback on their experience of using the service." on the page
	And I see "Details about SmartSurveys security and privacy policy can be found at:" on the page
	And I see link with text "https://www.smartsurvey.co.uk/security"
	And I click on the "https://www.smartsurvey.co.uk/security" link
	And I see "smartsurvey.co.uk/security" in the URL
	Then I press the "back" button on my browser
	And I see "We will use the results from completed survey responses to give us information from your experience of using the service, this will enable us to consider how we further improve the service." on the page
	And I see "All data we capture is anonymous and there is no personally identifiable data available to us." on the page
	And I see "If you take part, SmartSurvey will save extra cookies to your computer to track your progress through it. SmartSurvey is used to collect responses to the survey. If you take part, SmartSurvey will save extra cookies to your computer to track your progress through it. Information on how SmartSurvey uses Cookies can be found at:" on the page
	And I see link with text "https://www.smartsurvey.co.uk/how-we-use-cookies"
	And I click on the "https://www.smartsurvey.co.uk/how-we-use-cookies" link
	And I see "/how-we-use-cookies" in the URL
	Then I press the "back" button on my browser
	And I see "Change your settings" on the page
	And I see "You can change which cookies you're happy for us to use" on the page
	And I click on the "change which cookies you're happy for us to use" link
	And I see "/cookie-settings" in the URL

@Cookies @JDB-4528 
Scenario: English Cookie Settings
	
	Given I am looking at cookies on "Public" "bau-test"
	
	#new cookies banner
	
	And I see "Cookies on Reply to a jury summons" on the page
	And I press the "Accept analytics cookies" button
	And I see "You’ve accepted analytics cookies. You can change your cookie settings at any time." on the page
	Then I click on the "change your cookie settings" link
	
	And I see "/cookie-settings" in the URL
	
	And I see "Cookies are files saved on your phone, tablet or computer when you visit a website." on the page
	And I see "We use cookies to store information about how you use the GOV.UK website, such as the pages you visit." on the page
	And I see "Cookie settings" on the page
	And I see "We use 2 types of cookie. You can choose which cookies you're happy for us to use." on the page
	And I see "Cookies that measure website use" on the page
	And I see "We use Google Analytics to measure how you use the website so we can improve it based on user needs. We do not allow Google to use or share the data about how you use this site." on the page
	And I see "Google Analytics sets cookies that store anonymised information about:" on the page
	And I see "how you got to the site" on the page
	And I see "the pages you visit on GOV.UK and government digital services, and how long you spend on each page" on the page
	And I see "what you click on while you're visiting the site" on the page
	And the radio button "Do not use cookies that measure my website use" is "unselected"
	And the radio button "Use cookies that measure my website use" is "selected"
	And I set the radio button to "Do not use cookies that measure my website use"
	And the radio button "Do not use cookies that measure my website use" is "selected"
	And the radio button "Use cookies that measure my website use" is "unselected"
	And I see "Strictly necessary cookies" on the page
	And I see "These essential cookies do things like remember your progress through a form (for example a licence application)" on the page
	And I see "They always need to be on." on the page
	And I see link with text "How we use cookies"
	And I click on the "How we use cookies" link
	And I see "/help/cookies" in the URL
	Then I press the "back" button on my browser
	And I press the "Save changes" button

@Cookies @JDB-4528 
Scenario: English Privacy Policy
	
	Given I am looking at cookies on "Public" "bau-test"
	
	And I see link with text "Privacy policy"
   	Then I click on the "Privacy policy" link
   	And I switch to the new window
   	And I see "Terms and conditions and privacy policy" on the page
	
	And I see "Using the Reply to Jury Summons service means you agree to our privacy policy and to these terms and conditions. Please read them carefully." on the page
	And I see "Terms and conditions" on the page
	And I see "General" on the page
	And I see "These terms and conditions affect your rights and liabilities under the law. They govern your use of, and relationship with, the Reply to Jury Summons service. They do not apply to other services provided by the Ministry of Justice (MOJ), or to any other department or service linked to in this service." on the page
	And I see "If you do not agree to these terms and conditions and the privacy policy, do not use this service. Instead, please complete the forms sent to you by post (the Juror summons letter pack) and return them to the Juror Central Summonsing Bureau 7 days from the date from which you received your juror summons letter." on the page
	And I see "Applicable law" on the page
	And I see "Your use of this service and any dispute arising from its use will be governed by and construed in accordance with the laws of England and Wales, including but not limited to the:" on the page
	And I see "Juries Act 1974" on the page
	And I see "Juries Act 1976" on the page
	And I see "Juries Act 2003" on the page
	And I see "Criminal Justice Act 2003" on the page
	And I see "Mental Health Act 1983" on the page
	And I see "Mental Capacity Act 2005" on the page
	And I see "Coroners and Justice Act 2009" on the page
	And I see "Armed Forces Act 2006" on the page
	And I see "Computer Misuse Act 1990" on the page
	And I see "Data Protection Act 1998" on the page
	And I see "Human Rights Act 1998" on the page
	And I see "Freedom of Information Act 2000" on the page
	And I see "Using this service responsibly" on the page
	And I see "The service is intended for use by jurors, or by others on their behalf and only with their consent." on the page
	And I see "There are risks in using a shared computer, such as in an internet café, to use this service. It’s your responsibility to be aware of these risks and to avoid using any computer which may leave your personal information accessible by others. You are responsible if you choose to leave a computer unprotected while in the process of responding to a juror summons letter." on the page
	And I see "We make every effort to check and test this service whenever we amend or update it. However, you must take your own precautions to ensure that the way you access this service does not expose you to the risk of viruses, malicious computer code or other forms of interference which may damage your own computer system." on the page
	And I see "You must not misuse our service by knowingly introducing viruses, trojans, worms, logic bombs or other malicious or technologically harmful material. You must not attempt to gain unauthorised access to our service, the system on which our service is stored or any server, computer or database connected to our service. You must not attack our site via a denial-of-service attack or a distributed denial-of-service attack." on the page
	And I see "Privacy policy" on the page
	And I see "Information provided by this service" on the page
	And I see "We work hard to ensure that information within this Reply to Jury Summons service is accurate. However, we cannot guarantee the accuracy and completeness of any information at all times" on the page
	And I see "While we make every effort to ensure this service is accessible at all times, we are not liable if it is unavailable for any period of time." on the page
	And I see "How we use your information" on the page
	And I see "The Juror Central Summoning Bureau and Crown courts use and retain personal data entered into the Reply to Jury Summons service for selection of jurors who will be asked to consider evidence presented to them at Crown Court and on occasion at Coroners Court or Tribunals." on the page
	And I see "Your information is securely stored within the HM Courts and Tribunals Service (HMCTS) Juror database. It will be removed and securely deleted when your Jury service has been completed and there is no reason to retain it further." on the page
	And I see "After submitting your response, you will not be able to see it anymore or amend it online." on the page
	And I see "If you want to make changes to your summons reply, or any other details, after making your reply online, contact the Jury Central Summoning Bureau by email or by post before the date of service quoting your Juror number." on the page
	And I see "Anyone who believes their personal data is kept within the service has the right to submit a subject access request under the Data Protection Act 1998 to the MoJ" on the page
	And I see "For further information regarding this process please click on link below" on the page
	And I see link with text "https://www.gov.uk/government/publications/request-your-personal-data-from-moj"
	And I click on the "https://www.gov.uk/government/publications/request-your-personal-data-from-moj" link
	And I see "personal-information-charter" in the URL
	Then I press the "back" button on my browser
	And I see "We will not share your information with any other organisation unless it is required for the purposes of:" on the page
	And I see "prevention or detection of crime" on the page
	And I see "apprehension or prosecution of offenders" on the page
	And I see "preventing terrorism or national security" on the page
	And I see "We will also share your information where specific provision of law requires us to do so." on the page
	And I see "Separately from the information entered by those using this service, we also collect site-usage information from this service, which allows us to see how the service is being used in order to allow us to improve it. This information does not contain any personal data." on the page
	And I see "We’ll only ever collect information that will help us make the site work better for you; information that will let us contact you if you’ve asked us to, let us give you accurate information if you need it, and give us a sense of how people are using this service, so we can keep improving it." on the page
	And I see "It includes:" on the page
	And I see "questions, queries or feedback you leave, including your email address if you send a message via feedback" on the page
	And I see "your truncated IP address (with the trailing octet removed), and details of which version of web browser you used" on the page
	And I see "information on how you use the site, using cookies and page tagging techniques to help us improve the website" on the page
	And I see "This helps us to:" on the page
	And I see "improve the site by monitoring how you use it" on the page
	And I see "respond to any feedback you send us, if you’ve asked us to" on the page
	And I see "provide you with information about local services if you want it" on the page
	And I see "We cannot identify you personally using your site usage data." on the page
	And I see "Where is your data stored" on the page
	And I see "We store your data on our secure servers in the UK and the European Economic Area (EEA). By submitting your personal data, you agree to this." on the page
	And I see "Keeping your data secure" on the page
	And I see "Transmitting information over the internet is generally not completely secure, and we cannot guarantee the security of your data. We do, however, use SSL (secure sockets layer) to encrypt all data transferred to, and received from, our server. We take data security very seriously and take every step to ensure that your data remains private and secure." on the page
	And I see "Transmit data at your own risk" on the page
	And I see "We have procedures and security features in place to try and keep your data secure once we receive it." on the page
	And I see "We will not share your information with any other organisation unless it is required for the purposes of:" on the page
	And I see "Disclosing your information" on the page
	And I see "We may pass on your personal information if we have a legal obligation to do so." on the page
	And I see "How we manage sessions" on the page
	And I see "This service is for replying to a Jury Summons letter. During this time, personal information about you may be visible to anyone with access to the computer (or other device) you are using." on the page
	And I see "Your data is retrieved from the HMCTS Juror database for the “Your Details” page, and stored on your device until your session expires." on the page
	And I see "Data Protection Act 1998" on the page
	And I see "This service complies with all principles of the DPA 1998. Ministry of Justice (MOJ) is the 'data controller' for the purposes of the Act.  The information you enter into this service is used for the purposes of managing the jury summons process and is stored in a secure database for auditing purposes until your jury service has been completed. No personal data will be used in testing this service." on the page
	And I see "Our hosting provider, and MOJ staff responsible for supporting the service, will have access to the server in which all personal information entered into the site is stored." on the page
	And I see "Disclaimer" on the page
	And I see "We do not accept liability for loss or damage incurred by users of this service, whether direct, indirect or consequential, whether caused by tort, breach of contract or otherwise. This includes loss of income or revenue, business, profits or contracts, anticipated savings, data, goodwill, tangible property or wasted time in connection with this service or any websites linked to it and any materials posted on it. This condition shall not prevent claims for loss of or damage to your tangible property or any other claims for direct financial loss that are not excluded by any of the categories set out above." on the page
	And I see "This does not affect our liability for death or personal injury arising from our negligence, nor our liability for fraudulent misrepresentation or misrepresentation as to a fundamental matter, nor any other liability which cannot be excluded or limited under applicable law." on the page

	@RegressionSingle
	Scenario: Welsh Analytics Cookies opt in

		Given I am looking at cookies on Welsh "Public" "bau-test"
		And I see "Cwcis ar ffurflen Ymateb i wŷs rheithgor" on the page
		And I see "Rydym yn defnyddio rhai cwcis hanfodol i wneud i'r gwasanaeth hwn weithio." on the page
		And I see "Hoffem hefyd ddefnyddio cwcis dadansoddol fel y gallwn ddeall sut rydych yn defnyddio'r gwasanaeth a gwneud gwelliannau." on the page
		And I see "A ydych yn ymateb dros eich hun neu ar ran rhywun arall?" on the page
		And I press the "Derbyn cwcis dadansoddol" button
		And I see "Cuddio'r neges ynghylch cwcis" on the page

	@RegressionSingle
	Scenario: Welsh Privacy Policy

		Given I am looking at cookies on Welsh "Public" "bau-test"

		And I see link with text "Polisi preifatrwydd"
		Then I click on the "Polisi preifatrwydd" link
		And I switch to the new window
		And I see "Telerau ac amodau a pholisi preifatrwydd" on the page

		And I see "Drwy ddefnyddio’r gwasanaeth ar-lein Ymateb i’r Wŷs Rheithgor, rydych yn cytuno i’n polisi preifatrwydd a’r telerau ac amodau hyn. Darllenwch nhw’n ofalus, os gwelwch yn dda." on the page
		And I see "Telerau ac Amodau" on the page
		And I see "Cyffredinol" on the page
		And I see "Mae’r telerau ac amodau hyn yn effeithio ar eich hawliau a’ch rhwymedigaethau dan y gyfraith. Maent yn rheoli’r defnydd a wnewch o’r gwasanaeth ar-lein Ymateb i’r Wŷs Rheithgor a’ch perthynas â’r gwasanaeth hwnnw. Nid ydynt yn berthnasol i wasanaethau eraill a ddarperir gan y Weinyddiaeth Cyfiawnder, nac i unrhyw adran neu wasanaeth arall sy’n gysylltiedig â’r gwasanaeth hwn." on the page
		And I see "Os nad ydych yn cytuno â’r telerau ac amodau hyn a’r polisi preifatrwydd, peidiwch â defnyddio’r gwasanaeth hwn. Yn hytrach, llenwch y ffurflenni a anfonwyd atoch yn y post (y pecyn gwŷs rheithgor) a’u dychwelyd i'r Swyddfa Ganolog Gwysio Rheithgor cyn pen 7 diwrnod i’r dyddiad y cawsoch eich llythyr gwŷs rheithgor." on the page
		And I see "Y Gyfraith sy’n Berthnasol" on the page
		And I see "Bydd y defnydd a wnewch o’r gwasanaeth hwn ac unrhyw anghydfod sy’n codi o’i ddefnyddio yn cael eu rheoli a’u dehongli yn unol â chyfreithiau Cymru a Lloegr, yn cynnwys ond ddim yn gyfyngedig i:" on the page
		And I see "Deddf Rheithgorau 1974" on the page
		And I see "Deddf Rheithgorau 1976" on the page
		And I see "Deddf Rheithgorau 2003" on the page
		And I see "Deddf Cyfiawnder Troseddol 2003" on the page
		And I see "Deddf Iechyd Meddwl 1983" on the page
		And I see "Deddf Galluedd Meddyliol 2005" on the page
		And I see "Deddf Crwneriaid a Chyfiawnder 2009" on the page
		And I see "Deddf Lluoedd Arfog 2006" on the page
		And I see "Deddf Camddefnyddio Cyfrifiaduron 1990" on the page
		And I see "Deddf Diogelu Data 1998" on the page
		And I see "Deddf Hawliau Dynol 1998" on the page
		And I see "Deddf Rhyddid Gwybodaeth 2000" on the page
		And I see "Defnyddio’r gwasanaeth hwn yn gyfrifol" on the page
		And I see "Mae'r gwasanaeth i'w ddefnyddio gan reithwyr, neu gan eraill ar eu rhan, a dim ond gyda’u caniatâd." on the page
		And I see "Mae peryglon wrth ddefnyddio cyfrifiadur sy'n cael ei rannu, megis mewn caffi rhyngrwyd, i ddefnyddio'r gwasanaeth hwn. Eich cyfrifoldeb chi yw bod yn ymwybodol o’r peryglon hyn ac osgoi defnyddio unrhyw gyfrifiadur lle mae posibilrwydd y gall eraill weld eich gwybodaeth bersonol. Chi sy’n gyfrifol os ydych yn dewis gadael cyfrifiadur heb ei ddiogelu tra’r ydych yn y broses o ymateb i wŷs rheithgor." on the page
		And I see "Byddwn yn gwneud pob ymdrech i wirio a phrofi’r gwasanaeth hwn pryd bynnag y byddwn yn ei ddiwygio neu ei ddiweddaru. Fodd bynnag, mae’n rhaid i chi gymryd gofal eich hunan i sicrhau nad yw’r ffordd yr ydych yn cael mynediad at y gwasanaeth hwn yn eich gadael yn agored i’r perygl o feirysau, cod cyfrifiadur maleisus neu ymyrraeth o fath arall a allai achosi difrod i’ch system gyfrifiadurol eich hunan." on the page
		And I see "Ni ddylech gamddefnyddio ein gwasanaeth drwy gyflwyno’n fwriadol feirysau, ymwelwyr diwahoddiad (trojans), mwydod (worms), bomiau rhesymeg (logic bombs) neu unrhyw ddeunydd arall maleisus neu niweidiol i dechnoleg. Ni ddylech geisio cael mynediad heb awdurdod at ein gwasanaeth, y system lle caiff ein gwasanaeth ei storio nac unrhyw weinydd, cyfrifiadur neu gronfa ddata sy’n gysylltiedig â’n gwasanaeth. Ni ddylech ymosod ar ein gwefan drwy ymosodiad gwrthod gwasanaeth neu ymosodiad gwrthod gwasanaeth a ddosbarthwyd." on the page
		And I see "Privacy policy" on the page
		And I see "Gwybodaeth a ddarperir gan y gwasanaeth hwn" on the page
		And I see "Rydym yn gweithio’n galed i sicrhau bod gwybodaeth o fewn y gwasanaeth ar-lein Ymateb i Wŷs Rheithgor hwn yn gywir. Fodd bynnag, ni allwn warantu bod unrhyw wybodaeth yn gywir ac yn gyflawn bob amser." on the page
		And I see "Er y gwnawn bob ymdrech i sicrhau mynediad at y gwasanaeth hwn bob amser, nid ydym yn atebol os nad yw ar gael am unrhyw gyfnod." on the page
		And I see "Sut rydym yn defnyddio eich gwybodaeth" on the page
		And I see "Mae’r Swyddfa Ganolog Gwysio Rheithgor a’r llys y Goron yn defnyddio a chadw data personol a gofnodir yn y gwasanaeth Ymateb i Wŷs Rheithgor i ddethol rheithwyr a fydd yn cael eu gofyn i ystyried tystiolaeth a gyflwynir iddynt mewn Llys y Goron ac, o dro i dro, mewn Llys y Crwner neu Dribiwnlys." on the page
		And I see "Caiff eich gwybodaeth ei storio’n ddiogel yng nghronfa ddata rheithwyr Gwasanaeth Llysoedd a Thribiwnlysoedd EM (GLlTEM). Bydd yn cael ei ddileu’n ddiogel pan fyddwch wedi cwblhau eich gwasanaeth rheithgor ac nid oes rheswm i'w chadw." on the page
		And I see "Ar ôl cyflwyno eich ymateb, ni fyddwch yn gallu ei weld mwyach na’i ddiwygio ar-lein." on the page
		And I see "Os ydych eisiau gwneud newidiadau i’ch ymateb i’r wŷs rheithgor, neu unrhyw fanylion eraill, ar ôl cofnodi eich ymateb ar-lein, cysylltwch â’r Swyddfa Ganolog Gwysio Rheithgor drwy e-bost neu drwy'r post cyn dyddiad eich gwasanaeth rheithgor gan ddyfynnu eich Rhif rheithiwr." on the page
		And I see "Mae gan unrhyw un sy’n credu bod ei ddata personol yn cael ei gadw o fewn y gwasanaeth hwn yr hawl i gyflwyno SAR (subect access request) i’r Weinyddiaeth Cyfiawnder dan Ddeddf Diogelu Data 1998." on the page
		And I see "Cliciwch ar y ddolen isod i gael rhagor o wybodaeth am y broses hon:" on the page
		And I see link with text "https://www.gov.uk/government/publications/request-your-personal-data-from-moj"
		And I click on the "https://www.gov.uk/government/publications/request-your-personal-data-from-moj" link
		And I see "personal-information-charter" in the URL
		Then I press the "back" button on my browser
		And I see "Ni fyddwn yn rhannu eich gwybodaeth gydag unrhyw asiantaeth arall oni bai fod hynny’n ofynnol at y dibenion canlynol:" on the page
		And I see "atal neu ganfod trosedd" on the page
		And I see "arestio neu erlyn troseddwyr" on the page
		And I see "atal terfysgaeth neu warchod diogelwch gwladol" on the page
		And I see "Byddwn yn rhannu eich gwybodaeth ble fo gofyniad yn y gyfraith i ni wneud hynny." on the page
		And I see "Ar wahân i’r wybodaeth bersonol y mae’r rhai sy’n defnyddio’r gwasanaeth yn ei chofnodi, rydym hefyd yn casglu gwybodaeth am ddefnydd o’r wefan sy’n ein galluogi i weld sut mae’r gwasanaeth yn cael ei ddefnyddio fel y gallwn ei wella. Nid yw’r wybodaeth hon yn cynnwys unrhyw ddata personol." on the page
		And I see "Byddwn ond yn casglu gwybodaeth a fydd yn ein cynorthwyo i wella'r gwefan ar eich cyfer; gwybodaeth a fydd yn ein galluogi i gysylltu â chi os ydych wedi gofyn inni wneud hynny, ein galluogi i roi gwybodaeth gywir ichi os byddwch ei hangen, a rhoi syniad inni am sut mae pobl yn defnyddio’r gwasanaeth hwn, er mwyn i ni barhau i’w wella." on the page
		And I see "Mae’n cynnwys:" on the page
		And I see "Cwestiynau, ymholiadau neu adborth rydych yn ei roi, gan gynnwys eich cyfeiriad e-bost, os ydych yn anfon neges trwy'r swyddogaeth adborth" on the page
		And I see "eich cyfeiriad IP, a manylion ynghylch pa fath o borwr y gwnaethoch ei ddefnyddio" on the page
		And I see "gwybodaeth ynghylch sut rydych yn defnyddio’r wefan, gan ddefnyddio cwcis a thechnegau tagio tudalen er mwyn ein helpu i wella’r wefan" on the page
		And I see "Mae hyn yn ein helpu i:" on the page
		And I see "wella’r wefan trwy fonitro sut rydych yn ei defnyddio" on the page
		And I see "ymateb i unrhyw adborth rydych yn ei roi inni, os ydych wedi gofyn am ymateb" on the page
		And I see "darparu gwybodaeth ichi am wasanaethau lleol os ydych eisiau’r wybodaeth" on the page
		And I see "Nid oes modd i ni eich adnabod trwy ddefnyddio eich data defnyddiwr safle." on the page
		And I see "Ble mae eich data’n cael ei storio" on the page
		And I see "Rydym yn storio eich data ar ein gweinyddion diogel yn y DU a’r Ardal Economaidd Ewropeaidd (EEA). Drwy gyflwyno eich data personol, rydych yn cytuno i hyn." on the page
		And I see "Cadw eich data’n ddiogel" on the page
		And I see "Yn gyffredinol, nid yw trosglwyddo gwybodaeth dros y rhyngrwyd yn hollol ddiogel, ac ni allwn warantu y bydd eich data’n ddiogel. Fodd bynnag, rydym yn defnyddio SSL (haen socedi diogel) i amgryptio'r holl ddata sy'n cael ei drosglwyddo i'n gweinydd ac allan ohono. Rydym yn cymryd diogelu data o ddifrif ac yn cymryd pob cam posib i sicrhau bod eich data yn aros yn breifat a diogel." on the page
		And I see "Trosglwyddo data - ar eich risg chi" on the page
		And I see "Mae gennym weithdrefnau a nodweddion diogelwch mewn lle i geisio cadw’ch data’n ddiogel wedi iddo’n cyrraedd." on the page
		And I see "Ni fyddwn yn rhannu eich gwybodaeth ag unrhyw sefydliad arall at ddibenion marchnata, ymchwil i’r farchnad na masnachol, ac nid ydym yn anfon eich manylion ymlaen i wefannau eraill." on the page
		And I see "Datgelu eich gwybodaeth" on the page
		And I see "Efallai y byddwn yn anfon eich gwybodaeth bersonol ymlaen os yw’n ddyletswydd gyfreithiol arnom i wneud hynny." on the page
		And I see "Sut rydym yn rheoli sesiynau" on the page
		And I see "Mae’r gwasanaeth hwn ar gyfer ymateb i lythyr Gwŷs Rheithgor Pan fyddwch yn gwneud hyn, efallai y bydd yn bosib i unrhyw un sydd â mynediad at y cyfrifiadur (neu ddyfais arall) rydych yn ei ddefnyddio weld gwybodaeth bersonol amdanoch chi." on the page
		And I see "Mae’ch data yn cael ei godi o gronfa ddata Rheithwyr GLlTEM o’r dudalen “Eich Manylion”, ac yn cael ei storio ar eich dyfais nes bod eich sesiwn yn dod i ben." on the page
		And I see "Deddf Diogelu Data 1998" on the page
		And I see "Mae’r gwasanaeth hwn yn cydymffurfio â holl egwyddorion Deddf Diogelu Data 1998. Y Weinyddiaeth Cyfiawnder yw’r ‘rheolwr data’ at ddibenion y Ddeddf. Defnyddir yr wybodaeth a roddwch i’r gwasanaeth at ddibenion rheoli’r broses gwysio rheithgor, ac mae’n cael ei storio mewn cronfa ddata ddiogel at bwrpasau archwilio nes eich bod wedi cwblhau eich gwasanaeth rheithgor. Ni fydd unrhyw ddata personol yn cael ei ddefnyddio wrth brofi’r gwasanaeth hwn." on the page
		And I see "Bydd gan ein gwesteiwr, a staff y Weinyddiaeth Cyfiawnder sy’n gyfrifol am gefnogi’r gwasanaeth hwn, fynediad at y gweinydd lle mae’r holl wybodaeth bersonol a gofnodir yn y gwasanaeth hwn yn cael ei storio." on the page
		And I see "Ymwrthodiad" on the page
		And I see "Nid ydym yn derbyn atebolrwydd am golled neu ddifrod sy’n dod i ran defnyddwyr y gwasanaeth hwn, naill ai’n uniongyrchol, yn anuniongyrchol neu’n ganlyniadol, pa un ai a yw’n cael ei achosi drwy gamwedd, tor-cytundeb neu fel arall. Mae hyn yn cynnwys colli incwm neu refeniw, busnes, elw neu gytundebau, arbedion a ragwelwyd, data, ewyllys da, eiddo diriaethol neu wastraff amser sy’n gysylltiedig â’r gwasanaeth hwn neu unrhyw wefannau sy’n gysylltiedig ag ef ac unrhyw ddeunydd sy’n cael ei bostio arno. Ni fydd yr amod hwn yn atal hawliadau am golled neu ddifrod i’ch eiddo diriaethol nac unrhyw hawliadau eraill am golled ariannol uniongyrchol nad ydynt wedi’i heithrio gan unrhyw rai o’r categorïau uchod." on the page
		And I see "Nid yw hyn yn effeithio ar ein hatebolrwydd am farwolaeth neu anaf personol sy’n codi o’n hesgeuluster, nac ar ein hatebolrwydd am gamliwio twyllodrus neu gamliwio mewn perthynas â mater sylfaenol, nac unrhyw atebolrwydd arall na ellir ei eithrio neu ei gyfyngu dan y gyfraith berthnasol." on the page
