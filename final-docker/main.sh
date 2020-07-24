if [ -z ${DISPLAY+x} ]; then
	/usr/local/apache-tomcat-v8.5.57/bin/catalina.sh run
else
	/usr/local/apache-tomcat-v8.5.57/bin/catalina.sh run&
	bash /opt/eclipse/eclipse
fi

