xcodebuild clean -workspace "ShangHaiProvidentFund.xcworkspace" -scheme "ShangHaiProvidentFund"
echo 清理完毕
infer -- xcodebuild -workspace ShangHaiProvidentFund.xcworkspace -scheme ShangHaiProvidentFund -configuration Debug -sdk iphonesimulator
echo 扫描完毕