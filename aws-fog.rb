require 'rubygems'
require 'fog'

connection = Fog::Compute.new({
  :provider                => 'AWS'
  })

#This is for VPC setup
#server_obj = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14',key_name: 'thomas', security_group_ids:["sg-8bbf92ee"], subnet_id: 'subnet-b1d8d2c5')

#Below is for configuring standard servers -> I believe AWS is going away from this model
server_obj = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14', key_name: 'aws-devops', security_group_ids:["sg-462c582c"])
server_obj.wait_for { ready? }
puts "#{server_obj.id}"

connection.tags.create(resource_id: server_obj.id, key: 'Name', value: 'automate_build6')
connection.tags.create(resource_id: server_obj.id, key: 'environment', value: 'devops')
mytags = connection.tags.get('environment')
puts "#{mytags}"

mytags.select { |x| puts "#{x.resource_id}" if x.value == 'devops' }
#mytags.select { |x| connection.terminate_instances(x.resource_id) if x.value == 'devops' }

#Test getting back data
test = connection.servers.get(server_obj.id)
puts "#{test.public_ip_address}"
puts "#{test.availability_zone}"
puts "#{test.dns_name}"
