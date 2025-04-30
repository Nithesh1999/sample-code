*** Settings ***
Library    SeleniumLibrary
Resource    C:\Users\somalaraju.nithesh\robot-tests\Variables.robot
Test Teardown    Close All Browsers
Suite Teardown    Capture Page Screenshot

*** Variables ***
${URL}    https://www.saucedemo.com/
${Browser}    Edge
${USERNAME}    performance_glitch_user
${Password}    secret_sauce
${Addtocart}    //button[@id="add-to-cart-sauce-labs-onesie"]
${Cart}    //a[@class="shopping_cart_link"]
${RemoveBtn}    //button[@name="remove-sauce-labs-onesie"]


*** Test Cases ***
Demo
    Set Selenium Implicit Wait    2s
    Open Browser    ${URL}    ${Browser}
    Sample login Page

*** Keywords ***

Sample login Page
    Maximize Browser Window
    Wait Until Element Is Visible    id=user-name    timeout=10s
    Input Text    id=user-name    ${USERNAME}
    Input Text    id=password    ${Password} 
    Click Button    id=login-button
    Wait Until Page Contains    Swag Labs
    Select From List By Index    class=product_sort_container    2
    Click Element    ${Addtocart}
    Click Element    ${Cart}
    Wait Until Keyword Succeeds    10s    2s    Page Should Contain    Your Cart    
    Click Element    ${RemoveBtn}
    Click Element    id=continue-shopping
    Click Element    id=react-burger-menu-btn
    Click Element    id=logout_sidebar_link
    Sleep    5s
    