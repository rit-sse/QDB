class QuotesController < ApplicationController
  http_basic_authenticate_with :name => APP_CONFIG["mod_user"], :password => APP_CONFIG["mod_pass"], :except => [:index, :show, :new, :create]

  # GET /quotes
  # GET /quotes.json
  def index
    @quotes = Quote.where(:approved => true).page params[:page]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @quotes }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
    @quote = Quote.find(params[:id])
    if !@quote.approved
      respond_to do |format|
        format.html { render "not_found" }
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @quote }
      end
    end
  end

  # GET /quotes/new
  # GET /quotes/new.json
  def new
    @quote = Quote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @quote }
    end
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(params[:quote])

    tags = params[:tags].split(" ")
    tags.each do |tag_name|
      tag_name = tag_name.downcase
      tag = Tag.find_by_name(tag_name)
      if not tag 
        tag = Tag.new({:name => tag_name})
        tag.save
      end

      @quote.tags << tag
    end
    @quote.id = 1
    respond_to do |format|
      begin
        if @quote.save
          format.html { render :created}
          format.json { render json: @quote, status: :created, location: @quote }
        else
          @quote.id = Quote.find(:all).map(&:id).max + 1
          if @quote.save
            format.html { render :created}
            format.json { render json: @quote, status: :created, location: @quote }
          else
            format.html { render action: "new" }
            format.json { render json: @quote.errors, status: :unprocessable_entity }
          end
        end
      rescue => e
          @quote.id = Quote.find(:all).map(&:id).max + 1
          if @quote.save
            format.html { render :created}
            format.json { render json: @quote, status: :created, location: @quote }
          else
            format.html { render action: "new" }
            format.json { render json: @quote.errors, status: :unprocessable_entity }
          end
      end
    end
  end

  # PUT /quotes/1
  # PUT /quotes/1.json
  def update
    @quote = Quote.find(params[:id])

    tags = params[:tags].split(" ")
    tags.each do |tag_name|
      tag_name = tag_name.downcase
      tag = Tag.find_by_name(tag_name)
      if not tag 
        tag = Tag.new({:name => tag_name})
        tag.save
      end

      if not @quote.tags.include?(tag)
        @quote.tags << tag
      end
    end

    respond_to do |format|
      if @quote.update_attributes(params[:quote])
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote = Quote.find(params[:id])
    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url }
      format.json { head :no_content }
    end
  end
end
