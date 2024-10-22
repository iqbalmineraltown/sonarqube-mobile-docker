# Sonarqube + Flutter

Sonarqube base docker image with plugins:

- [sonar-flutter](https://github.com/insideapp-oss/sonar-flutter)
- [sonar-swift](https://github.com/Idean/sonar-swift)

## Prerequisites

- Docker on sonarqube's host machine
- [sonar-scanner-cli](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/) on project's host machine. Or `brew install sonar-scanner`

## Setup

On sonarqube's host machine:

- clone this project and run `docker-compose up`
- wait until SONAR_HOST address is accessible from browser with login page
- use `admin` as both username and password, you'll be prompted to change password
- Create new project `Manually`
- Provide project display name (`PROJECT_NAME`) and key as unique identifier (`PROJECT_KEY`)
- If running analyzer on local dev machine, select testing `Locally`. (Else, select CI platform and follow the instructions provided)
- Generate token for this project (`PROJECT_TOKEN`)

### Bootstrap Exported Quality Profiles

To use existing Quality Profiles, put the exported `.xml` file into `qualityprofile/` folder

## Run Analyzer

### Flutter

On the project's root folder:

- Add `sonar-project.properties` file as following

```bash
# Project identification
sonar.projectKey=<PROJECT_KEY>
sonar.projectName=<PROJECT_NAME>
sonar.projectVersion=1.0

sonar.host.url=<SONAR_HOST> # replace with http://localhost:9000 if running docker-compose on the same machine

# Source code location.
# Path is relative to the sonar-project.properties file. Defaults to .
# Use commas to specify more than one folder.
sonar.sources=lib
sonar.tests=test
# Encoding of the source code. Default is default system encoding.
sonar.sourceEncoding=UTF-8
# Allows reuse of an existing analyzer report
# sonar.dart.analysis.reportPath=
# Analyzer mode
# Can be:
# — flutter (flutter analyze) — default
# — dart (dart analyze)
# — legacy (dartanalyzer)
# sonar.flutter.analyzer.mode=

# Use existing analysis_options.yaml to perform dartanalyzer analysis
sonar.dart.analysis.useExistingOptions=true

```

- `flutter pub get && flutter test --machine --coverage > tests.output` to run analysis
- submit result to sonarqube

```bash
sonar-scanner \
  -Dsonar.projectKey=com.mekari.flex:flutter \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=<token> \
  -Dsonar.pullrequest.key=1 \
  -Dsonar.pullrequest.branch="feature/ABC-1234" \
  -Dsonar.pullrequest.base=main

```

- Analysis result should be available shortly on the sonarqube dashboard

#### Using sonar-scanner-cli-docker

sonar-scanner-cli also available as [docker image](https://github.com/SonarSource/sonar-scanner-cli-docker)

```bash
docker run \
    --rm \
    -e SONAR_HOST_URL="<SONAR_HOST>" \
    -e SONAR_TOKEN="<PROJECT_TOKEN>" \
    -v "<SOURCE_DIR>:/usr/src" \
    sonarsource/sonar-scanner-cli
```

sample to run on root project folder against local docker sonarqube

```bash
docker run --rm -e SONAR_HOST_URL="http://localhost:9000" -e SONAR_TOKEN="<PROJECT_TOKEN>" -v ".:/usr/src" --network="scanner-sq-network" sonarsource/sonar-scanner-cli
```

### iOS
