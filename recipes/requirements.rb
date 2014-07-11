%w{wget curl imagemagick}.each do |p|
  package p do
    action :install
  end
end
