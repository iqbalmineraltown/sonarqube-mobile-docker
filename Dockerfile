FROM sonarqube:9.9.0-community

# Flutter plugin
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-flutter/releases/download/0.5.1/sonar-flutter-plugin-0.5.1.jar


## Swift Plugin
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-apple/releases/download/0.4.1/sonar-apple-plugin-0.4.1.jar


## Quality Profile
ADD qualityprofile/exported_quality_profiles.xml /qualityprofile/
