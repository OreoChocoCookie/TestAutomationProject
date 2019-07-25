*** Settings ***
Library     SeleniumLibrary
Library     String
Library     BuiltIn
*** Keywords ***
Generate Email
    [Arguments]     ${length}
    ${randomstring}   Generate Random String  ${length}   [LETTERS]
    ${email}    Catenate    SEPARATOR=   ${randomstring}   @mailinator.com
    [Return]    ${email}

Enter Email To Be Registered
    ${email}    Generate Email  8
    Input Text      ${register_email_field}    ${email}

Double Click Checkbox
    Select Checkbox     ${register_termsandconditions_checkbox}
    Select Checkbox     ${register_termsandconditions_checkbox}

Click Register Button
    Click Element       ${register_button}

Entered Email Should Be Displayed
    Element Should Be Visigit sble       ${registered_email_container}

Displayed Email Should Be Correct
    ${entered_email}    Get Text        ${registered_email}
    Should Be Equal     ${entered_email}        ${email}
