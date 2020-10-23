Pod::Spec.new do |spec|
  spec.name         = "SwiftyNarou"
  spec.version      = "1.1.5"
  spec.summary      = 'A Swift wrapper for the Narou API. Also supports retrieving novel contents from ncode URLs.'

  spec.description  = <<-DESC
SwiftyNarou is a Swift wrapper around the Narou API. In addition to supporting all of the API's function calls, SwiftyNarou also enables the user to retrieve novel contents by providing an ncode. Inspired by narou4j by nshiba (https://github.com/nshiba/narou4j).
                   DESC

  spec.homepage     = "https://github.com/Rawgers/SwiftyNarou"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Roger Luo" => "rawger@berkeley.edu" }

  spec.ios.deployment_target = "13.0"
  spec.swift_version = "5.1"

  spec.source       = { :git => "https://github.com/Rawgers/SwiftyNarou.git", :tag => "#{spec.version}" }

  spec.source_files  = "SwiftyNarou/**/*.{h,m,swift}"
  spec.exclude_files = "Classes/Exclude"
  spec.dependency "SwiftSoup"
  spec.dependency "SwiftyJSON"
  spec.dependency "GzipSwift"
end
