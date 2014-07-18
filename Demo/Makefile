build-demo:
	which ios-sim || brew install ios-sim
	export ONLY_ACTIVE_ARCH=NO
	xcodebuild -project SZTextView.xcodeproj -scheme SZTextView -sdk iphonesimulator -configuration Debug -destination "platform=iOS Simulator,name=iPhone Retina (4-inch),OS=6.1" clean test
	xcodebuild -project SZTextView.xcodeproj -scheme SZTextView -sdk iphonesimulator -configuration Debug -destination "platform=iOS Simulator,name=iPhone Retina (4-inch),OS=7.1" clean test
