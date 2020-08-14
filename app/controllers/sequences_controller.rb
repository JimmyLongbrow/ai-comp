class SequencesController < ApplicationController
  before_action :check_if_logged_in
  def new
    @sequence = Sequence.new
  end

  def create
    key = params[:sequence][:key]
    scale = params[:sequence][:scale]
    @sequence = Sequence.new sequence_params
    @sequence.user_id = @current_user.id
    @sequence.data = Sequence.generate_notes(key,scale,13)
    @sequence.save
    redirect_to sequences_path
  end

  def index
    @sequences = Sequence.all
  end

  def show
    @sequence = Sequence.find params[:id]
  end

  def edit
    @sequence = Sequence.find params[:id]
  end

  def update
    @sequence = Sequence.find params[:id]
    sequence.update sequence_params[:id]
    redirect_to( sequence_path(params[:id]) )
  end

  def destroy
    Sequence.destroy params[:id]
    redirect_to sequences_path
  end

  def download
    @sequence = Sequence.find params[:id]
    midi = @sequence.generate_midi_file()
    # file = Tempfile.new 'download'
    # Tempfile.create('download', encoding: 'ascii-8bit') do |file|
    #   midi.write(file)
    #   send_file file, filename: "#{@sequence.name}.mid", type: 'audio/midi'
    # end
    File.open('/tmp/download.mid', 'wb') { |file| midi.write(file) }
    # render plain: @sequence.name
    send_file '/tmp/download.mid', filename: "#{@sequence.name}.mid", type: 'audio/midi'

  end

  private

  def sequence_params
    params.require(:sequence).permit(:name,:key,:scale,:bpm)
  end

end
