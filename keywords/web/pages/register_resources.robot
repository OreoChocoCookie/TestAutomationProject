*** Settings ***
Library     SeleniumLibrary
Library     String
Library     BuiltIn
*** Variables ***
${email}
*** Keywords ***
Go To User Registration Page
    Go To Page  users/register

User Registration Fields Should Be Visible
    Element Should Be Visible       ${register_user_tab}
    Element Should Be Visible       ${register_email_field}
    Element Should Be Visible       ${register_button}

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
    Set Global Variable     ${email}
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

Authentication Email Should Be Sent
    ${entered_email}    Get Text        ${registered_email_text}
    ${get_email_text}   Fetch From Left     ${entered_email}        @mailinator.com
    Open Browser        https://www.mailinator.com/v3/index.jsp?zone=public&query=${get_email_text}#/#msgpane       chrome
    Click Element       ${authentication_email_tab}

Authentication Code Should Be Displayed
    Select Frame        ${mail_body_iframe}
    Wait Until Page Contains Element   ${email_authentication_code}
    Element Should Be Visible       ${email_authentication_code}

Authentication Code Should Be Accepted
    ${validationCodeText}    Get Text     ${email_authentication_code}
    ${validationCode}    Fetch From Right    ${validationCodeText}   Validation Code:
    ${stripValidationCode}   Strip String  ${SPACE}${validationCode}
    Close Browser
    Switch Browser      MAIN
    Input Text      ${authentication_code_field}        ${stripValidationCode}
    Click Element   ${submit_authentication_code_button}

Password Setting Fields Should Be Displayed
    Element Should Be Visible   ${new_password_field}
    Element Should Be Visible   ${repeat_password_field}
    Element Should Be Visible   ${create_password_button}

New Password Should Be Created
    Input Text   ${new_password_field}      hellotb123
    Input Text   ${repeat_password_field}   hellotb123
    Click Element       ${create_password_button}

Should Go To Landing Page In Logged In Status
    Element Should Be Visible       ${email_text_link}
    ${email_text}   Fetch From Left       ${email}      @mailinator.com
    ${email_text_header}        Get Text      ${email_text_link}
    Should Be Equal     ${email_text}      ${email_text_header}
    Close Browser

User Should Be Authenticated Using Link
    Select Frame        ${mail_body_iframe}
    Wait Until Element Is Visible       ${email_authentication_code}
    ${validationCodeText}    Get Text     ${email_authentication_code}
    ${validationCode}    Fetch From Right    ${validationCodeText}   Validation Code:
    ${stripValidationCode}   Strip String  ${SPACE}${validationCode}
    Click Element    css=a[href="https://www.mailinator.com/key/url?url=https%3A//dv01.travelbook.ph/ji/pc/jit2001.do%3Ffn%3DvC%26frVC%3D${stripValidationCode}"]
    Select Window       NEW
    Maximize Browser Window

Registration Error Message Should Be Displayed
    Element Should Be Visible       ${registration_error_message}

Registered Email Should Not Be Accepted
    Input Text      ${register_email_field}     travelbooktest675@gmail.com
    Double Click Checkbox
    Click Element       ${register_button}

Invalid Email Format Should Not Be Accepted
    Input Text      ${register_email_field}     travelbooktest675@
    Double Click Checkbox
    Click Element       ${register_button}
