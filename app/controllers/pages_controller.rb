class PagesController < ApplicationController
  def search
    if params[:search].blank?
      flash[:danger] = t "search.danger"
      redirect_to root_path
    else
      @locations = Location.search_name(params[:search].downcase)
    end
  end
end
