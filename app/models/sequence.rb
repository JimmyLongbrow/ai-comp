# $LOAD_PATH[0, 0] = File.join(File.dirname(__FILE__), '..', 'lib')
require 'midilib'
# require 'midilib/sequence'
# require 'midilib/consts'
# include MIDI
#
# MidiSequence = Sequence

class Sequence < ApplicationRecord
  belongs_to :user
  has_many :recordings

  NOTES_FROM_NAMES = {
  'C'   => 0,
  'Cb'  => 11,
  'Cbb' => 10,
  'C#'  => 1,
  'C##' => 2,
  'D'   => 2,
  'Db'  => 1,
  'Dbb' => 0,
  'D#'  => 3,
  'D##' => 4,
  'E'   => 4,
  'Eb'  => 3,
  'Ebb' => 2,
  'E#'  => 5,
  'F'   => 5,
  'Fb'  => 4,
  'Fbb' => 3,
  'F#'  => 6,
  'F##' => 7,
  'G'   => 7,
  'Gb'  => 6,
  'Gbb' => 5,
  'G#'  => 8,
  'G##' => 9,
  'A'   => 9,
  'Ab'  => 8,
  'Abb' => 7,
  'A#'  => 10,
  'A##' => 11,
  'B'   => 11,
  'Bb'  => 10,
  'Bbb' => 9,
  'B#'  => 12,
  'B##' => 13,
}




  def self.key_list
    ['C','C#','D','D#','E','F','F#','G','G#','A','#A','B']
  end
  def self.scale_list
    ['major','minor','flamenco','pentatonic_major','blues_major','blues_minor','harmonic_minor','hungarian_minor','pentatonic_minor','whole_tone','chromatic']
  end

  def self.generate_notes(key, scale, count)
    notes = Coltrane::Theory::Scale.send(scale,key).notes.map(&:name)
    Array.new(count) { notes.sample }
  end



  def generate_midi_file( octave= 2 )
    notes = JSON.parse data
    #turn the array of note names into an array of midi note numbers
    #starting at the specified octave.
    notes.map! do |n|
      Sequence::NOTES_FROM_NAMES[n] + (octave+1)*12
    end
    seq = MIDI::Sequence.new


    # Create a first track for the sequence. This holds tempo events and stuff
    # like that.
    track = MIDI::Track.new(seq)
    seq.tracks << track
    track.events << MIDI::Tempo.new(MIDI::Tempo.bpm_to_mpq(120))
    track.events << MIDI::MetaEvent.new(MIDI::META_SEQ_NAME, 'Sequence Name')

    # Create a track to hold the notes. Add it to the sequence.
    track = MIDI::Track.new(seq)
    seq.tracks << track

    # Give the track a name and an instrument name (optional).
    track.name = 'My New Track'
    track.instrument = MIDI::GM_PATCH_NAMES[0]

    # Add a volume controller event (optional).
    track.events << MIDI::Controller.new(0, MIDI::CC_VOLUME, 127)

    # Add events to the track: a major scale. Arguments for note on and note off
    # constructors are channel, note, velocity, and delta_time. Channel numbers
    # start at zero. We use the new Sequence#note_to_delta method to get the
    # delta time length of a single quarter note.
    track.events << MIDI::ProgramChange.new(0, 1, 0)
    quarter_note_length = seq.note_to_delta('quarter')
    notes.each do |offset|
      track.events << MIDI::NoteOn.new(0, offset, 127, 0)
      track.events << MIDI::NoteOff.new(0, offset, 127, quarter_note_length)
    end

    # Calling recalc_times is not necessary, because that only sets the events'
    # start times, which are not written out to the MIDI file. The delta times are
    # what get written out.

    # track.recalc_times

    # File.open('from_scratch.mid', 'wb') { |file| seq.write(file) }
    seq
  end # end of generate_midi_file

end
