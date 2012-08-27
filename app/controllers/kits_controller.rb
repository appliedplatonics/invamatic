class KitsController < ApplicationController
  # GET /kits
  # GET /kits.xml
  def index
    @kits = Kit.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kits }
    end
  end

  # GET /kits/1
  # GET /kits/1.xml
  def show
    @kit = Kit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kit }
    end
  end

  # GET /kits/new
  # GET /kits/new.xml
  def new
    @kit = Kit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kit }
    end
  end

  # GET /kits/1/edit
  def edit
    @kit = Kit.find(params[:id])
  end

  # POST /kits
  # POST /kits.xml
  def create
    @kit = Kit.new(params[:kit])

    respond_to do |format|
      if @kit.save
        flash[:notice] = 'Kit was successfully created.'
        format.html { redirect_to(@kit) }
        format.xml  { render :xml => @kit, :status => :created, :location => @kit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kits/1
  # PUT /kits/1.xml
  def update
    @kit = Kit.find(params[:id])

    respond_to do |format|
      if @kit.update_attributes(params[:kit])
        flash[:notice] = 'Kit was successfully updated.'
        format.html { redirect_to(@kit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kits/1
  # DELETE /kits/1.xml
  def destroy
    @kit = Kit.find(params[:id])
    @kit.destroy

    respond_to do |format|
      format.html { redirect_to(kits_url) }
      format.xml  { head :ok }
    end
  end
end
