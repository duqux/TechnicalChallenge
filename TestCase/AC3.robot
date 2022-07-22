*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  SeleniumLibrary
Library  webdriver
Library  ChromeDriverManager

*** Variables ***
${url}  http://localhost:8080/


*** Test Cases ***
AC3_TC024
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/test.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC026
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc026_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC027
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc027_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC028
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc028_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC029
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc029_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC030
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc030_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC031
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/tc031_data.csv
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser

AC3_TC032
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Choose File  xpath://input[@type='file']  C:/Users/ECQ985/PycharmProjects/pythonProject/Resources/data.txt
    Page Should Contain Element  xpath://caption[contains(text(),'List')]
    close browser