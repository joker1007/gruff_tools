#!/usr/bin/env ruby

require 'rubygems'

$LOAD_PATH.push File.dirname(__FILE__)
require 'gruff/gruff_tool'




sar_u = Gruff::SarU.new("sar_u.log", "bloodstone sar -u", "1600x1000")
sar_u.calc
sar_u.write("my_sar.png")

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

#sar_w3 = Gruff::SarW3.new("sar_w.log", "bloodstone sar -w(context switch count)", "1600x1000")
#sar_w3.calc
#sar_w3.write("my_sarw3.png")

#sar_a = Gruff::SarA.new("sar_a.log", "bloodstone sar -a", "1600x1000")
#sar_a.calc
#sar_a.write("my_sara.png")

#vmstat_free_memory = Gruff::VmstatFreeMemory.new("vmchk_0.log", "vmstat free memory", "1600x1000")
#vmstat_free_memory.marker_count = 7
#vmstat_free_memory.calc
#vmstat_free_memory.write("vmstat_free_memory.png", 0)

#vmstat_page = Gruff::VmstatPage1.new("vmchk_0.log", "vmstat paging io", "1200x800")
#vmstat_page.calc
#vmstat_page.write("vmstat_page.png", 0)

#vmstat_page2 = Gruff::VmstatPage2.new("vmchk_0.log", "vmstat paging re & sr", "1200x800")
#vmstat_page2.calc
#vmstat_page2.write("vmstat_page2.png", 0)

#vmstat_cpu = Gruff::VmstatCpu.new("vmchk_0.log", "vmstat cpu usage", "1200x800")
#vmstat_cpu.calc
#vmstat_cpu.write("vmstat_cpu.png", 0)

#nicstat_byte = Gruff::NicstatByte.new("nicstat.log", "eri0", "eri0 Network Bandwidth", "1200x800")
#nicstat_byte.calc
#nicstat_byte.write("nicstat_byte.png", 0)

#nicstat_packet = Gruff::NicstatPacket.new("nicstat.log", "eri0", "eri0 Network Packet", "1200x800")
#nicstat_packet.calc
#nicstat_packet.write("nicstat_packet.png", 0)

#nicstat_usage = Gruff::NicstatUsage.new("nicstat.log", "eri0", "eri0 Network usage", "1200x800")
#nicstat_usage.marker_count = 10
#nicstat_usage.calc
#nicstat_usage.write("nicstat_usage.png", 0)

#iostat_count = Gruff::IostatCount.new("iochk_0.log", "c8t0d2", "c8t0d2 I/O Count", "1200x800")
#iostat_count.calc
#iostat_count.write("iostat_count.png", 0)

#iostat_byte = Gruff::IostatByte.new("iochk_0.log", "c0t0d0", "c0t0d0 I/O byte", "1200x800")
#iostat_byte.calc
#iostat_byte.write("iostat_byte.png", 0)

#iostat_wait = Gruff::IostatWait.new("iochk_0.log", "c0t0d0", "c0t0d0 I/O wait", "1200x800")
#iostat_wait.calc
#iostat_wait.write("iostat_wait.png", 0)

#iostat_busy = Gruff::IostatBusy.new("iochk_0.log", "c0t0d0", "c0t0d0 I/O busy", "1200x800")
#iostat_busy.calc
#iostat_busy.write("iostat_busy.png", 0)


puts "Gen Graph"
