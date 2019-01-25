require 'report_action/version'

module ReportAction
  class Error < StandardError; end

  class Report

    def initialize
      @report_action = {}
    end

    def report_item(process, group, message)
      @report_action[process] ||= {}
      @report_action[process][group] ||= []
      @report_action[process][group] << message
    end

    def list_report_processes
      @report_action.collect { |p| p.shift }
    end

    def build_report(process)
      report_body = ''
      if @report_action.key?(process)
          @report_action[process].each do |group, messages|
            report_body += "<h1>#{group.capitalize}</h1>"
            messages.uniq.sort.each do |message|
              report_body += "<p>#{message}</p>"
            end
        end
      end
      report_body
    end

    def has_messages?(process, group)
      if @report_action.key?(process)
        @report_action[process].key?(group)
      end
    end

  end

end
