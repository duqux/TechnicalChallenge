*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  SeleniumLibrary
Library  webdriver
Library  ChromeDriverManager
Library  String


*** Keywords ***
write_variable_in_file
  [Arguments]  ${variable}
  Create File  ${EXECDIR}/file_with_variable.txt  ${variable}

*** Variables ***
${url}  http://localhost:8080/
${expectednatid34}  1234$$
${expectednatid35}  1234
${currentyear}  2022

*** Test Cases ***
AC4_TC033
    create session  RetrieveData  ${url}
    ${taxrelieflist} =  GET On Session  RetrieveData  /calculator/taxRelief
    log to console  ${taxrelieflist.content}
    ${list} =  Convert To String  ${taxrelieflist.content}
    write_variable_in_file  ${list}

AC4_TC034
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[2]["birthday"]}  gender=${object[2]["gender"]}  name=${object[2]["name"]}  natid=${object[2]["natid"]}  salary=${object[2]["salary"]}  tax=${object[2]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  202
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${natid}  Get Text  xpath:(//td)[last()-1]
    log to console  ${natid}
    Should Be True  """${natid}""" == """${expectednatid34}"""
    close browser

AC4_TC035
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[3]["gender"]}  name=${object[3]["name"]}  natid=${object[3]["natid"]}  salary=${object[3]["salary"]}  tax=${object[3]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  202
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${natid}  Get Text  xpath:(//td)[last()-1]
    log to console  ${natid}
    Should Be True  """${natid}""" == """${expectednatid35}"""
    close browser

AC4_TC036 KIV
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[3]["gender"]}  name=${object[3]["name"]}  natid=${object[3]["natid"]}  salary=${object[3]["salary"]}  tax=${object[3]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  202
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${taxrelief}"""
    close browser

AC4_TC037
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[0]["birthday"]}  gender=${object[0]["gender"]}  name=${object[0]["name"]}  natid=${object[0]["natid"]}  salary=${object[0]["salary"]}  tax=${object[0]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[0]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[0]["salary"]}
    ${tax} =  Convert To Number  ${object[0]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC038
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[1]["birthday"]}  gender=${object[1]["gender"]}  name=${object[1]["name"]}  natid=${object[1]["natid"]}  salary=${object[1]["salary"]}  tax=${object[1]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[1]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[1]["salary"]}
    ${tax} =  Convert To Number  ${object[1]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC039
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[2]["birthday"]}  gender=${object[2]["gender"]}  name=${object[2]["name"]}  natid=${object[2]["natid"]}  salary=${object[1]["salary"]}  tax=${object[2]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[2]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[2]["salary"]}
    ${tax} =  Convert To Number  ${object[2]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC040
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[3]["gender"]}  name=${object[3]["name"]}  natid=${object[3]["natid"]}  salary=${object[3]["salary"]}  tax=${object[3]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[3]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[3]["salary"]}
    ${tax} =  Convert To Number  ${object[3]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC041
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[4]["gender"]}  name=${object[4]["name"]}  natid=${object[4]["natid"]}  salary=${object[4]["salary"]}  tax=${object[4]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[4]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[4]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[4]["salary"]}
    ${tax} =  Convert To Number  ${object[4]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC042
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief-Female.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[0]["birthday"]}  gender=${object[0]["gender"]}  name=${object[0]["name"]}  natid=${object[0]["natid"]}  salary=${object[0]["salary"]}  tax=${object[0]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[0]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[0]["salary"]}
    ${tax} =  Convert To Number  ${object[0]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC042
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief-Female.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[1]["birthday"]}  gender=${object[1]["gender"]}  name=${object[1]["name"]}  natid=${object[1]["natid"]}  salary=${object[1]["salary"]}  tax=${object[1]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[1]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[1]["salary"]}
    ${tax} =  Convert To Number  ${object[1]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC043
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief-Female.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[2]["birthday"]}  gender=${object[2]["gender"]}  name=${object[2]["name"]}  natid=${object[2]["natid"]}  salary=${object[1]["salary"]}  tax=${object[2]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[2]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[2]["salary"]}
    ${tax} =  Convert To Number  ${object[2]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC044
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief-Female.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[3]["gender"]}  name=${object[3]["name"]}  natid=${object[3]["natid"]}  salary=${object[3]["salary"]}  tax=${object[3]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[3]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[3]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[3]["salary"]}
    ${tax} =  Convert To Number  ${object[3]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser

AC4_TC045
    create session  AddData  ${url}
    ${json} =  Get file  Data/CalcuateTaxRelief.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[4]["gender"]}  name=${object[4]["name"]}  natid=${object[4]["natid"]}  salary=${object[4]["salary"]}  tax=${object[4]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    ${year} =  Get Substring  ${object[4]["birthday"]}  4
     ${currentyear} =  Convert To Number  ${currentyear}
     ${year} =  Convert To Number  ${year}
    ${age} =  Evaluate  ${currentyear} - ${year}
    log to console  ${age}
    IF  ${age} >= 18 or ${age} < 35
        ${variable}  Set Variable  1
    ELSE IF  ${age} >= 35 or ${age} < 50
        ${variable}  Set Variable  0.8
   ELSE IF  ${age} >= 50 or ${age} < 75
        ${variable}  Set Variable  0.5
   ELSE IF  ${age} >= 75 or ${age} < 76
         ${variable}  Set Variable  0.367
   ELSE IF  ${age} >= 76
        ${variable}  Set Variable  0.05
        END
        log to console  ${variable}

    IF  "${object[4]["gender"]}" == "F"
        ${genderbonus}  Set Variable  500
    ELSE
        ${genderbonus}  Set Variable  0
        END
        log to console  ${genderbonus}

    ${salary} =  Convert To Number  ${object[4]["salary"]}
    ${tax} =  Convert To Number  ${object[4]["tax"]}

    ${calculatedtaxrelief} =  Evaluate  ((${salary} - ${tax})* ${variable}) + ${genderbonus}
    log to console  ${calculatedtaxrelief}
    Set Environment Variable  webdriver.chrome.driver  chromedriver
    Open browser   ${url}  chrome
    ${taxrelief}  Get Text  xpath:(//td)[last()]
    log to console  ${taxrelief}
    Should Be True  """${taxrelief}""" == """${calculatedtaxrelief}"""
    close browser