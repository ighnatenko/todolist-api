module SetCacheControlHeader
  extend ActiveSupport::Concern

  included { after_action :set_cache_control_header }

  private

  def set_cache_control_header
    response.headers['Cache-Control'] = 'no-cache, no-store'
  end
end