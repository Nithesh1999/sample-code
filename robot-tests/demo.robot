*** Settings ***
Library    SeleniumLibrary
Library    XML
Suite Teardown    Close All Browsers
Test Teardown    Capture Page Screenshot

*** Variables ***
${URl}    https://www.saucedemo.com/
${Browser}    Edge
${Username}    standard_user
${Password}    secret_sauce
${Addtocart}    //button[@name="add-to-cart-sauce-labs-backpack"]
${Cart}    //a[@class="shopping_cart_link"]



*** Keywords ***
Demo Keyword
    Set Selenium Speed    1.5s
     Wait Until Page Contains    Swag Labs
    #Select From List By Index    class=product_sort_container    2
    Click Element    ${Addtocart} 
    Click Element    ${Cart}
    Wait Until Keyword Succeeds    10s    1s    Page Should Contain    Your Cart
    Click Button    id=remove-sauce-labs-backpack
    Click Button    id=continue-shopping
    Click Element    id=react-burger-menu-btn
    Click Element    id=logout_sidebar_link


*** Test Cases ***
Login to sample Website
    Set Selenium Implicit Wait    2s
    Open Browser    ${URl}    ${Browser}
    Maximize Browser Window
    Wait Until Element Is Visible    id=user-name    timeout=10s
    Input Text    id=user-name    ${Username}
    Input Text    id=password    ${Password}
    Click Button    id=login-button
    Demo Keyword




