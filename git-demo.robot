*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close Browser
Test Teardown     Capture Page Screenshot

*** Variables ***
${URL}         https://www.saucedemo.com/
${USERNAME}    visual_user
${PASSWORD}    secret_sauce
${BROWSER}    Edge
${Add_to_cart}    //button[@id="add-to-cart-sauce-labs-backpack"]  
${Cart}    //a[@class="shopping_cart_link"]  
${Remove_Cart}    remove-sauce-labs-backpack

*** Keywords ***

*** Test Cases ***
Login To Sample Website
    Set Selenium Implicit Wait    2s
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible    id=user-name    timeout=10s
    Input Text    id=user-name    ${USERNAME}
    Input Text    id=password    ${PASSWORD}
    Click Button    id=login-button
    Wait Until Page Contains    Swag Labs    timeout=10s
    Select From List By Index    class=product_sort_container    2
    Click Element    ${Add_to_cart}
    Click Element    ${Cart} 
    Wait Until Keyword Succeeds    10s    1s    Page Should Contain    Your Cart
    Click Element    ${Remove_Cart}
    Click Element   id=continue-shopping
    Click Element    id=react-burger-menu-btn
    Click Element    id=logout_sidebar_link