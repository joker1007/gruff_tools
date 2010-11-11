#!/usr/bin/env ruby

require 'rubygems'

$LOAD_PATH.push File.dirname(__FILE__)
require 'gruff/sar/sar_u'
require 'gruff/sar/sar_q'
require 'gruff/sar/sar_r'
require 'gruff/sar/sar_w'





#sar_u = Gruff::SarU.new("sar_u.log", "bloodstone sar -u", "1600x1000")
#sar_u.calc
#sar_u.write("my_sar.png")

#sar_q1 = Gruff::SarQ1.new("sar_q.log", "bloodstone sar -q(queues)", "1600x1000")
#sar_q1.calc
#sar_q1.write("my_sarq1.png")

#sar_q2 = Gruff::SarQ2.new("sar_q.log", "bloodstone sar -q(percent)", "1600x1000")
#sar_q2.calc
#sar_q2.write("my_sarq2.png")

#sar_r1 = Gruff::SarR.new("sar_r.log", "bloodstone sar -r(freemem)", "1600x1000")
#sar_r1.calc
#sar_r1.write("my_sarr1.png")


#sar_w1 = Gruff::SarW1.new("sar_w.log", "bloodstone sar -w(process count)", "1600x1000")
#sar_w1.calc
#sar_w1.write("my_sarw1.png")

#sar_w2 = Gruff::SarW2.new("sar_w.log", "bloodstone sar -w(block count)", "1600x1000")
#sar_w2.calc
#sar_w2.write("my_sarw2.png")

sar_w3 = Gruff::SarW3.new("sar_w.log", "bloodstone sar -w(context switch count)", "1600x1000")
sar_w3.calc
sar_w3.write("my_sarw3.png")
