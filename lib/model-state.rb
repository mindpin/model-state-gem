require "mongoid"

require "model-state/version"
require "model-state/errors"
require "model-state/state_field"

module ModelState
  def self.included(base)
    base.send :extend, ClassMethods

    base.scope :on_states, lambda {|states|
      validate_states!(states.keys)
      base.where(states)
    }

    base.delegate :state_fields, :to => :class
    base.delegate :validate_states!, :to => :class
  end

  def set_states(states = {})
    validate_states!(states.keys)
    self.update_attributes(states)
  end

  def get_states(*state_names)
    validate_states!(state_names)
    state_names.reduce({}) do |hash, name|
      hash[name] = self.send name
      hash
    end
  end

  def on_states?(states = {})
    validate_states!(states.keys)
    states.all? do |name, state|
      self.send(name) == state
    end
  end

  def set_state(name, state)
    self.set_states(name => state)
  end

  def get_state(name)
    self.get_states(name)[name]
  end

  def on_state?(name, state)
    self.on_states?(name => state)
  end

  module ClassMethods
    def state_fields
      @states ||= {}
    end

    def add_state(name, states: [], default: nil)
      state_fields[name] = StateField.new(:name    => name,
                                          :states  => states,
                                          :default => default,
                                          :model   => self)

      define_method "#{name}=" do |state|
        write_attribute name, state.upcase
      end
    end

    def validate_states!(states)
      InvalidState.raise! do
        states.any? do |state|
          !self.state_fields.keys.include?(state)
        end
      end
    end
  end
end
