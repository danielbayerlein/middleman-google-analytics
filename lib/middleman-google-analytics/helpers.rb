require 'erubis'
require 'uglifier'
require 'active_support/core_ext/string/indent'

module Middleman
  module GoogleAnalytics
    module Helpers

      def google_analytics_tag
        options = extensions[:google_analytics].options

        return nil if options.disable

        file = File.join(File.dirname(__FILE__), "#{options.variant}.js.erb")
        context = { options: options }
        content = Erubis::FastEruby.new(File.read(file)).evaluate(context)

        if options.variant.to_sym == :analytics
          if options.output.to_sym == :html
            content = options.minify ? Uglifier.compile(content) : indent("\n" + content)
            content_tag(:script, content)
          else
            options.minify ? Uglifier.compile(content) : content
          end
        else
          if options.output.to_sym == :html
            content.gsub(/(?<=<script>)(.+)(?=<\/script>)/m) do
              options.minify ? Uglifier.compile($1) : indent($1)
            end
          else
            options.minify ? content.gsub(/.*<script>(.+)<\/script>/m) { Uglifier.compile($1) } : content
          end
        end
      end

      # Ugly but true
      def indent(content)
        str = ''
        content.each_line { |line| str << line.indent(2) }
        str
      end

    end
  end
end
