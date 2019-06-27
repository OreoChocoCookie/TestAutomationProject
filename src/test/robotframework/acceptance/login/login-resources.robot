*** Settings ***
Library           SeleniumLibrary


*** Keywords ***
Error Message Should Be Displayed on Invalid Login
  Go To     https://dv01.travelbook.ph/users/login/
  Input Email      invalidusername@gmail.com
  Input Password   invalidPassword
  Click Login Button
  ${status}   ${value}  Run Keyword And Ignore Error   Element Should Be Visible   css=.errorMessage1
  Element Text Should Be      css=.errorMessage div    Not recognized. Email address or password is incorrect.