*** Settings ***
Documentation    Suite description
Resource          ../../resources/imports.robot
Library     SeleniumLibrary
Library     String
Library     BuiltIn
Test Teardown  Close Browser

*** Variables ***
*** Test Cases ***

User Registration Using Authentication Code From Email
    [Tags]  positve
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
    [Tags]  positive
    Open Travelbook Web And Maximize Window
    ${email}        Entered Email Should Be Displayed
    Displayed Email Should Be Correct       ${email}
    Authentication Email Should Be Sent
    User Should Be Authenticated Using Link
    Password Setting Fields Should Be Displayed
    New Password Should Be Created
    Should Go To Landing Page In Logged In Status

User Registration With No Email Entered
    [Tags]  negative
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Click Register Button
    Registration Error Message Should Be Displayed
    Close Browser

User Registration Using Registered Email
    [Tags]  negative
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Registered Email Should Not Be Accepted
    Registration Error Message Should Be Displayed
    Close Browser

User Registration Using Invalid Email
    [Tags]  negative
    Open Travelbook Web And Maximize Window
    Go To User Registration Page
    User Registration Fields Should Be Visible
    Invalid Email Format Should Not Be Accepted
    User Should Not Be Able To Proceed To User Authentication



*** Keywords ***





