class SearchController < ApplicationController

  def create
    @album = Album.find(params[:album_id])
    @q = params[:q]
    
    results = PgSearch.multisearch(params[:q])

    @videos = []

    results.where(searchable_type: 'Video').each do |v|
      video = Video.find(v.searchable_id)
      if video.album == @album
        @videos << video
      end
    end

    @pictures = []

    results.where(searchable_type: 'Picture').each do |p|
      picture = Picture.find(p.searchable_id)
      if picture.album == @album
        @pictures << picture
      end
    end

  end

end
