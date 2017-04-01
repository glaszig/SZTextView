Pod::Spec.new do |s|
  s.name           = 'SZTextView'
  s.version        = '1.3.0'
  s.summary        = 'A drop-in UITextView replacement which gives you a placeholder.'
  s.homepage       = 'https://github.com/glaszig/SZTextView'
  s.license        = 'MIT'
  s.author         = { 'glaszig' => 'glaszig@gmail.com' }
  s.source         = { :git => 'https://github.com/glaszig/SZTextView.git', :tag => s.version.to_s }
  s.platform       = :ios, '8.0'
  s.source_files   = 'Classes/SZTextView.{h,m}'
  s.requires_arc   = true
end
