Feature: ELEC  JS-731

  @JurorTransformation
  Scenario Outline: As a local Authority I want to know the rules for uploading data in the Juror ER app

    Given I am on "Er" "test"

    And I log in to ER as "<user>"

    And I click on the "Upload guidance" link

    Then I see "File upload guidance" on the page
    And I see "File type" on the page
    And I see "We accept the following file types:" on the page
    And I see "Comma Separated Values - Preferred" on the page
    And I see "Text file" on the page
    And I see "Excel spreadsheet" on the page
    And I see "Compressed archive containing any of the above" on the page
    And I see "Use CSV files where possible for electoral data." on the page
    And I see "File format" on the page
    And I see "We can process electoral register data from the following electoral management systems:" on the page
    And I see "Express" on the page
    And I see "Strand" on the page
    And I see "Halarose" on the page
    And I see "Xpress Software Solutions" on the page
    And I see "Other compatible formats" on the page
    And I see "If you are unsure whether your system format is compatible, contact the Jury Central Summoning Bureau before uploading." on the page
    And I see "Over 76's flag" on the page
    And I see "If your electoral management system includes an 'Over 76's' flag or marker, ensure this is included in your data file. This helps identify electors who are not required to serve on a jury." on the page
    And I see "Other markers" on the page
    And I see "Your file may include other markers or flags that identify specific elector types. Common markers include:" on the page
    And I see "a - European elector" on the page
    And I see "b - Overseas elector" on the page
    And I see "f - Peer" on the page
    And I see "Include all markers present in your electoral register data. If your system uses different marker codes, contact the Jury Central Summoning Bureau for guidance." on the page
    And I see "Important information about ZIP files" on the page
    And I see "If you are using a ZIP file format to upload your data, note the following:" on the page
    And I see "ZIP files must only contain:" on the page
    And I see "CSV files" on the page
    And I see "TXT files" on the page
    And I see "XLS or XLSX files" on the page
    And I see "ZIP files must not contain:" on the page
    And I see "XML files" on the page
    And I see "HTML files" on the page
    And I see "Outlook files (.msg, .eml)" on the page
    And I see "These file types cannot be processed and will cause your upload to be rejected." on the page
    And I see "ZIP files must not be password protected. The portal will no longer accept password protected files." on the page
    And I see "Contact details" on the page
    And I see "Jury Central Summoning Bureau" on the page
    And I see "jurysummoning@justice.gov.uk" on the page
    And I see "Telephone: 0300 456 1024" on the page
    And I see "Monday to Thursday, 9am to 5pm" on the page
    And I see "Friday, 9am to 3pm" on the page
    And I see "Closed on bank holidays" on the page

    Examples:
      | user                       |
      | test_user1@localauthority2 |