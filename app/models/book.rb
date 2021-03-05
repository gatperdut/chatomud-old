class Book < ApplicationRecord
  belongs_to :item

  has_many :posts, as: :parent, dependent: :destroy, inverse_of: :parent

  validates :item, presence: true

  validates_associated :posts

  validate :posts_pages_are_unique

  validate :page_count_is_greater_than_or_equal_to_real_post_count

  validate :page_count_is_greater_than_or_equal_to_current_page

  validate :has_no_pages_means_no_posts_if_untitled

  validate :current_page_is_one_or_greater_if_has_pages_and_open

  validate :current_page_is_zero_if_closed

  private

  def is_open?
    current_page.nil? || current_page.positive?
  end

  def is_closed?
    !is_open?
  end

  def post_count
    posts.count
  end

  def has_posts?
    post_count.positive?
  end

  def has_no_posts?
    post_count.zero?
  end

  def real_posts
    posts.reject do |post|
      post.page.zero?
    end
  end

  def real_post_count
    real_posts.count
  end

  def has_real_posts?
    real_post_count.positive?
  end

  def has_no_real_posts?
    real_post_count.zero?
  end

  def has_pages?
    page_count.positive?
  end

  def has_no_pages?
    page_count.zero?
  end

  def is_titled?
    posts.map(&:page).include?(0)
  end

  def is_not_titled?
    !is_titled?
  end

  def posts_pages_are_unique
    plucked = posts.map(&:page)
    uniqued = plucked.uniq

    return if plucked.count.zero?

    errors.add(:base, "associated posts pages are not unique") unless plucked.count == uniqued.count
  end

  def page_count_is_greater_than_or_equal_to_real_post_count
    errors.add(:page_count, "must be greater than or equal to the real posts count") unless page_count >= real_post_count
  end

  def page_count_is_greater_than_or_equal_to_current_page
    return if has_no_pages? || current_page.nil?

    errors.add(:page_count, "must be greater than or equal to current_page") unless page_count >= current_page
  end

  def has_no_pages_means_no_posts_if_untitled
    return if has_pages?

    return if has_no_posts?

    errors.add(:page_count, "is zero and there are more than 1 posts") if post_count > 1

    errors.add(:page_count, "is zero and the only post attached is not at page 0") if is_not_titled?
  end

  def current_page_is_one_or_greater_if_has_pages_and_open
    return if current_page.nil?

    errors.add(:current_page, "must be greater than or equal to 1 if has pages and open") if is_open? && current_page < 1
  end

  def current_page_is_zero_if_closed
    errors.add(:current_page, "must be 0 if the book is closed") if is_closed? && !current_page.zero?
  end
end
