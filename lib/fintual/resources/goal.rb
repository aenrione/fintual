# frozen_string_literal: true

module Fintual
  # for handling the total balance
  class Goal
    attr_reader :name, :current, :deposited, :profit, :created_at

    def initialize(name:, nav:, created_at:, deposited:, profit:, **)
      @name = name
      @deposited = deposited
      @current = nav
      @deposited = deposited
      @profit = profit
      @created_at = created_at
    end

    def to_s
      "#{name}: #{@current} (#{@deposited})"
    end

    def inspect
      "<Goal #{name}: #{@current} (#{@deposited})>"
    end
  end
end
