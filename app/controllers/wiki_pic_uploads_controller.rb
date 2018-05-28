class WikiPicUploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @upload = WikiPicUpload.new(upload_params)
    @upload.save

    urls = ""
    ids = ""
    count = 0
    length = @upload.wiki_pics.length
    @upload.wiki_pics.each do |image|
      count += 1
      urls += image.url
      ids += @upload.id.to_s
      if count != length
        urls += ","
        ids += ","
      end
    end

    respond_to do |format|
      format.json { render :json => {count: length, url: urls, upload_id: ids } }
    end
  end

  def destroy
    # 파일 삭제는 하지 않음
    # 파일 삭제구현 dreamplanet에 있음
  end

  private

  def upload_params
    params.require(:upload).permit({wiki_pics: []})
  end
end
