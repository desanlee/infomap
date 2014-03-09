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
	@infopiecescount = @infopieces.count if @infopieces != nil
	@newinfopiece = Infopiece.new
	@infolink = Infolink.new
	
	@rootpieces = current_user.infopieces.find(:all, :conditions => "lcount=0 and rcount!=0")
	# @infotree = buildroottree(@rootpieces, 0)
	
	#########################################
	@llinks1 = Array.new
	@clinks1 = Array.new
	@rlinks1 = Array.new
	@currentinfo1 = Array.new
	buildmap(@llinks1, @clinks1, @rlinks1, @currentinfo1, session[:cpiece1])
	
	@llinks2 = Array.new
	@clinks2 = Array.new
	@rlinks2 = Array.new
	@currentinfo2 = Array.new
	buildmap(@llinks2, @clinks2, @rlinks2, @currentinfo2, session[:cpiece2])
	
  end
  
  def buildmap(llinks, clinks, rlinks, currentinfo, session_c)
	current_cinfo = nil
	current_linfo = nil
	
	if session_c != nil
		current_cinfo = Infopiece.find_by_id(session_c) 
	end
	if current_cinfo == nil 
		current_cinfo = @rootpieces.first
	end
	if  current_cinfo.lcount > 0 then
		# selected info is not a root
		if current_cinfo.frompieces.first != nil then
			current_linfo = current_cinfo.frompieces.first 
		else
			# if selected info is mistakenly a root
			current_linfo = current_cinfo
			current_cinfo = current_linfo.topieces.first if !current_linfo.topieces.empty?
			session_c = current_cinfo.id
		end
	else
		# selected info is a root
		current_linfo = current_cinfo
		current_cinfo = current_linfo.topieces.first if !current_linfo.topieces.empty?
		session_c = current_cinfo.id
		#session[:test] = 22
	end
	
	lpieces = current_cinfo.frompieces if current_cinfo != nil
	
	
	lpieces.each do |p| 
		tmplink = Infolink.new
		tmplink.frompiece_id = 0
		tmplink.topiece_id = p.id
		llinks << tmplink
	end
	if current_cinfo != nil 
		current_cinfo.tolinks.each do |l|
			rlinks << l
		end
	end
	if current_linfo != nil
		current_linfo.tolinks.each do |l|
			clinks << l
		end
	end
	 
	
	newclink = Infolink.new
	newclink.frompiece_id = current_linfo.id
	newrlink = Infolink.new
	newrlink.frompiece_id = current_cinfo.id
		
	rlinks << newrlink
	clinks << newclink 
	currentinfo << current_cinfo
	currentinfo << current_linfo
  end
  
  def setcurrent
	session[:cpiece1] = params[:selectpiece1] if params[:selectpiece1] != nil
	session[:cpiece2] = params[:selectpiece2] if params[:selectpiece2] != nil
	
	redirect_to root_path
  end
  
end
