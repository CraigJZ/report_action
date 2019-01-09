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
    assert @report
  end

  def test_that_initial_report_is_empty_hash
    assert_equal @report, {}
  end

  def test_that_report_is_populated_with_report_items
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    assert_equal @report, 'Test Report' => { 'Test Section' => ['Test Message', 'Test Message Two'] }
  end

  def test_that_report_structures_multiple_groups
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section Two', 'Test Message')
    assert_equal @report, 'Test Report' => { 'Test Section' => ['Test Message'], 'Test Section Two' => ['Test Message'] }
  end

  def test_that_report_structures_multiple_targets
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report Two', 'Test Section', 'Test Message')
    assert_equal @report, 'Test Report' => { 'Test Section' => ['Test Message'] }, 'Test Report Two' => { 'Test Section' => ['Test Message'] }
  end

  def test_report_body_is_generated
    report_item('Test Report', 'Test Section', 'Test Message')
    report_item('Test Report', 'Test Section', 'Test Message Two')
    report_item('Test Report', 'Test Section Two', 'Test Message')
    build_report
    assert_equal @report_body, '<h1>Test section</h1><p>Test Message</p><p>Test Message Two</p><h1>Test section two</h1><p>Test Message</p>'
  end
end
