module NetworkHelper
  def network_id
    :network
  end

  alias :network_class :network_id

  def network_options
    {
      id: network_id,
      class: network_class,
      data: {
        target: 'component.network'
      }
    }
  end

  class NetworkLink
    def self.new(*args)
      klass = case args.first
        when BasicProfile
          BasicProfileLink
        when AggregateProfile
          AggregateProfileLink
        end
      
      klass.new *args
    end

    class BasicProfileLink
      include ActiveModel::Model

      attr_accessor :profile

      def initialize(profile)
        @profile = profile
      end

      def to_key
        profile.to_key
      end
    end

    class AggregateProfileLink
      include ActiveModel::Model

      attr_accessor :profile

      def initialize(profile)
        @profile = profile
      end

      def to_key
        profile.to_key
      end
    end
  end

  def network_links
    profiles.map { |profile| NetworkLink.new profile }
  end
end
