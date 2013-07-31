module ActiveRecord
  class Base

    def update_without_timestamping(params)
      class << self
        def record_timestamps; false; end
      end

      # save!
      self.update_attributes(params)

      class << self
        remove_method :record_timestamps
      end
    end

    def update2_without_timestamping(param, value)
      class << self
        def record_timestamps; false; end
      end

      # save!
      self.update_attribute(param, value)

      class << self
        remove_method :record_timestamps
      end
    end

  end
end