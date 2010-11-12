# coding: utf-8
require "rubygems"
require "sinatra"

require 'lib/gruff/gruff_tool'

get '/' do
  erb :home
end

post '/create' do
  
  f = params[:file][:tempfile]
  @type = params[:type]

  if params[:name] and !params[:name].empty?
    @name = params[:name]
  else
    @name = @type
  end
  size = params[:size] ? params[:size] : 800
  theme = params[:theme]

  @output = "#{Time.now.to_i}.png"

  graph_klass = type_to_klass(@type)

  if @type.index("nicstat") or @type.index("iostat")
    interface = params[:interface]
    gruff = graph_klass.new(f, interface, @name, size, 14)
  else
    gruff = graph_klass.new(f, @name, size, 14)
  end

  if theme
    gruff.theme = theme
  end

  gruff.calc
  gruff.write("public/" + @output)

  erb :create
end


def type_to_klass(type)
  case type
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

  graph_klass
end

