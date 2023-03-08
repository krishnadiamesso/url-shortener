class Url < ApplicationRecord
  # Validation
  validates :long_url, presence: true

  # Callbacks
  before_create :generate_short_url

  private

    def generate_short_url
      url_prefix = "short.url"
      url_code = SecureRandom.urlsafe_base64[0..5]
      short_url = "#{url_prefix}/#{url_code}"
      if Url.exists?(short_url: short_url)
        generate_short_url
      else
        self.short_url = short_url
      end
    end
end
