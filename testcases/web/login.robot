*** Settings ***
Documentation     Test Travelbook Login Funtionalities
Resource          ../../resources/imports.robot
Test Setup      Open Travelbook Web And Maximize Window


*** Test Cases ***
Verify Login UI
   [Tags]  smoke regression  login
   Go To Login Page
   Email and Password Text Fields Should Be Displayed
   Login Button Should Be Displayed
   Forgot Password Link Should Be Displayed
   Remember Me Checkbox Should Be Displayed
   Social Media Buttons Should Displayed

Verify Login Functionality
   [Tags]  smoke regression  login
   Error Message Should Be Displayed on Invalid Login
   A Valid Account Can Login To Website     ${TESTUSER}      ${PASSWORD}
   User Can Login Using Google Account
   [Teardown]     Close Browser


*** Keywords ***
Go To Login Page
    Go To Page      users/login

User Can Login Using Google Account
    Clear Browser Cookies
    Go To       ${web}/users/login
    Sleep  5s
    Click Element       ${login_google_img}
    Select Window       NEW
    Enter Google Account Credentials         ${TEST_GMAIL}      ${TESTGMAIL_PASSWORD}
    Select Window       MAIN
    Wait Until Element Is Visible    ${login_nav_welcome}
    Element Should Be Visible       ${login_nav_welcome}

Enter Google Account Credentials
    [Arguments]     ${gmail}    ${gmail_password}
    Run Keyword And Continue On Failure     Input Text         ${gmail_email_field}      ${gmail}
    Click Element      ${gmail_email_next_cta}
    Wait Until Element Is Visible    ${gmail_pword_field}
    Input Text          ${gmail_pword_field}      ${gmail_password}
    Click Element       ${gmail_password_next_cta}


Remember Me Checkbox Should Be Displayed
    Element Should Be Visible   ${login_rememberme_checkbox}

Email and Password Text Fields Should Be Displayed
    Element Should Be Visible   ${login_email_field}
    Element Should Be Visible   ${login_password_field}

Login Button Should Be Displayed
    Element Should Be Visible     ${login_button}

Forgot Password Link Should Be Displayed
    Element Should Be Visible      ${login_forgot_password_link}
    Click Element                  ${login_forgot_password_link}
    Wait Until Element Is Visible  ${forgot_password_iframe}
    Element Should Be Visible      ${forgot_password_iframe}
    Click Element                  ${forgot_password_modal}

Social Media Buttons Should Displayed
    Element Should Be Visible     ${login_fb}
    Element Should Be Visible     ${login_google}

A Valid Account Can Login To Website
    [Arguments]       ${EMAIL}     ${PASSWORD}
    Go To             https://dv01.travelbook.ph/users/login
    Login To Website   ${EMAIL}     ${PASSWORD}
    Element Should Be Visible       ${login_nav_welcome}

Error Message Should Be Displayed on Invalid Login
    #Go To     ${web}
    Login To Website    invalidusername@gmail.com       invalidPassword
    ${status}   ${value}  Run Keyword And Ignore Error   Element Should Be Visible   css=.errorMessage1
    Element Text Should Be      css=.errorMessage div    Not recognized. Email address or password is incorrect.
