require 'test_helper'

class ReportActionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ReportAction::VERSION
  end

  def setup
    @my_report = ReportAction::Report.new
  end

  def test_build_report_is_empty
    assert_equal @my_report.build_report('test'), ''
  end

  def test_report_is_built_for_first_process
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    @my_report.report_item('Test Report', 'Test Section', 'Test Message Two')
    @my_report.report_item('Test Report Two', 'Test Section Two', 'Test Message')
    assert_equal @my_report.build_report('Test Report'), '<h1>Test section</h1><p>Test Message</p><p>Test Message Two</p>'
  end

  def test_report_is_built_for_second_process
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    @my_report.report_item('Test Report', 'Test Section', 'Test Message Two')
    @my_report.report_item('Test Report Two', 'Test Section Two', 'Test Message')
    assert_equal @my_report.build_report('Test Report Two'), '<h1>Test section two</h1><p>Test Message</p>'
  end

  def test_report_is_built_for_two_groups_in_a_process
    @my_report.report_item('Test Report', 'Test Group', 'Test Message')
    @my_report.report_item('Test Report', 'Test Group Two', 'Test Message Two')

    assert_equal @my_report.build_report('Test Report'), '<h1>Test group</h1><p>Test Message</p><h1>Test group two</h1><p>Test Message Two</p>'
  end

  def test_report_is_built_for_two_processes
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    @my_report.report_item('Test Report', 'Test Section', 'Test Message Two')
    @my_report.report_item('Test Report Two', 'Test Section Two', 'Test Message')
    report_one = @my_report.build_report('Test Report')
    report_two = @my_report.build_report('Test Report Two')
    assert_equal report_one, '<h1>Test section</h1><p>Test Message</p><p>Test Message Two</p>'
    assert_equal report_two, '<h1>Test section two</h1><p>Test Message</p>'
  end

  def test_that_process_list_is_returned
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    @my_report.report_item('Test Report Two', 'Test Section', 'Test Message')
    process_list = @my_report.list_report_processes
    assert_equal process_list, ["Test Report", "Test Report Two"]
  end

  def test_has_messages_with_missing_process_returns_false
    refute @my_report.has_messages?("Missing Process","Missing Group")
  end

  def test_has_messages_with_missing_group_returns_false
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    refute @my_report.has_messages?("Test Report","Missing Group")
  end

  def test_has_messages_with_messages_returns_true
    @my_report.report_item('Test Report', 'Test Section', 'Test Message')
    assert_equal @my_report.has_messages?("Test Report","Test Message"), false
  end
end
