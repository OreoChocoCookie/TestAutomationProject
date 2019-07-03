*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library    String
Library     BuiltIn

*** Variables ***
${useremail}    tbtest03@gmail.com
*** Test Cases ***
Valid Email Registration
    [Tags]    positive
   Open Browser     https://dv01.travelbook.ph    chrome    alias=tbtab
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
   Open Browser     https://www.mailinator.com/v3/index.jsp?zone=public&query=${randomstring}#/#msgpane    chrome    alias=mailtab
   Click Element    css=tr[ng-repeat='email in emails']
   Select Frame     id=msg_body
   [Teardown]  Close All Browsers

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

*** Keywords ***

Generate Email
    [Arguments]     ${length}
    ${randomstring}   Generate Random String  ${length}   [LETTERS]
    ${email}    Catenate    	SEPARATOR=   ${randomstring}   @mailinator.com
    [Return]    ${email}    ${randomstring}



