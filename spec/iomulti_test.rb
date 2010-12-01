#!/usr/bin/env ruby

require 'rubygems'
require 'pp'

$LOAD_PATH.push File.join(File.dirname(__FILE__), "/../")
require 'lib/gruff/gruff_tool'

input = ARGV[0]

iomulti = Gruff::IostatMultiDevice.new(input, "c[0-9]t[0-9]d[0-9]+")
iomulti.get_devices.each do |dev|
  #iostat_busy = Gruff::IostatBusy.new(input, dev, "#{dev} I/O Busy", "1200x800")
  #iostat_busy.calc
  #iostat_busy.write("iostat_busy_#{dev}.png", 0)

  iostat_byte = Gruff::IostatByte.new(input, dev, "#{dev} I/O Byte", "1200x800")
  iostat_byte.calc
  col_values = iostat_byte.instance_variable_get(:@col_values)
  read = col_values[0]
  write = col_values[1]
  rmax = read.max
  wmax = write.max
  puts "#{dev}\t#{rmax}\t#{wmax}"
  #iostat_byte.write("iostat_byte_#{dev}.png", 0)

  #iostat_count = Gruff::IostatCount.new(input, dev, "#{dev} I/O Count", "1200x800")
  #iostat_count.calc
  #iostat_count.write("iostat_count_#{dev}.png", 0)

  #iostat_wait = Gruff::IostatWait.new(input, dev, "#{dev} I/O Wait", "1200x800")
  #iostat_wait.calc
  #iostat_wait.write("iostat_wait_#{dev}.png", 0)
end
