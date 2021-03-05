class Post < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_one :text_info, as: :parent, dependent: :destroy, inverse_of: :parent

  validates_length_of :title, minimum: 1, maximum: 80, allow_blank: true

  validates_associated :text_info

  validate :page_set_if_parent_is_book

  validate :page_is_within_bounds_if_parent_is_book

  validate :page_nil_if_parent_is_not_book

  validate :title_set_if_parent_is_board

  validate :title_nil_if_parent_is_not_board

  validate :content_and_text_info_set_unless_parent_is_writing

  private

  def page_set_if_parent_is_book
    errors.add(:page, "must be set if parent is book") if parent.is_a?(Book) && page.nil?
  end

  def page_is_within_bounds_if_parent_is_book
    return unless parent.is_a?(Book) && !page.nil?

    errors.add(:page, "must be between 0 and the book's page_count") if page.negative? || page > parent.page_count
  end

  def page_nil_if_parent_is_not_book
    errors.add(:page, "must be nil if parent is not book") if !parent.is_a?(Book) && page
  end

  def title_set_if_parent_is_board
    errors.add(:title, "must be present if parent is board") if parent.is_a?(Board) && title.nil?
  end

  def title_nil_if_parent_is_not_board
    errors.add(:title, "must be nil if parent is not board") if !parent.is_a?(Board) && title
  end

  def content_and_text_info_set_unless_parent_is_writing
    return if parent.is_a?(Writing)

    errors.add(:content, "must be present if parent is not Writing") unless content.present?

    errors.add(:text_info, "must be present if parent is not Writing") unless text_info.present?
  end
end
