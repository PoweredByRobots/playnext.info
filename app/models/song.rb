require 'pry'
class Song < ApplicationRecord
  has_many :branches

  alias branch branches

  validates_presence_of :artist, :title, :filename
  validate :valid_bpm?, :valid_key? 

  def key
    "#{key_number}#{key_letter}"
  end

  private

  def valid_key?
    valid_key_number? && valid_key_letter?
  end

  def valid_bpm?
    return if bpm.nil?
    return true if bpm.between?(30, 255)
    errors.add(:bpm, 'out of range (30 - 255)')
    false
  end

  def valid_key_number?
    return if empty_key?
    return true if key_number.between?(1, 12)
    errors.add(:key_number, 'out of range (1-12)')
    false
  end

  def valid_key_letter?
    return if empty_key?
    return true if key_letter.to_s.match?(/([a-b]|[A-B])/)
    errors.add(:key_letter, 'should be A or B')
    false
  end

  def empty_key?
    key_letter.nil? && key_number.nil?
  end
end
