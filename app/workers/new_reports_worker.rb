class NewReportsWorker
  include Sidekiq::Worker

  sidekiq_options queue: 'reports', retry: true, failure: true

  def perform(start_date, end_date, recipient_email)
    report = User.build_report(start_date, end_date)

    ReportsMailer.new_report_by_author(report, recipient_email, start_date, end_date).deliver
  end
end
