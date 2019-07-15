*** Settings ***
Documentation    Suite description
Resource          ../../resources/imports.robot

*** Test Cases ***
Test title
    [Tags]    DEBUG
    ${status}   ${message}  run keyword and ignore error    Check Element For Text


*** Keywords ***

Check Element For Text
   ${elements}=    Get Text    //span[@class='myclass']
    :FOR    ${element}    IN    @{elements}
    \   Log    ${element.text}

