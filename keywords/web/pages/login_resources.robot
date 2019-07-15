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

Go To Page
	[Arguments]     ${page}
	Go To   ${web}/${page}

Input Email
	[Arguments]   ${USERNAME}
	Input Text    ${login_email_field}    ${USERNAME}

Input Password
	[Arguments]   ${PASSWORD}
	Input Text    ${login_password_field}   ${PASSWORD}

Click Login Button
	Click Element   ${login_button}

