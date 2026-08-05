class Tag < ApplicationRecord
  belongs_to :post
  before_validation :format_tag_name

  private

  def format_tag_name
    return if name.blank?
    tags= name.split(/\s+/).map { |w| w.strip.downcase.sub(/\A#/, "") }.reject(&:blank?)
    return if tags.empty?

    self.name = tags.first

    if tags.length > 1 && post
      tags.each do |extra_word|
        post.tags.build(name: extra_word)
      end
    end
  end
end
