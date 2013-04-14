build-demo:
	which ios-sim || brew install ios-sim
	xcodebuild -target SZTextViewTests -sdk iphonesimulator -configuration Debug RUN_UNIT_TEST_WITH_IOS_SIM=YES
