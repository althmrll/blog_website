class Tag < ApplicationRecord
  belongs_to :post

  # CALLBACK: Format tag names (strip spaces, lowercase, remove leading '#')
  before_validation :format_tag_name

  private

  def format_tag_name
    return if name.blank?

    # "  #Rails 8 " -> "rails 8"
    self.name = name.strip.downcase.sub(/\A#/, "")
  end
end
