class InfolinksController < ApplicationController
  # GET /infolinks
  def index
    @infolinks = Infolink.all

  end

  # GET /infolinks/1
  def show
    @infolink = Infolink.find(params[:id])

  end

  # GET /infolinks/new
  def new
    @infolink = Infolink.new

  end

  # GET /infolinks/1/edit
  def edit
    @infolink = Infolink.find(params[:id])
  end

  # POST /infolinks
  # POST /infolinks.json
  def create
    @infolink = Infolink.new(params[:infolink])

    respond_to do |format|
      if @infolink.save
		# Update reference count
		frominfo = Infopiece.find_by_id(@infolink.frompiece_id)
		toinfo = Infopiece.find_by_id(@infolink.topiece_id)
		frominfo.rcount += 1 if frominfo != nil
		toinfo.lcount += 1 if toinfo != nil
		frominfo.save
		toinfo.save
		
        format.html { redirect_to :back, notice: 'Infolink was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /infolinks/1
  # PUT /infolinks/1.json
  def update
    @infolink = Infolink.find(params[:id])

    respond_to do |format|
      if @infolink.update_attributes(params[:infolink])
        format.html { redirect_to @infolink, notice: 'Infolink was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /infolinks/1
  # DELETE /infolinks/1.json
  def destroy
    @infolink = Infolink.find(params[:id])
	
	# Update reference count
	frominfo = Infopiece.find_by_id(@infolink.frompiece_id)
	toinfo = Infopiece.find_by_id(@infolink.topiece_id)
	frominfo.rcount -= 1 if frominfo != nil
	toinfo.lcount -= 1 if toinfo != nil
	frominfo.save
	toinfo.save
		
    @infolink.destroy
	
	redirect_to :back

  end
end
