require "./formatters/formatter"

module HI8
  class Format(Formatter)

    getter formatters

    def initialize
      @formatters = {} of Symbol => Formatter
    end

    def [](name)
      @formatters.fetch(name) do
        @formatters[name] = case name
                            when :yaml then HI8::Formatter::YAML.new
                            when :json then HI8::Formatter::JSON.new
                            else raise "The requested VCR formatter #{name.to_s} is not registerd."
                            end
      end
    end

    def []=(name, format)
      @formatters[name] = format
    end
  end
end
