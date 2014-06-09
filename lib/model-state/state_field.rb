module ModelState
  class StateField
    attr_reader :name, :states, :default, :model

    def initialize(name: nil, states: [], default: nil, model: nil)
      @name    = name
      @states  = states
      @default = default
      @model   = model

      validate!
      setup_state!
    end

    private

    def setup_state!
      model.field name, :type => Symbol, :default => default.upcase
      model.validates name, :inclusion => {:in => states.map(&:upcase)}
    end

    def validate!
      InvalidState.raise! do
        !name.is_a?(Symbol)    ||
        !states.is_a?(Array)   ||
        states.blank?          ||
        !default.is_a?(Symbol) ||
        !states.include?(default)
      end
    end
  end
end
