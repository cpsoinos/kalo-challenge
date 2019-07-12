module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter_by(filtering_params={})
      results = self.where(nil)
      filtering_params.each do |key, value|
        results = if !value.nil?
                    results.public_send(key, value)
                  else
                    results.public_send(key)
                  end
      end
      results
    end
  end

end
