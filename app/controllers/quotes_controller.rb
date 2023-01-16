# frozen_string_literal: true

class QuotesController < ApplicationController
  before_action :set_quote, only: %w[edit update destroy show]

  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def show; end

  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to quotes_path, notice: 'Quote was created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: 'Quote was updated successfully'
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    @quote.destroy
    redirect_to quotes_path, notice: 'Quote was deleted successfully'
  end

  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
