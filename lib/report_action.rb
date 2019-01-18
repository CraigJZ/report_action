require 'report_action/version'

module ReportAction
  class Error < StandardError; end

  def initialize_report_action
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
    @report_body = ''
    @report_action[process].each do |group, messages|
      @report_body += "<h1>#{group.capitalize}</h1>"
      messages.uniq.sort.each do |message|
        @report_body += "<p>#{message}</p>"
      end
    end
    @report_action[process] = nil
  end

  def purge_report
    @report_action = nil
  end
end
