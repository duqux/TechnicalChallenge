*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  SeleniumLibrary
Library  webdriver
Library  ChromeDriverManager

*** Variables ***
${url}  http://localhost:8080/
${expectedcolor}  rgba(220, 53, 69, 1)
${buttontext}  Dispense Now
${expectedtext}  Cash dispensed

*** Test Cases ***
AC5_TC047
     Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${elem}  Get Webelement  css=.btn-danger
    ${color}  Call Method  ${elem}  value_of_css_property  background-color
     log to console  ${color}
    Should Be True  """${color}""" == """${expectedcolor}"""
    close browser

AC5_TC048
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${button}  Get Text  xpath://a[@role='button'][2]
      log to console  ${button}
    Should Be True  """${button}""" == """${buttontext}"""
    close browser

AC5_TC049
     Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    Click Element  xpath://a[@role='button'][2]
    ${text}  Get Text  xpath://div[@class='display-4 font-weight-bold']
    Should Be True  """${text}""" == """${expectedtext}"""
    close browser
