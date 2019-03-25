

#Services in alphabetical order

if [ "$Service" = "All services" ] ; then
	find ${SERVICES_DIR}/ -name "*.sh" -exec cp {} ${BUILD_SERVICES_DIR}/ \;

elif [ "$Service" = "Activity Tracker" ] ; then
	cp -fR "${SERVICES_DIR}/cloud-activity-tracker.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "AppID" ] ; then
	cp -fR "${SERVICES_DIR}/appid.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Certificate Manager" ] ; then
    	cp -fR "${SERVICES_DIR}/certificate-manager.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Cloud Object Storage" ] ; then
      	cp -fR "${SERVICES_DIR}/cloud-object-storage.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Container Registry" ] ; then
      	cp -fR "${SERVICES_DIR}/Registry.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Container Registry CLI" ] ; then
      	cp -fR "${SERVICES_DIR}/container-registry-cli-plugin.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Container Registry Images" ] ; then
      	cp -fR "${SERVICES_DIR}/RegistryImages.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Containers" ] ; then
	cp -fR "${SERVICES_DIR}/containers.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Containers CLI" ] ; then
	cp -fR "${SERVICES_DIR}/containers-cli-plugin.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Data Shield" ] ; then
      	cp -fR "${SERVICES_DIR}/data-shield.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Docker for Bluemix (test)" ] ; then
      	cp -fR "${SERVICES_DIR}/docker-for-bluemix.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Event Streams" ] ; then
      	cp -fR "${SERVICES_DIR}/EventStreams.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Functions" ] ; then
      	cp -fR "${SERVICES_DIR}/openwhisk.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Functions CLI" ] ; then
      	cp -fR "${SERVICES_DIR}/cloud-functions-cli-plugin.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Log Analysis" ] ; then
      	cp -fR "${SERVICES_DIR}/CloudLogAnalysis.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "LogDNA" ] ; then
      	cp -fR "${SERVICES_DIR}/Log-Analysis-with-LogDNA.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Monitoring" ] ; then
      	cp -fR "${SERVICES_DIR}/cloud-monitoring.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Security Advisor" ] ; then
      	cp -fR "${SERVICES_DIR}/security-advisor.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Sysdig" ] ; then
      	cp -fR "${SERVICES_DIR}/Monitoring-with-Sysdig.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Terraform" ] ; then
      	cp -fR "${SERVICES_DIR}/terraform.sh" "${BUILD_SERVICES_DIR}"

elif [ "$Service" = "Vulnerability Advisor" ] ; then
      	cp -fR "${SERVICES_DIR}/va.sh" "${BUILD_SERVICES_DIR}"

else
	echo "Error: No service parameter files to copy."
fi


cd services
cd build_services
echo "These services will be built:"
ls *.sh
