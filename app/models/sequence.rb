class Sequence < ApplicationRecord
  belongs_to :user
  has_many :recordings

  def self.generate_notes(key, scale, count)
    notes = Coltrane::Theory::Scale.send(scale,key).notes.map(&:name)
    Array.new(count) { notes.sample }
  end


end
