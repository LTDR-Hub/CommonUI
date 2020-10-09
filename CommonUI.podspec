Pod::Spec.new do |s|

    s.name              = 'CommonUI'
    s.version           = '0.0.1'
    s.platform          = :ios, '11.0'
    s.license           = { :type => 'MIT' }
    s.homepage          = 'https://github.com/LTDR-Hub/CommonUI'
    s.authors           = { 'Yurii Dukhovnyi' => 'y.dukhovnyi@gmail.com' }
    s.summary           = 'This framework contains different extensions and useful mechanisms for simplifying everyday work with UIKit components.'
    s.source            = { :git => 'https://github.com/LTDR-Hub/CommonUI.git', :tag => s.version }
    s.source_files      = 'CommonUI/Sources/**/*.swift'
    s.requires_arc      = true
  end