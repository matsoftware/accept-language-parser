Pod::Spec.new do |spec|
  spec.name         = "ALanguageParser"
  spec.version      = "1.1.0"
  spec.summary      = "Lightweight HTTP RFC-2616 Accept-Language parser in Swift."
  spec.description  = <<-DESC
  ALanguageParser is the swift porting of the npm accept-language-parser package by OpenTable. It parses the accept-language header from an HTTP request and produces an array of language objects sorted by quality.

It has been designed to be used with Swift Server Side in mind (e.g. Vapor, Kitura, Perfect) but it can be used in any client side project.
                   DESC
  spec.homepage     = "https://github.com/matsoftware/accept-language-parser"
  spec.license      = "MIT"
  spec.author             = "Mattia Campolese"
  spec.social_media_url   = "https://twitter.com/matsoftware"
  spec.source       = { :git => "https://github.com/matsoftware/accept-language-parser.git", :tag => "#{spec.version}" }
  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.9"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "12.0"
  spec.source_files  = "Sources/**/*"
  spec.frameworks = "Foundation"
  spec.swift_versions = "5.7"
end
