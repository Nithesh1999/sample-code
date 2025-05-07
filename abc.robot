*** Settings ***
Library           SeleniumLibrary
Test Setup    Open Browser And Maximize
Test Teardown    Close All Browsers

*** Variables ***
${LOGIN_URL}      https://the-internet.herokuapp.com/login
${USERNAME_FIELD}    id=username
${PASSWORD_FIELD}    id=password
${VALID_USERNAME_DT}    tomsmith
${VALID_PASSWORD_DT}    SuperSecretPassword!
${INVALID_USERNAME_DT}    tomsmith12
${INVALID_PASSWORD_DT}    SecretPassword!
${LOGIN_BUTTON}      css:button[type="submit"]
${SUCCESS_MSG}       id=flash
${Browser}    Chrome
${EMPTY}    

*** Keywords ***
Open Browser And Maximize
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window

*** Test Cases ***
Valid Username And Valid Password
    [Documentation]    Check Positive login Scenario 
    [Tags]    1   
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD_DT} 
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    You logged into a secure area!

Invalid Username And Valid Password
    Input Text    ${USERNAME_FIELD}    ${INVALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!

Valid Username And Invalid Password
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your password is invalid!

Invalid Username And Invalid Password
    Input Text    ${USERNAME_FIELD}    ${INVALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!

Blank Username And Blank Password
    Input Text    ${USERNAME_FIELD}    ${EMPTY}        
    Input Text    ${PASSWORD_FIELD}    ${EMPTY} 
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!


Blank Username And Valid Password
    Input Text    ${USERNAME_FIELD}    ${EMPTY}    
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!


Valid Username And Blank Password
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${EMPTY}    
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your password is invalid!

Special Characters In Username And Password
    Input Text    ${USERNAME_FIELD}    !@#$%^&*()
    Input Text    ${PASSWORD_FIELD}    !@#$%^&*()
    Click Button    ${LOGIN_BUTTON}
    Sleep    2s
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!
