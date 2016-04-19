require 'spec_helper'
require 'serverspec'

package = 'hbase'
service = 'hbase'
config  = '/etc/hbase/hbase.conf'
user    = 'hbase'
group   = 'hbase'
ports   = [ 2181 ]
log_dir = '/var/log/hbase'
db_dir  = '/var/lib/hbase'

case os[:family]
when 'freebsd'
  config = '/usr/local/etc/hbase/hbase-site.xml'
  db_dir = '/var/db/hbase'
  service = 'hbase_master'
end

describe package(package) do
  it { should be_installed }
end 

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape('<name>hbase.rootdir</name>') }
  its(:content) { should match Regexp.escape('<value>file:///var/db/hbase</value>') }
  its(:content) { should match Regexp.escape('<name>hbase.zookeeper.property.dataDir</name>') }
  its(:content) { should match Regexp.escape('<value>/var/db/zookeeper</value>') }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

#case os[:family]
#when 'freebsd'
#  describe file('/etc/rc.conf.d/hbase') do
#    it { should be_file }
#  end
#end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end
