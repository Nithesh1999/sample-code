*** Settings ***
Library           SeleniumLibrary
Test Setup    Open Browser    ${LOGIN_URL}    ${Browser}
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
${Browser}    Edge
${EDGE_DRIVER_PATH}         C:/Program Files (x86)/Microsoft/Edge/Application/msedgedriver.exe


*** Keywords ***
Launch Edge Headless
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys, selenium.webdriver
    Call Method    ${options}    use_chromium    True
    Call Method    ${options}    add_argument    --headless
    Call Method    ${options}    add_argument    --disable-gpu
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --disable-dev-shm-usage
    Open Browser   ${LOGIN_URL}    ${Browser}    executable_path=${EDGE_DRIVER_PATH}    options=${options}


*** Test Cases ***
Valid Username And Valid Password
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD_DT} 
    Click Button    ${LOGIN_BUTTON}
    Element Should Contain    ${SUCCESS_MSG}    You logged into a secure area!

Invalid Username And Valid Password
    Input Text    ${USERNAME_FIELD}    ${INVALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${VALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!

Valid Username And Invalid Password
    Input Text    ${USERNAME_FIELD}    ${VALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Element Should Contain    ${SUCCESS_MSG}    Your password is invalid!

Invalid Username And Invalid Password
    Input Text    ${USERNAME_FIELD}    ${INVALID_USERNAME_DT}
    Input Text    ${PASSWORD_FIELD}    ${INVALID_PASSWORD_DT}
    Click Button    ${LOGIN_BUTTON}
    Element Should Contain    ${SUCCESS_MSG}    Your username is invalid!
