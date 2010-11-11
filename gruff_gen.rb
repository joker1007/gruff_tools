#!/usr/bin/env ruby

require 'rubygems'
require 'trollop'

$LOAD_PATH.push File.dirname(__FILE__)
require 'gruff/gruff_tool'

opts = Trollop::options do
  version "gruff_gen 0.0.1 (c) 2010 Tomohiro Hashidate"
  banner <<-EOS
Usage:
       gruff_gen.rb [options] <filename> [<interface> or <device>]

type are:
  sar_u     : sar -u CPU Usage
  sar_q1    : sar -q runq-sz, swpq-sz
  sar_q2    : sar -q %runocc, %swpocc
  sar_w1    : sar -w swpin/s, bswin/s, swpot/s
  sar_w2    : sar -w bswot/s
  sar_w3    : sar -w pswch/s
  sar_r     : sar -r
  sar_a     : sar -a
  vmstat_m  : vmstat Memory Usage
  vmstat_p1 : vmstat Page pi,po,fr,de
  vmstat_p2 : vmstat Page re,sr
  vmstat_c  : vmstat CPU Usage
  nicstat_b : nicstat Byte Bandwidth
  nicstat_p : nicstat Packet Bandwidth
  nicstat_u : nicstat Usage
  iostat_c  : iostat I/O Count
  iostat_b  : iostat I/O Byte
  iostat_w  : iostat I/O Wait
  iostat_u  : iostat I/O Busy Percentage

where [options] are:
EOS

  opt :type, "Target type", :type => :string, :required => true
  opt :name, "Graph name", :type => :string
  opt :size, "Graph image size", :type => :string
  opt :fontsize, "Font size", :type => :int
  opt :marker_count, "Graph Y axis count", :type => :int
  opt :min, "Graph Y axis minimum value", :type => :int
  opt :max, "Graph Y axis maximum value", :type => :int
  opt :output, "Target type", :type => :string
end

input = ARGV[0]
output = opts[:output] ? opts[:output] : File.basename(input, ".*") + ".png"


case opts[:type]
when "sar_u"
  graph_klass = Gruff::SarU
when "sar_q1"
  graph_klass = Gruff::SarQ1
when "sar_q2"
  graph_klass = Gruff::SarQ2
when "sar_w1"
  graph_klass = Gruff::SarW1
when "sar_w2"
  graph_klass = Gruff::SarW2
when "sar_w3"
  graph_klass = Gruff::SarW3
when "sar_r"
  graph_klass = Gruff::SarR
when "sar_a"
  graph_klass = Gruff::SarA
when "vmstat_m"
  graph_klass = Gruff::VmstatFreeMemory
when "vmstat_p1"
  graph_klass = Gruff::VmstatPage1
when "vmstat_p2"
  graph_klass = Gruff::VmstatPage2
when "vmstat_c"
  graph_klass = Gruff::VmstatCpu
when "nicstat_b"
  graph_klass = Gruff::NicstatByte
when "nicstat_p"
  graph_klass = Gruff::NicstatPacket
when "nicstat_u"
  graph_klass = Gruff::NicstatUsage
when "iostat_c"
  graph_klass = Gruff::IostatCount
when "iostat_b"
  graph_klass = Gruff::IostatByte
when "iostat_w"
  graph_klass = Gruff::IostatWait
when "iostat_u"
  graph_klass = Gruff::IostatBusy
end


size = opts[:size] ? opts[:size] : 800
name = opts[:name] ? opts[:name] : opts[:type]
fontsize = opts[:fontsize] ? opts[:fontsize] : 12

if opts[:type].index("nicstat") or opts[:type].index("iostat")
  interface_or_device = ARGV[1]
  unless interface_or_device
    puts "Please Input Interface Name"
    exit 1
  end

  gruff = graph_klass.new(input, interface_or_device, name, size, fontsize)
else
  gruff = graph_klass.new(input, name, size, fontsize)
end

gruff.calc
gruff.write(output, opts[:min], opts[:max])
