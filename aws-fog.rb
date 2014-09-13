require 'rubygems'
require 'fog'

connection = Fog::Compute.new({
  :provider                => 'AWS',
  :aws_access_key_id       => '',
  :aws_secret_access_key   => '' 
  })


server_obj = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14')
server_obj.wait_for { ready? }
puts "#{server_obj.id}"

connection.tags.create(resource_id: server_obj.id, key: 'Name', value: 'thomas_build')
connection.tags.create(resource_id: server_obj.id, key: 'environment', value: 'testing')
mytags = connection.tags.get('environment')
puts "#{mytags}"

mytags.select { |x| puts "#{x.resource_id}" if x.value == 'devops' }




#Test getting back data
test = connection.servers.get(server_obj.id)
puts "#{test.public_ip_address}"
puts "#{test.availability_zone}"
puts "#{test.dns_name}"
