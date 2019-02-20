class Song < ApplicationRecord
  has_many :branches

  alias branch branches
end
