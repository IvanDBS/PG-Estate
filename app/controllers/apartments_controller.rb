class ApartmentsController < ApplicationController
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /apartments or /apartments.json
  def index
    @q = Apartment.ransack(params[:q])
    @total_count = @q.result.count
    @pagy, @apartments = pagy(@q.result(distinct: true), items: 12, size: 7)
  end

  # GET /apartments/1 or /apartments/1.json
  def show
    @apartment = Apartment.find(params[:id])
  end

  # GET /apartments/new
  def new
    @apartment = current_user.apartments.build
  end

  # GET /apartments/1/edit
  def edit; end

  # POST /apartments or /apartments.json
  def create
    @apartment = current_user.apartments.build(apartment_params)
    
    if @apartment.save
      redirect_to apartment_path(@apartment), notice: 'Apartment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /apartments/1 or /apartments/1.json
  def update
    if @apartment.update(apartment_params)
      redirect_to @apartment, notice: 'Apartment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /apartments/1 or /apartments/1.json
  def destroy
    @apartment.destroy
    redirect_to apartments_url, notice: 'Apartment was successfully deleted.'
  end

  private

  def correct_user
    @apartment = current_user.apartments.find_by(id: params[:id])
    redirect_to apartments_path, notice: 'Unauthorized access' if @apartment.nil?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_apartment
    @apartment = Apartment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def apartment_params
    params.require(:apartment).permit(:bedroom, :apt_type, :condition, :price, :location, pictures: [])
  end
end
