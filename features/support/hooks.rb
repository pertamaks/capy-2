AfterConfiguration do
  FileUtils.rm_r('screenshot') if File.directory?('screenshot')
end
