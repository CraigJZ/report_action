require 'report_action/version'

module ReportAction
  class Error < StandardError; end

  def initialize_report
    @report = {}
  end

  def report_item(target, group, message)
    @report[target] ||= {}
    @report[target][group] ||= []
    @report[target][group] << message
  end

  def build_report
    @report_body = ''
    @report.each do |target, groups|
      groups.each do |group, messages|
        @report_body += "<h1>#{group.capitalize}</h1>"
        messages.uniq.sort.each do |message|
          @report_body += "<p>#{message}</p>"
        end
      end
    end
  end
end
