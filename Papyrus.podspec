Pod::Spec.new do |s|

  s.name         = "Papyrus"
  s.version      = "1.6"
  s.summary      = "A tool to easily configure Collection Views in chained way."
  s.description  = <<-DESC
    Papyrus is intended for more convinient configuring the Collection View. 
    It also helps to create, dequeue and configure reusable views such as UICollectionViewCell in a type-safe way.
                   DESC
  s.homepage     = "https://github.com/drumnart/Papyrus"
  s.license      = { :type => "MIT" }
  s.author             = "drumnart"
  s.platform     = :ios, "9.0"
  s.source       =  { :git => "https://github.com/drumnart/Papyrus.git", :tag => s.version.to_s }
  s.source_files  = "Papyrus", "Papyrus/**/*.{h,m,swift}"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }
  
end
