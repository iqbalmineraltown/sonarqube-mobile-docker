FROM sonarqube:9.9.0-community

# Flutter plugin
ENV FLUTTER_PLUGIN_VERSION=0.5.2
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-flutter/releases/download/${FLUTTER_PLUGIN_VERSION}/sonar-flutter-plugin-${FLUTTER_PLUGIN_VERSION}.jar


## Swift Plugin
ENV SWIFT_PLUGIN_VERSION=0.4.1
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/insideapp-oss/sonar-apple/releases/download/${SWIFT_PLUGIN_VERSION}/sonar-apple-plugin-${SWIFT_PLUGIN_VERSION}.jar


## Quality Profile
ADD qualityprofile/exported_quality_profiles.xml /qualityprofile/

## Sonar Branch Plugin
ENV BRANCH_PLUGIN_VERSION=1.14.0
RUN wget -P $SONARQUBE_HOME/extensions/plugins \
    https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/${BRANCH_PLUGIN_VERSION}/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar
ENV SONAR_WEB_JAVAADDITIONALOPTS="-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${PLUGIN_VERSION}.jar=web"
ENV SONAR_CE_JAVAADDITIONALOPTS="-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${PLUGIN_VERSION}.jar=ce"
