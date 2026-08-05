class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :tags, dependent: :destroy

  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  def tag_list
    tags.map(&:name).join(" ")
  end
end
