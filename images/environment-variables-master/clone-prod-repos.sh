for f in $(ls "$BUILD_SERVICES_DIR"/*.sh)
do
	# Call the properties files to set the variables defined in them
	echo $f
	. $f
	
	# Do the repos with custom tagging script enabled first
	if [ $GITHUB_REPO ] ; then 
		echo "Cloning the repo..."
		git clone -b $GITHUB_URL_BRANCH https://$GITHUB_USERNAME:$GITHUB_TOKEN@$GITHUB_URL_SHORT/$GITHUB_REPO.git "$WORKSPACE/last-updated/$GITHUB_REPO"
	fi
done
