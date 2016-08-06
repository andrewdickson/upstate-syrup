class ProductsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.order("position asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
      format.js { render 'index' }
    end
  end



  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new
    @settings = SettingUtility.settings

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @settings = SettingUtility.settings

  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])
    #@product.extract_dimensions

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
        format.js {
          @new_url = edit_product_path(@product)
          render 'create' }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    if params[:move]
      @product.position = @product.position + (params[:move] == 'up' ? -1 : 1)
      @product.save
    end

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to products_path, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
        format.js {
          @products = Product.order('position asc')

          render 'index'}
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
      format.js {
        @products = Product.order('position asc')
        render 'index'
      }
    end
  end


end
