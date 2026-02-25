Feature: ELEC Mark LA as Inactive

@JurorTransformation
Scenario Outline: Mark LA as Inactive
  
  Given I am on "Bureau" "test"

  Given all ER Local Authorities are set to active new schema

  And I log in as "<user>"

  And I press the "Apps" button
  And I click on the "Electoral register" link

  Then I see "/electoral-register" in the URL
  And I see "Dashboard" on the page
  And the number of required LAs in the donut matches the number of active LAs
  
  When I filter on Local Authority "<localAuth>"
  Then the Local Authority returned in the results matches "<localAuth>"
  
  When I click on the "<localAuth>" link
  Then I see link with text "Mark as inactive"
  
  When I click on the "Mark as inactive" link
  Then I see "Mark authority as inactive" on the page
  And I see "<localAuth>" on the page
  And I see "Inactive authorities will not be required to upload data in future cycles." on the page

  #no reason entered
  When I press the "Mark as inactive" button
  Then I see error "Enter a reason for deactivating the local authority"

  #too many chars
  When I set text area with "id" of "inactiveReason" to "mm semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitavarius laoreet. Quisque rutrum. Aeneaniet. Etiam ultrici. Curabitur ullamcorper ultricie, tet condddddddm quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
  And I press the "Mark as inactive" button
  Then I see error "The deactivation reason must be 2000 characters or fewer"

  When I set text area with "id" of "inactiveReason" to "some reasons here"
  And I press the "Mark as inactive" button
  Then I see "Authority marked as inactive" on the page
  And I see link with text "Mark as active"
  
  When I click on the "Back" link
  Then I do not see "<localAuth>" on the page
  And the number of required LAs in the donut matches the number of active LAs

  When I filter on Local Authority "<localAuth>"
  Then I see "Authority marked as inactive" on the page
  And I see "some reasons here" on the page
  And I see link with text "Mark as active"
  And I do not see link with text "Mark as inactive"
  And I do not see link with text "Send email reminder"
  And I do not see link with text "Reminder history"

  Examples:
    | user          | localAuth |
    | MODTESTBUREAU | Eastleigh |