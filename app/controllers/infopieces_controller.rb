class InfopiecesController < ApplicationController
  # GET /infopieces
  def index
    @infopieces = current_user.infopieces

  end

  # GET /infopieces/1
  def show
    @infopiece = Infopiece.find(params[:id])

  end

  # GET /infopieces/new
  def new
    @infopiece = Infopiece.new
	@infopiece.lcount = params[:id]
	render :layout => "justapage"
  end

  # GET /infopieces/1/edit
  def edit
    @infopiece = Infopiece.find(params[:id])
	render :layout => "justapage"
  end

  # POST /infopieces
  def create
    @infopiece = Infopiece.new(params[:infopiece])

	@multilines = @infopiece.content.split("===")
	@multilines.each do |mc| 
		newinfo = Infopiece.new
		newinfo.user_id = current_user.id
		newinfo.content = mc.chomp
		
		newlink = nil
		parentpiece = nil
		if @infopiece.lcount != nil then
			parentpiece = Infopiece.find(@infopiece.lcount)
			newlink = Infolink.new
			newlink.frompiece_id = @infopiece.lcount
		end
		
		newinfo.lcount = 0
		newinfo.rcount = 0
	

		  if newinfo.save
			if newlink then
				newlink.topiece_id = newinfo.id
				newlink.save
				newlink.index_id = newlink.created_at
				newlink.save
				
				newinfo.lcount += 1
				parentpiece.rcount += 1
				newinfo.save
				parentpiece.save
			end
		  end
	end
	
	redirect_to :back
  end

  # PUT /infopieces/1
  def update
    @infopiece = Infopiece.find(params[:id])

    respond_to do |format|
      if @infopiece.update_attributes(params[:infopiece])
        format.html { redirect_to :back, notice: 'Infopiece was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @infopiece.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infopieces/1
  def destroy
    @infopiece = Infopiece.find(params[:id])
    @infopiece.destroy

	redirect_to :back 
  end
  
end
