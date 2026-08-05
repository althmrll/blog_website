class Tag < ApplicationRecord
  belongs_to :post
  before_validation :format_tag_name

  private

  def format_tag_name
    return if name.blank?
    self.name = name.strip.downcase.sub(/\A#/, "")
  end
end
