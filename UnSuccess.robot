*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${CHROME_BROWSER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chrome-win64${/}chrome.exe
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}ChromeForTesting${/}chromedriver-win64${/}chromedriver.exe
${SERVER}    localhost:7272
${URL}    http://${SERVER}/Lab4/Registration.html
${FNAME}    Somyod
${LNAME}    Sodsai
${ORGANIZATION}    CS KKU
${EMAIL}    somyod@kkumail.com
${PHONE}    091-001-1234
${INVALIDPHONE}    go;[s;sd/[sf]]



*** Keywords ***
Open Chrome For Testing
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Evaluate    setattr($options, "binary_location", r"${CHROME_BROWSER_PATH}")
    ${service}=    Evaluate    sys.modules["selenium.webdriver.chrome.service"].Service(executable_path=r"${CHROME_DRIVER_PATH}")    sys
    Create Webdriver    Chrome    options=${options}    service=${service}
Open Workshop Registration Page
    Open Chrome For Testing
    Go To    ${URL}

*** Test Cases ***
Open Workshop Registration Page
    Open Chrome For Testing
    Capture Page Screenshot    docs/Open_Regis_Success.png
    Close Browser

Empty First Name
    Open Workshop Registration Page
    Input Text    id=lastname    ${LNAME}
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=email    ${EMAIL}
    Input Text    id=phone    ${PHONE}
    Click Button    id=registerButton
    Page Should Contain    Please enter your first name!!
    Capture Page Screenshot    docs/Unsuccess.png

Empty Last Name
    Open Workshop Registration Page
    Input Text    id=firstname    ${FNAME}
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=email    ${EMAIL}
    Input Text    id=phone    ${PHONE}
    Click Button    id=registerButton
    Page Should Contain    Please enter your last name!!
    Capture Page Screenshot    docs/Unsuccess2.png

Empty First Name and Last Name
    Open Workshop Registration Page
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=email    ${EMAIL}
    Input Text    id=phone    ${PHONE}
    Click Button    id=registerButton
    Page Should Contain    Please enter your name!!
    Capture Page Screenshot    docs/Unsuccess3.png

Empty Email
    Open Workshop Registration Page
    Input Text    id=firstname    ${FNAME}
    Input Text    id=lastname    ${LNAME}
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=phone    ${PHONE}
    Click Button    id=registerButton
    Page Should Contain    Please enter your email!!
    Capture Page Screenshot    docs/Unsuccess4.png

Empty Phone Number
    Open Workshop Registration Page
    Input Text    id=firstname    ${FNAME}
    Input Text    id=lastname    ${LNAME}
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=email    ${EMAIL}
    Click Button    id=registerButton
    Page Should Contain    Please enter your phone number!!
    Capture Page Screenshot    docs/Unsuccess5.png

Invalid Phone Number
    Open Workshop Registration Page
    Input Text    id=firstname    ${FNAME}
    Input Text    id=lastname    ${LNAME}
    Input Text    id=organization    ${ORGANIZATION}
    Input Text    id=email    ${EMAIL}
    Input Text    id=phone    ${INVALIDPHONE}
    Click Button    id=registerButton
    Page Should Contain    Please enter a valid phone number, e.g., 081-234-5678, 081 234 5678, or 081.234.5678)
    Capture Page Screenshot    docs/Unsuccess6.png