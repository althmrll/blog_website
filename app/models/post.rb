class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
end


# before_save :format_tags

# private

# def format_tags
#   tags.each do |tag|
#     tag.name = tag.name.strip.replace(" ", "_") if tag.name.present?
#  end
# end
