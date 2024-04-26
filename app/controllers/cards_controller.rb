class CardsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create,:destroy,:update]

  def show
    card = Card.find(params[:id])
    if card
      render json: card, status: 200
    else
      render json: { error: "Card not found" }, status: :not_found
    end
  end

  def index
    #byebug
    cards = Card.all
    render json:cards, status: 200
  end
  def create
    card = Card.new(card_params)
    if card.save
      render json: card, status: 200
    else
      render json: { errors: card.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def update
    card = Card.find_by(id: params[:id])
    if card
      if card.update(card_params)
        render json: card, status: :ok
      else
        render json: { errors: card.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: "Card not found" }, status: :not_found
    end
  end

  def destroy
    begin
      card = Card.find(params[:id])
      card_id = card.id
      card.destroy
      render json: { message: "Card with ID #{card_id} deleted successfully" }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Card not found" }, status: :not_found
    rescue => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  private

  def card_params
    params.require(:card).permit(:title, :description)
  end

end