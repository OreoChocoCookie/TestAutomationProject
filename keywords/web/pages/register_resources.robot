*** Settings ***
Library     SeleniumLibrary
Library     String
Library     BuiltIn
*** Keywords ***
Entered Email Should Be Displayed
    Go To Page  users/register
    ${email}        Enter Email To Be Registered
    Double Click Checkbox
    Click Register Button
    Element Should Be Visible       ${registered_email_container}
    [Return]    ${email}

Generate Email
    [Arguments]     ${length}
    ${randomstring}   Generate Random String  ${length}   [LETTERS]
    ${email}    Catenate    SEPARATOR=   ${randomstring}   @mailinator.com
    [Return]    ${email}

Enter Email To Be Registered
    ${email}        Generate Email  8
    Input Text      ${register_email_field}    ${email}
    [Return]    ${email}

Double Click Checkbox
    Select Checkbox     ${register_termsandconditions_checkbox}
    Select Checkbox     ${register_termsandconditions_checkbox}

Click Register Button
    Click Element       ${register_button}


Displayed Email Should Be Correct
    [Arguments]     ${new_email}
    ${entered_email}    Get Text        ${registered_email_text}
    Should Be Equal     ${entered_email}        ${new_email}
    [Return]        ${new_email}

Authentication Code Should Be Sent
    ${entered_email}    Get Text        ${registered_email_text}
    ${get_email_text}   Fetch From Left     ${entered_email}        @mailinator.com
    Open Browser        https://www.mailinator.com/v3/index.jsp?zone=public&query=${get_email_text}#/#msgpane       chrome
    Click Element       ${authentication_email_tab}

Get Authentication Code
    Select Frame        ${mail_body_iframe}
    Wait Until Page Contains Element   css=tbody tr:nth-child(3)
    Element Should Be Visible       css=tbody tr:nth-child(3)
    ${validationCodeText}    Get Text     css=tbody tr:nth-child(3)
    ${validationCode}    Fetch From Right    ${validationCodeText}   Validation Code:
    ${stripValidationCode}   Strip String  ${SPACE}${validationCode}
    Close Browser
    [Return]        ${stripValidationCode}

Authentication Code Should Be Accepted
    Input Text   id=inputVerificationCode    ${stripValidationCode}

