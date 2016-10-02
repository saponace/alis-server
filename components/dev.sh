#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Texlive-most (LaTeX compiler)
    ${INSTALL} texlive-most
# Java Development Kit
    ${INSTALL} jdk7-openjdk openjdk7-doc
    ${INSTALL} jdk8-openjdk openjdk8-doc
    # Make JRE the default JRE
        su -c "echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk' >> /etc/environment"
# C debug tools
    ${INSTALL} gdb
# Java build tools
    ${INSTALL} maven
# IDEs
    ${INSTALL} intellij-idea-ultimate-edition
    ${INSTALL} webstorm
