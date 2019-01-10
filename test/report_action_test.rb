require 'test_helper'

class ReportActionTest < Minitest::Test
  include ReportAction
  def test_that_it_has_a_version_number
    refute_nil ::ReportAction::VERSION
  end

  def setup
    initialize_report
  end

  def test_that_it_has_a_report
    assert @report_action
  end

  def test_that_initial_report_is_empty_hash
    assert_equal @report_action, {}
  end

  def test_that_report_is_populated_with_report_items
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    assert_equal @report_action, 'Test Report' => { 'Test Section' => ['Test Message', 'Test Message Two'] }
  end

  def test_that_report_structures_multiple_groups
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section Two', 'Test Message')
    assert_equal @report_action, 'Test Report' => { 'Test Section' => ['Test Message'], 'Test Section Two' => ['Test Message'] }
  end

  def test_that_report_structures_multiple_processes
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report Two', 'Test Section', 'Test Message')
    assert_equal @report_action, 'Test Report' => { 'Test Section' => ['Test Message'] }, 'Test Report Two' => { 'Test Section' => ['Test Message'] }
  end

  def test_report_body_is_generated_for_first_process
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report Two', 'Test Section Two', 'Test Message')
    build_report('Test Report')
    assert_equal @report_body, '<h1>Test section</h1><p>Test Message</p><p>Test Message Two</p>'
  end

  def test_report_body_is_generated_for_second_process
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report Two', 'Test Section Two', 'Test Message')
    build_report('Test Report Two')
    assert_equal @report_body, '<h1>Test section two</h1><p>Test Message</p>'
  end

  def test_report_body_is_generated_for_two_processes
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report Two', 'Test Section Two', 'Test Message')
    build_report('Test Report')
    report_one = @report_body
    build_report('Test Report Two')
    report_two = @report_body
    assert_equal report_one, '<h1>Test section</h1><p>Test Message</p><p>Test Message Two</p>'
    assert_equal report_two, '<h1>Test section two</h1><p>Test Message</p>'
  end

  def test_report_action_process_is_set_to_nil_after_report_build
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report Two', 'Test Section Two', 'Test Message')
    build_report('Test Report')
    assert_nil @report_action['Test Report']
    assert_equal @report_action, 'Test Report' => nil, 'Test Report Two' => { 'Test Section Two' => ['Test Message'] }
  end

  def test_report_action_process_remains_for_processes_not_built
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report Two', 'Test Section Two', 'Test Message')
    build_report('Test Report')
    assert_equal @report_action['Test Report Two'], 'Test Section Two' => ['Test Message']
    assert_equal @report_action, 'Test Report' => nil, 'Test Report Two' => { 'Test Section Two' => ['Test Message'] }
  end

  def test_that_entire_report_can_be_purged
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report Two', 'Test Section', 'Test Message')
    assert_equal @report_action, 'Test Report' => { 'Test Section' => ['Test Message'] }, 'Test Report Two' => { 'Test Section' => ['Test Message'] }
    purge_report
    assert_nil @report_action
  end
end
