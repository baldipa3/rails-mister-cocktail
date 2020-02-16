class DosesController < ApplicationController
  before_action :find_doses, only: [:destroy]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    authorize @dose
    authorize @cocktail
  end

  def create
    @dose = Dose.new(dose_params)
    authorize @dose
    @cocktail = Cocktail.find(params[:cocktail_id])
    authorize @cocktail
    @dose.cocktail = @cocktail
    redirect_to cocktail_path(@cocktail) if @dose.save
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
    @dose = Dose.find(params[:id])
  end

  def destroy
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def find_doses
    @dose = Dose.find(params[:id])
    authorize @dose
  end

  def dose_params
    params.require(:dose).permit(:amount, :ingredient_id)
  end
end
