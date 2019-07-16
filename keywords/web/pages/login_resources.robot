*** Settings ***
Resource    ../../../resources/imports.robot
Variables   ../locators.yaml

*** Keywords ***
Login To Website
	[Arguments]       ${EMAIL}     ${PASSWORD}
	Input Email    ${EMAIL}
	Input Password    ${PASSWORD}
	Click Login Button

Logout To Website
	Click Element       ${logout_link}


Input Email
	[Arguments]   ${USERNAME}
	Input Text    ${login_email_field}    ${USERNAME}

Input Password
	[Arguments]   ${PASSWORD}
	Input Text    ${login_password_field}   ${PASSWORD}

Click Login Button
	Click Element   ${login_button}

Go To Login Page
    Go To Page      users/login

Login Setup
    Open Travelbook Web And Maximize Window
    Go To Login Page
