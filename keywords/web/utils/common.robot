*** Settings ***
Resource    ../../../resources/imports.robot

*** Keywords ***
Open Other Browsers
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}   browser=${browser}
    Maximize Browser Window

Open Chrome Headless Browser
    [Arguments]    ${url}
    [Documentation]    Open Chrome Browser with headless mode
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    ${url}

Set Chrome Options
    [Documentation]    Set Chrome Options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    : FOR    ${option}    IN    @{chrome_options}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}

Clear Browser Cookies
    Delete All Cookies

Open Travelbook Web And Maximize Window
    Open Browser    ${web}    chrome
    Maximize Browser Window

Go To Page
	[Arguments]     ${page}
	Go To   ${web}/${page}