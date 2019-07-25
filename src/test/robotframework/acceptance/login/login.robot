*** Settings ***
Library           SeleniumLibrary
Resource          login-resources.robot
Library     SeleniumLibrary

*** Test Cases ***
Verify Login UI
    [Tags]  regression
    Open Browser To Login Page
    Email and Password Text Fields Should Be Displayed
    Login Button Should Be Displayed
    Forgot Password Link Should Be Displayed
    Social Media Buttons Should Displayed

Verify Login Functionality
  [Tags]  smoke regression  login
  Valid Login
  Error Message Should Be Displayed on Invalid Login
  [Teardown]  Close Browser


*** Keywords ***
Email and Password Text Fields Should Be Displayed
  Element Should Be Visible   id=inputEmail1
  Element Should Be Visible   id=inputPassword1

Login Button Should Be Displayed
  Element Should Be Visible     css=input[type="submit"]

Forgot Password Link Should Be Displayed
    Element Should Be Visible     css=a[data-target="#forgotPasswordDialog"]
    Click Element     css=a[data-target="#forgotPasswordDialog"]
    Wait Until Element Is Visible     id=forgotPasswordContent
    Element Should Be Visible     id=forgotPasswordContent
    Click Element   id=forgotPasswordDialog

Social Media Buttons Should Displayed
      Element Should Be Visible     id=fb
      Element Should Be Visible     id=ggl



Valid Login
  Input Email    hannoj@gmail.com
  Input Password    testing123
  Click Login Button
  Element Should Be Visible     css=li.nav-welcome
  Logout To Website


Logout To Website
    Click Element     css=.nav-welcome a[href="https://dv01.travelbook.ph/users/logout/"]

Open Browser To Login Page
    Open Browser    https://dv01.travelbook.ph    chrome
    Click Element   css=div.main-header a[href="https://dv01.travelbook.ph/users/login/"]

Input Email
    [Arguments]   ${USERNAME}
    Input Text    id=inputEmail1    ${USERNAME}

Input Password
    [Arguments]   ${PASSWORD}
    Input Text    id=inputPassword1   ${PASSWORD}

Click Login Button
    Click Element   css=input[type="submit"]
