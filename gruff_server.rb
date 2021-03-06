# coding: utf-8
require "rubygems"
require "sinatra"
require "mongoid"
require 'mime/types'
#require "lib/mongoid/grid"

require 'lib/gruff/gruff_tool'
require 'lib/gruff/base'

#init Mongoid
#file_name = File.join(File.dirname(__FILE__), "mongoid.yml")
#@settings = YAML.load(ERB.new(File.new(file_name).read).result)

#Mongoid.configure do |config|
  #config.from_hash(@settings[ENV['RACK_ENV']])
#end

#class GraphData
  #include Mongoid::Document
  #include Mongoid::Grid
  #field :name
  #attachment :graph_image
#end



get '/' do
  erb :home
end

get '/usage' do
  erb :usage
end

get '/graph_image/:id' do
  data = GraphData.find(:first, :conditions => {:name => params[:id]})
  content_type data.graph_image_type
  data.graph_image.read
end


post '/create' do
  
  f = params[:file][:tempfile]
  @type = params[:type]

  if params[:name] and !params[:name].empty?
    @name = params[:name]
  else
    @name = @type
  end

  if params[:size] and 
    size = params[:size].index("x") ? params[:size] : params[:size].to_i
  else
    size = 800
  end

  theme = params[:theme]

  if params[:step] and !params[:step].empty?
    step = params[:step].to_i - 1
  else
    step = 9
  end

  @format = params[:format] ? params[:format] : "PNG"
  @file_id = "graph-#{File.basename(f.path)}"

  graph_klass = type_to_klass(@type)

  if @type.index("nicstat") or @type.index("iostat")
    interface = params[:interface]
    gruff = graph_klass.new(f, interface, @name, size, 16)
  else
    gruff = graph_klass.new(f, @name, size, 16)
  end

  if theme
    gruff.theme = theme
  end

  type = MIME::Types.type_for(".#{@format.downcase}").first

  content_type type

  gruff.calc(false, step)
  gruff.to_blob(@format)
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

