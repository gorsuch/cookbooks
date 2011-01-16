BUCKET    = 'gorsuch-cookbooks'
FILENAME = 'cookbooks.tar.gz'

desc "tar and gzip the cookbooks"
task :tar do
  system("tar cvzf #{FILENAME} ./cookbooks")
end

desc "send the cookbooks to S3"
task :upload => :tar do
  require 'aws/s3'  
  AWS::S3::Base.establish_connection!(:access_key_id => ENV["AWS_ACCESS_KEY_ID"], :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"])
  
  AWS::S3::S3Object.store(FILENAME, File.open(FILENAME), BUCKET, :access => :public_read, 'Cache-Control' => 'max-age=315360000')
end
