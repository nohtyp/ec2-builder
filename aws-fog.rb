require 'rubygems'
require 'fog'

connection = Fog::Compute.new({
  :provider                => 'AWS',
  :aws_access_key_id       => '',
  :aws_secret_access_key   => '' 
  })


sc = connection.servers.create(flavor_id: 't1.micro', image_id: 'ami-7c807d14', name: 'foster-instance')
sc.wait_for { ready? }

sc = connection.servers.get('i-0e8c7fe5')
connection.tags.create(resource_id: 'i-40f201ab', key: 'key', value: 'staging')
puts "server is #{sc.identity}"
