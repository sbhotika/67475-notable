module Transcribe
require "google/cloud/speech"
require "coreaudio"


  def self.transcribe
    speech = Google::Cloud::Speech.new
    input_device = CoreAudio.default_input_device
    input_buffer = input_device.input_buffer 1024
    streaming_config = {config: {encoding:                :LINEAR16,
                                 sample_rate_hertz:       input_device.actual_rate,
                                 language_code:           "en-US",
                                 # enable_word_confidence: true,
                                 enable_automatic_punctuation: true,
                                 enable_word_time_offsets: true     },
                        interim_results: true}
    stream = speech.streaming_recognize streaming_config
    puts "Voice transcription starting..."
    input_buffer.start

    150.times do
      # break if stream.stopped?
      bits = input_buffer.read(4096).to_a.map &:first
      sample = bits.pack("s<*")
      stream.send sample
    end

    input_buffer.stop
    stream.stop
    stream.wait_until_complete!
    results = stream.results

    results.first.alternatives.each do |alternatives|
      puts "Voice Transcription: #{alternatives.transcript}"
      puts "Confidence #{alternatives.confidence}"
      return alternatives.transcript
    end
  end

end
