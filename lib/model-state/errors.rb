module ModelState
  class Error < Exception
    def self.raise!(msg = nil, &cond)
      raise self.new(msg) if !cond || cond.call
    end
  end

  InvalidState = Class.new(Error)
end
