FROM sonarqube:9-community

# Flutter plugin
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-flutter/releases/download/0.4.0/sonar-flutter-plugin-0.4.0.jar


## Swift Plugin
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-apple/releases/download/0.1.2/sonar-apple-plugin-0.1.2.jar


## Quality Profile
ADD qualityprofile/exported_quality_profiles.xml /qualityprofile/
