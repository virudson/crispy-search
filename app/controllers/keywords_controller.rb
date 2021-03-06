class KeywordsController < ApplicationController

  skip_before_action :authenticate_user!, except: [:new, :create]

  def index
    @q = Keyword.ransack(params[:q])
    @keywords = @q.result.includes(:adwords).page(params[:page]).per(params[:per_page])
  end

  def show
    @keyword = load_keyword
  end

  def cache_page
    @keyword = load_keyword

    # TODO: Find out why it not render correctly
    # render text: @keyword.html_source.html_safe layout: false
    send_data @keyword.html_source, type: 'text/html', filename: "cache_page_#{@keyword.id}.html"
  end

  def new
  end

  def create
    csv_content = params[:csv_file] ? params[:csv_file].read : nil

    if csv_content.blank?
      flash.now[:alert] = 'Cannot read csv file or content empty.'
      render :new
    else
      Keyword.create_form_csv(csv_content)
      redirect_to root_path, notice: 'Upload success'
    end
  end


  private

  def load_keyword
    Keyword.find(params[:id])
  end
end
