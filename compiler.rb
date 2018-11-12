#!/usr/bin/env ruby

class Tokenizer
  TOKEN_TYPES = [
    [:def, /\bdef\b/],
    [:end, /\bend\b/],
    [:identifier, /\b[a-zA-Z]+\b/],
    [:integer, /\b[0-9]+\b/],
    [:oparen, /\(/],
    [:cparen, /\)/]
  ]

  def initialize(code)
    @code = code
    @tokens = []
  end

  def tokenize
    until @code.empty?
      @tokens << find_token

      @code = @code.strip
    end

    @tokens
  end

  def find_token
    TOKEN_TYPES.each do |type, re|
      match = @code.match(/\A(#{re})/)
      if match
        value = match[1]
        @code = @code[value.length..-1]
        return Token.new(type, value)
      end
    end
  end
end

Token = Struct.new(:type, :value)

tokens = Tokenizer.new(File.read("test.src")).tokenize
puts tokens
