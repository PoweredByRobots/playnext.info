class Song < ApplicationRecord
  has_many :branches
  
  alias branch branches

  validates_presence_of :artist, :title
  validate :valid_key_number?, :valid_key_letter?

  private

  def key
    "#{key_number}#{key_letter}"
  end

  def valid_key?
    valid_key_number? && valid_key_letter?
  end

  def valid_key_number?
    return if empty_key? || key_number.between?(1, 12)
    errors.add(:key_number, 'out of range (1-12)')
  end

  def valid_key_letter?
    return if empty_key? || key_letter.to_s.match?(/([a-b]|[A-B])/)
    errors.add(:key_letter, 'Should be A or B')
  end

  def empty_key?
    key_letter.nil? && key_number.nil?
  end
end
