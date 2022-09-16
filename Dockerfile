FROM sonarqube:9-community

# Import flutter plugin
RUN wget https://github.com/insideapp-oss/sonar-flutter/releases/download/0.4.0/sonar-flutter-plugin-0.4.0.jar \
    -P $SONARQUBE_HOME/extensions/plugins
