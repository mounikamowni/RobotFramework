*** Settings ***

Library       SeleniumLibrary
Resource       ../libraries/page_library.py    

# Library       ../libraries/page_library.py 


*** Variables ***
${CONFIG_FILE}    config.json
${BASE_URL}    ${EMPTY}
${BROWSER}    Edge
${FIRSTNAME}  Mownika
${LASTNAME}   Garigipati
${USERID}   mownikagarigipati
${BIRTHDAY_DAY}         15
${BIRTHDAY_MONTH}       January
${BIRTHDAY_YEAR}        1992
${MONTH_DROPDOWN}       id=usernamereg-month
${YEAR_DROPDOWN}        id=usernamereg-year
${DAY_BUTTON}           id=usernamereg-day
${MOBILE_INPUT}         id=usernamereg-phone
${MOBILE_NUMBER}        9035167264
${EMAIL_SERVER}         imap.mail.yahoo.com
${EMAIL_USER}           mownikagarigipati@yahoo.com
${EMAIL_PASS}           mownikagarigipati
${OTP_SUBJECT_FILTER}   Yahoo Account OTP



*** Keywords ***

Select Birthdate Month
    [Arguments]    ${month}
    Select From List By Value    ${MONTH_DROPDOWN}    ${month}

Select Birthdate Year
    [Arguments]    ${year}
    Select From List By Value    ${YEAR_DROPDOWN}    ${year}

Select Birthdate Day
    [Arguments]    ${day}
    Select From List By Value    ${DAY_BUTTON}    ${BIRTHDAY_DAY}

Input Mobile Number
    [Arguments]    ${mobile_number}
    Input Text    ${MOBILE_INPUT}    ${mobile_number}

*** Test Cases ***
Create Yahoo Finance Account
    Open Browser    https://finance.yahoo.com/    ${BROWSER}
    Maximize Browser Window
    # PageLibrary.click_sign_in
    Wait Until Page Contains Element    id=login-container    10s
    Click Element                       id=login-container
    Click Element                       id=createacc
    Input Text                          id=usernamereg-firstName    ${FIRSTNAME}
    Input Text                          id=usernamereg-lastName     ${LASTNAME}
    Input Text                          name=userId     ${USERID}
    Input Text                          id=password-container     ${USERID}
    Select Birthdate Month    ${BIRTHDAY_MONTH}
    Select Birthdate Year     ${BIRTHDAY_YEAR}
    Select Birthdate Day      ${BIRTHDAY_DAY}
    Click Element                       id=reg-submit-button
    Input Mobile Number    ${MOBILE_NUMBER}
    Click Element                       id=reg-whatsapp-button

# Wait for OTP email
    ${otp_handler}=    Create Library    libraries.otp_handler.OTPHandler    ${EMAIL_SERVER}    ${EMAIL_USER}    ${EMAIL_PASS}
    ${otp}=    Call Method    ${otp_handler}    get_otp_from_email    ${OTP_SUBJECT_FILTER}
    Log    OTP: ${otp}

    # Enter OTP and submit
    Input Text                            id=verification-code-field    ${otp}
    Click Button                          id=verify-code-button

   
    Close Browser