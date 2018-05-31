class CelebWikisController < ApplicationController
  before_action :set_celeb_wiki, only: [:show, :edit, :update, :destroy]

  # GET /celeb_wikis/1
  # GET /celeb_wikis/1.json
  def show
    redirect_to celebrity_path(@celeb_wiki.celebrity)
  end

  # GET /celeb_wikis/new
  def new
    @celeb_wiki = CelebWiki.new
    @celeb = Celebrity.find(params[:celebrity_id])
  end

  # GET /celeb_wikis/1/edit
  def edit
    if user_signed_in?
      @celeb = @celeb_wiki.celebrity
      @celeb_wikis = CelebWiki.where(celebrity: @celeb)
    else
      flash[:notice] = '로그인 후 이용하실 수 있습니다.'
      redirect_back(fallback_location: celeb_wiki_path(@celeb_wikis))
    end
  end

  # POST /celeb_wikis
  # POST /celeb_wikis.json
  def create
    @celeb_wiki = CelebWiki.new(celeb_wiki_params)

    respond_to do |format|
      if @celeb_wiki.save
        format.html { redirect_to @celeb_wiki, notice: 'Celeb wiki was successfully created.' }
        format.json { render :show, status: :created, location: @celeb_wiki }
      else
        format.html { render :new }
        format.json { render json: @celeb_wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /celeb_wikis/1
  # PATCH/PUT /celeb_wikis/1.json
  # Wiki는 수정작업 시 새로운 레코드 생성
  def update
    respond_to do |format|
      @celeb_wiki = CelebWiki.new(celeb_wiki_params)

      if @celeb_wiki.save
        format.html { redirect_to @celeb_wiki, notice: 'Celeb wiki was successfully updated.' }
        format.json { render :show, status: :ok, location: @celeb_wiki }
      else
        format.html { render :edit }
        format.json { render json: @celeb_wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /celeb_wikis/1
  # DELETE /celeb_wikis/1.json
  def destroy
    @celeb_wiki.destroy
    respond_to do |format|
      format.html { redirect_to celeb_wikis_url, notice: 'Celeb wiki was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_celeb_wiki
      @celeb_wiki = CelebWiki.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def celeb_wiki_params
      params.require(:celeb_wiki).permit(:user_id, :celebrity_id, :content)
    end
end
