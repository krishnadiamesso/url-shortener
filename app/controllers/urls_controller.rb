class UrlsController < ApplicationController
  def new
    @url = Url.new
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url
    else
      render 'new'
    end
  end

  def show
    @url = Url.find(params[:id])
  end

  def redirect
    url = Url.find(params[:url_id])
    url.click += 1
    url.save

    redirect_to url.long_url, allow_other_host: true
  end

  def dashboard
    @url = Url.find(params[:url_id])
  end

  private

    def url_params
      params.require(:url).permit(:long_url)
    end
end
