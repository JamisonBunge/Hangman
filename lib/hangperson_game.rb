class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  def word_with_guesses
    resp = ''
    @word.each_char do |x|
      if @guesses.include? x
        resp += x
      else
        resp += '-'
      end
    end
    resp
  end

  def check_win_or_lose

    if @word == ''
      return :play
    end

    if @word.chars.sort.uniq.join == @guesses.chars.sort.uniq.join
      return :win
    elsif @wrong_guesses.length > 6
      return :lose
    else
      return :play
    end
  end


  def guess(val)
    res = true
    raise ArgumentError unless val =~ /[A-Za-z]/
    val.downcase!

    if @word.include? val

      unless @guesses.include? val
        @guesses +=val
        res = true
      else
        res = false
      end

    elsif

      unless @wrong_guesses.include? val
        @wrong_guesses +=val
        res = true
      else
        res = false
      end

    end
    res
  end
end
