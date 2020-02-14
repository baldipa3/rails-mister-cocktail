class CocktailsController < ApplicationController
  before_action :find_cocktails, only: [:edit, :destroy, :show, :update]
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    if params[:query].present?
      @cocktails = policy_scope(Cocktail).order(created_at: :desc).where("name ILIKE ?", "%#{params[:query]}%")
    else
      @cocktails = policy_scope(Cocktail).order(created_at: :desc)
    end
  end

  def new
    @cocktail = Cocktail.new
    authorize @cocktail
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    authorize @cocktail
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def show
    @dose = Dose.new
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail.destroy
    redirect_to root_path
  end

  private

  def find_cocktails
    @cocktail = Cocktail.find(params[:id])
    authorize @cocktail
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo).to_h.merge(user_id: current_user.id)
  end
end
