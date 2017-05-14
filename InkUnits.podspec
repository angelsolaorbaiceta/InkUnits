Pod::Spec.new do |s|
  s.name         = "InkUnits"
  s.version      = "0.0.1"
  s.summary      = "Smart and lightweight unit conversion module written in Swift."
  s.description  = <<-DESC
  Smart and lightweight unit conversion module written in Swift. InkUnits is the responsible of all unit conversions behind InkStructure OSX app.
                   DESC

  s.homepage     = "https://github.com/angelsolaorbaiceta/InkUnits"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "angelsolaorbaiceta" => "angelsolaorbaiceta@gmail.com" }
  s.source       = { :git => "https://github.com/angelsolaorbaiceta/InkUnits.git", :tag => "#{s.version}" }
  s.source_files  = "Sources/*.swift"
  s.resource  = "Configuration/UnitConversions.plist"
end
