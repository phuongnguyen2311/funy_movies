require 'nokogiri'
require 'open-uri'
class MoviesService
  def initialize(current_user, params)
    @params = params
    @current_user = current_user
  end

  def execute
    post = Post.new
    post.user = current_user
    if valid_youtube_url?
      doc = crawl_data(params[:youtube_url]) if params[:youtube_url].present?
      post.title = doc.css('title')&.first&.content&.strip
      post.description = doc.css('meta')[3]&.attributes['content']&.value
      post.youtube_url = youtube_embed(params[:youtube_url])
    else
      post.errors.add(:youtube_url, 'Invalid Youtube url')
    end
    post
  end

  private

  attr_reader :current_user, :params

  def valid_youtube_url?
    params[:youtube_url].match(%r{^(?:https?://)?(?:www\.)?youtu(?:\.be|be\.com)/(?:watch\?v=)?([\w-]{10,})}).present?
  end

  def youtube_embed(youtube_url)
    if youtube_url[%r{youtu\.be/([^?]*)}]
      youtube_id = Regexp.last_match(1)
    else
      youtube_url[%r{^.*((v/)|(embed/)|(watch\?))\??v?=?([^&?]*).*}]
      youtube_id = Regexp.last_match(5)
    end
    "http://www.youtube.com/embed/#{youtube_id}"
  end

  def crawl_data(url)
    user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2'
    Nokogiri::HTML.parse(URI.open(url, { 'User-Agent' => user_agent }), nil, 'UTF-8')
  end
end
