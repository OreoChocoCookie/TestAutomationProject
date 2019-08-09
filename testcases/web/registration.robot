*** Settings ***
Documentation    Suite description
Resource          ../../resources/imports.robot
Library     SeleniumLibrary
Library     String
Library     BuiltIn

*** Variables ***
*** Test Cases ***
Valid Email Registration
    [Tags]    positive
   ${firstBrowserIndex}     Open Browser     https://dv01.travelbook.ph    chrome    alias=tbtab
   Click Element    css=div.main-header a[href="https://dv01.travelbook.ph/users/login/"]
   Element Should Be Visible  css=.nav-tabs a[href="https://dv01.travelbook.ph/users/register/"]
   Click Element    css=.nav-tabs a[href="https://dv01.travelbook.ph/users/register/"]
   ${email}     ${randomstring}     Generate Email  8
   Input Text       id=inputEmail1  ${email}
   Select Checkbox   css=input[type="Checkbox"]
   Select Checkbox   css=input[type="Checkbox"]
   Click Element    css=input[value='Register']
   Element Should Be Visible    id=jiw-validation-div
   ${enteredEmail}  Get Text    css=.jiw-validation-indent strong
   should be equal  ${email}    ${enteredEmail}
   ${secondBrowserIndex}    Open Browser     https://www.mailinator.com/v3/index.jsp?zone=public&query=${randomstring}#/#msgpane    chrome    alias=mailtab
   Click Element    css=tr[ng-repeat='email in emails']
   Select Frame     id=msg_body
   Wait Until Page Contains Element   css=tbody tr:nth-child(3)
   Element Should Be Visible     css=tbody tr:nth-child(3)
   ${validationCodeText}    Get Text     css=tbody tr:nth-child(3)
   ${validationCode}    fetch from right    ${validationCodeText}   Validation Code:
   Close Browser
   Switch Browser   ${firstBrowserIndex}
   Maximize Browser Window
   ${stripValidationCode}   strip string  ${SPACE}${validationCode}
   Input Text   id=inputVerificationCode    ${stripValidationCode}
   Click Element    css=input[value='Submit']
   Element Should Be Visible    css=.jiw-ch-pw-indent label:nth-child(3)
   Element Should Be Visible    css=.jiw-label strong
   ${enteredEmail2}     Get Text     css=.jiw-label strong
   should be equal  ${enteredEmail}     ${enteredEmail2}
   Element Should Be Visible    css=.form-group input:nth-child(2)
   Element Should Be Visible    css=.form-group input:nth-child(5)
   Element Should Be Visible    css=.orange-btn
   Input Password   css=.form-group input:nth-child(2)      hellotb123
   Input Password   css=.form-group input:nth-child(5)      hellotb123
   Click Element    css=.orange-btn
   ${emailName}    fetch from left    ${enteredEmail2}   @mailinator.com
   Element Should be Visible     css=div.main-header a[href="https://dv01.travelbook.ph/account/users/manage_bookings/"]
   ${welcomeEmail}   Get Text    css=div.main-header a[href="https://dv01.travelbook.ph/account/users/manage_bookings/"]
   should be equal  ${emailName}    ${welcomeEmail}
   [Teardown]  Close Browser


No Email Entered
    [Tags]    negative
   Click Element    css=div.main-header a[href="https://dv01.travelbook.ph/users/login/"]
   Element Should Be Visible  css=.nav-tabs a[href="https://dv01.travelbook.ph/users/register/"]
   Click Element    css=.nav-tabs a[href="https://dv01.travelbook.ph/users/register/"]
   Select Checkbox   css=input[type="Checkbox"]
   Select Checkbox   css=input[type="Checkbox"]
   Click Element    css=input[value='Register']
   Element Should Be Visible    css=.errorMessage
   [Teardown]  Close Browser

User Registration Using Authentication Code From Email
    [Tags]  code
    Open Travelbook Web And Maximize Window
    ${email}        Entered Email Should Be Displayed
    Displayed Email Should Be Correct       ${email}
    Authentication Email Should Be Sent
    Authentication Code Should Be Displayed
    Authentication Code Should Be Accepted
    Password Setting Fields Should Be Displayed
    New Password Should Be Created
    Should Go To Landing Page In Logged In Status

User Registration Using Authentication Link From Email
    [Tags]  link
    Open Travelbook Web And Maximize Window
    ${email}        Entered Email Should Be Displayed
    Displayed Email Should Be Correct       ${email}
    Authentication Email Should Be Sent
    User Should Be Authenticated Using Link
    Password Setting Fields Should Be Displayed
    New Password Should Be Created
    Should Go To Landing Page In Logged In Status

User Registration With No Email Entered
    [Tags]  noemailentered
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Click Register Button
    Registration Error Message Should Be Displayed
    Close Browser

User Registration Using Registered Email
    [Tags]  registeredemail
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Registered Email Should Not Be Accepted
    Registration Error Message Should Be Displayed
    Close Browser

User Registration Using Invalid Email
    [Tags]  invalidemail
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Invalid Email Format Should Not Be Accepted
    Registration Error Message Should Be Displayed



*** Keywords ***





