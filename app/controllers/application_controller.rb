class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter:authenticate_user!
  
  def index
    @infopieces = current_user.infopieces.all
  end
  
  def switchpoolstatus
	if session[:poolstatus] != "in" then
		session[:poolstatus] = "in"
	else
		session[:poolstatus] = " "
	end
	redirect_to root_path
  end
  
  def switchexpansion
	infoid = params[:infoid]
	infoarray = Array.new
	if session[:expandinfo] != nil then
		infoarray = session[:expandinfo].split
		if infoarray.include? infoid then
			infoarray.delete infoid
		else
			infoarray << infoid
		end
		session[:expandinfo] = infoarray.uniq.join(" ") 
	else
		session[:expandinfo] = infoid.to_s
	end
	redirect_to root_path
  end
  
  def removeexpansion
	infoid = params[:infoid]
	redirect_to root_path
  end
  
  def buildroottree infoarray,deepth
    @expandinfo = Array.new
	infotree = Array.new
	return infotree if infoarray == nil
	@expandinfo = session[:expandinfo].split if session[:expandinfo] != nil 
	infoarray.each do |info|
		newhash = Hash.new
		newhash = {deepth: deepth, content: info}
		infotree << newhash
		if @expandinfo.include? info.id.to_s then
			infotree = infotree + buildroottree(info.topieces, deepth+1)
		end
	end
	
	return infotree
  end
  
  def treeindex
    
	@infopieces = current_user.infopieces.find(:all, :conditions => " lcount=0 and rcount=0")
	@newinfopiece = Infopiece.new
	@infolink = Infolink.new
	
	
	@rootpieces = current_user.infopieces.find(:all, :conditions => "lcount=0 and rcount!=0")
	@infotree = buildroottree(@rootpieces, 0)
	
	@current_cinfo = nil
	@current_linfo = nil
	
	#session[:test] = session[:cpiece] 
	@current_cinfo = Infopiece.find_by_id(session[:cpiece]) if session[:cpiece] != nil
	@current_cinfo = @rootpieces.first if @current_cinfo == nil
	if  @current_cinfo.lcount > 0 then
		# selected info is not a root
		@current_linfo = @current_cinfo.frompieces.first 
		if @current_linfo == nil then
			# if selected info is mistakenly a root
			@current_linfo = @current_cinfo
			@current_cinfo = @current_linfo.topieces.first if !@current_linfo.topieces.empty?
			session[:cpiece] = @current_cinfo.id
		end
	else
		# selected info is a root
		@current_linfo = @current_cinfo
		@current_cinfo = @current_linfo.topieces.first if !@current_linfo.topieces.empty?
		session[:cpiece] = @current_cinfo.id
		#session[:test] = 22
	end
	
	@lpieces = @current_cinfo.frompieces if @current_cinfo != nil
	
	@llinks = Array.new
	@lpieces.each do |p| 
		tmplink = Infolink.new
		tmplink.frompiece_id = 0
		tmplink.topiece_id = p.id
		@llinks << tmplink
	end
	@rlinks = @current_cinfo.tolinks if @current_cinfo != nil
	@clinks = @current_linfo.tolinks if @current_linfo != nil
	
	@newclink = Infolink.new
	@newclink.frompiece_id = @current_linfo.id
	@newrlink = Infolink.new
	@newrlink.frompiece_id = @current_cinfo.id
		
	@rlinks = @rlinks + [@newrlink]
	@clinks = @clinks +[@newclink] 
	
  end
  
  def setcurrent
	session[:cpiece] = params[:selectpiece]
	session[:lpiece] = params[:parentpiece]
	
	redirect_to root_path
  end
  
end
