class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter:authenticate_user!
  
  def index
    @infopieces = current_user.infopieces.all
  end
  
  def treeindex
    
	@infopieces = current_user.infopieces.find(:all, :conditions => " lcount=0 and rcount=0")
    @infopiece = Infopiece.new
	@infolink = Infolink.new
	
	# determin what is current info selected as central and left one
	if session[:cpiece] != nil then
		if session[:lpiece] == 0 then	
			# Select from central or right lane 
			@current_linfo = Infopiece.find_by_id(session[:lpiece])
			@current_cinfo = Infopiece.find_by_id(session[:cpiece])
			session[:test] = 11111 
		elsif Infopiece.find_by_id(session[:cpiece]).frompieces.empty?	
			# Select info from left lane as current info and no more left info existed
			@current_linfo = Infopiece.find_by_id(session[:cpiece])
			@current_cinfo = @current_linfo.topieces.first
			session[:lpiece] = @current_linfo.id
			session[:cpiece] = @current_cinfo.id
			session[:test] = 222222 
		else
			# select info from left lane as current info and have more left info existed
			if Infopiece.find_by_id(session[:cpiece]).frompieces != nil then
				@current_cinfo = Infopiece.find_by_id(session[:cpiece])
				@current_linfo = @current_cinfo.frompieces.first 
				session[:lpiece] = @current_linfo.id
			end
			session[:test] = 333333 
		end
	end
	
	if @current_cinfo == nil then
		if @current_linfo == nil then
			@current_linfo = current_user.infopieces.find(:first, :conditions => "lcount=0")
		end
		@current_cinfo = @current_linfo.topieces.first if @current_linfo.topieces != nil
		session[:cpiece] = @current_cinfo.id if @current_cinfo != nil
	end
	
	# calculate the infopiece list for each cols
	@lpieces = @current_cinfo.frompieces if @current_cinfo != nil
	@rootpieces = current_user.infopieces.find(:all, :conditions => "lcount=0 and rcount!=0")
	
	@rlinks = @current_cinfo.tolinks if @current_cinfo != nil
	@clinks = @current_linfo.tolinks if @current_linfo != nil
	
  end
  
  def poolindex

  end
  
  def setcurrent
	session[:cpiece] = params[:selectpiece]
	session[:lpiece] = params[:parentpiece]
	
	redirect_to root_path
  end
  
end
