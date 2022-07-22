*** Settings ***
Library  RequestsLibrary
Library  OperatingSystem
Library  SeleniumLibrary

*** Variables ***
${url}  http://localhost:8080/

*** Test Cases ***
AC1_TC001
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[0]["birthday"]}  gender=${object[0]["gender"]}  name=${object[0]["name"]}  natid=${object[0]["natid"]}  salary=${object[0]["salary"]}  tax=${object[0]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  202

AC1_TC002
    create session  AddData  ${url}
    ${json} =  Get file  Data/PersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[0]["birthday"]}  gender=${object[0]["gender"]}  name=${object[0]["name"]}  natid=${object[0]["natid"]}  salary=${object[0]["salary"]}  tax=${object[0]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC003
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[0]["birthday"]}  gender=${object[0]["gender"]}  name=${object[0]["name"]}  natid=${object[0]["natid"]}  salary=${object[0]["salary"]}  tax=${object[0]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC004
     create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[1]["birthday"]}  gender=${object[1]["gender"]}  name=${object[1]["name"]}  natid=${object[1]["natid"]}  salary=${object[1]["salary"]}  tax=${object[1]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500


AC1_TC005
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[2]["birthday"]}  gender=${object[2]["gender"]}  name=${object[2]["name"]}  natid=${object[2]["natid"]}  salary=${object[2]["salary"]}  tax=${object[2]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500


AC1_TC006
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[3]["birthday"]}  gender=${object[3]["gender"]}  name=${object[3]["name"]}  natid=${object[3]["natid"]}  salary=${object[3]["salary"]}  tax=${object[3]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500


AC1_TC007
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[4]["birthday"]}  gender=${object[4]["gender"]}  name=${object[4]["name"]}  natid=${object[4]["natid"]}  salary=${object[4]["salary"]}  tax=${object[4]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC008
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[5]["birthday"]}  gender=${object[5]["gender"]}  name=${object[5]["name"]}  natid=${object[5]["natid"]}  salary=${object[5]["salary"]}  tax=${object[5]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC009
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[6]["birthday"]}  gender=${object[6]["gender"]}  name=${object[6]["name"]}  natid=${object[6]["natid"]}  salary=${object[6]["salary"]}  tax=${object[6]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC010
    create session  AddData  ${url}
    ${json} =  Get file  Data/ErrorPersonDetails.json
    ${object} =  Evaluate  json.loads("""${json}""")  json
    &{body} =  Create Dictionary  birthday=${object[7]["birthday"]}  gender=${object[7]["gender"]}  name=${object[7]["name"]}  natid=${object[7]["natid"]}  salary=${object[7]["salary"]}  tax=${object[7]["tax"]}
    ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
    ${code}=  convert to string  ${response.status_code}
    should be equal  ${code}  500

AC1_TC011
        create session  AddData  ${url}
        ${json} =  Get file  Data/ErrorPersonDetails.json
        ${object} =  Evaluate  json.loads("""${json}""")  json
        &{body} =  Create Dictionary  birthday=${object[8]["birthday"]}  gender=${object[8]["gender"]}  name=${object[8]["name"]}  natid=${object[7]["natid"]}  salary=${object[8]["salary"]}  tax=${object[8]["tax"]}
        ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
        ${code}=  convert to string  ${response.status_code}
        should be equal  ${code}  500

AC1_TC012
        create session  AddData  ${url}
        ${json} =  Get file  Data/ErrorPersonDetails.json
        ${object} =  Evaluate  json.loads("""${json}""")  json
        &{body} =  Create Dictionary  birthday=${object[8]["birthday"]}  gender=${object[8]["gender"]}  name=${object[8]["name"]}  natid=${object[7]["natid"]}  salary=${object[8]["salary"]}  tax=${object[8]["tax"]}
        ${response}=  POST On Session  AddData  /calculator/insert  json=${body}
        ${code}=  convert to string  ${response.status_code}
        should be equal  ${code}  500
