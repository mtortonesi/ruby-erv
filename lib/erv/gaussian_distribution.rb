require 'erv/distribution'


module ERV

  class GaussianDistribution < Distribution
    def initialize(opts={})
      super(opts)

      raise ArgumentError unless opts[:mean] and opts[:sd]
      @mu    = opts[:mean].to_f
      @sigma = opts[:sd].to_f
    end

    def sample
      # Use Box-Muller algorithm (see [KROESE11], section 4.2.11, algorithm
      # 4.47) to obtain x ~ N(0,1).
      u_1 = @rng.rand
      u_2 = @rng.rand
      x = Math.sqrt(-2.0 * Math.log(u_1)) * Math.cos(2.0 * Math::PI * u_2)

      # Use location-scale transformation to obtain a N(\mu, \sigma^2)
      # distribution. See [KROESE11], section 3.1.2.2.
      @mu + @sigma * x
    end

    def mean
      @mu
    end

    def variance
      @sigma ** 2
    end
  end

end
