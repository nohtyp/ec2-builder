require 'rubygems'
require 'fog'

connection = Fog::Compute.new({
  :provider                => 'AWS'
  })


#This is for VPC setup
server_obj = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14',key_name: 'aws-devops', security_group_ids:["sg-c46649a1"], subnet_id: 'subnet-de6b9987')

#Below is for configuring standard servers -> I believe AWS is going away from this model in favor of vpc's
#server_obj = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14', key_name: 'aws-devops', security_group_ids:["sg-462c582c"])
server_obj.wait_for { ready? }
puts "#{server_obj.id}"

connection.tags.create(resource_id: server_obj.id, key: 'Name', value: 'automate_build8')
connection.tags.create(resource_id: server_obj.id, key: 'environment', value: 'devops')
mytags = connection.tags.get('environment')
puts "#{mytags}"

#mytags.select { |x| puts "#{x.resource_id}" if x.value == 'devops' }
#mytags.select { |x| connection.terminate_instances(x.resource_id) if x.value == 'devops' }

#Test getting back data
#test = connection.servers.get(server_obj.id)
#puts "#{test.public_ip_address}"
#puts "#{test.availability_zone}"
#puts "#{test.dns_name}"
