require 'rails_helper'

RSpec.describe ReportsMailer, type: :mailer do
  describe 'new_report_by_author(report, recipient_email, start_date, end_date)' do
    let(:start_date) { '10.10.2016' }
    let(:end_date) { '10.10.2017' }
    let!(:posts) { create_list :post, 2, published_at: '10.12.2016' }
    let!(:comments) { create_list :comment, 2, published_at: '10.12.2016' }
    let!(:report) { User.build_report(start_date, end_date) }

    it 'has appropriate subject' do
      mail = ReportsMailer.new_report_by_author(report, 'example@email.com', start_date, end_date)
      expect(mail).to have_subject('New report')
    end

    it 'sends from the default email' do
      mail = ReportsMailer.new_report_by_author(report, 'example@email.com', start_date, end_date)
      expect(mail).to be_delivered_from('admin@blog-test-task.co')
    end

    it 'sends to the subscriber' do
      mail = ReportsMailer.new_report_by_author(report, 'example@email.com', start_date, end_date)
      expect(mail).to be_delivered_to('example@email.com')
    end

    context 'HTML body' do
      it 'has the given headlines' do
        headlines = [
                      'Nickname',
                      'Email',
                      "Posts for period: from #{start_date} to #{end_date}",
                      "Comments for period: from #{start_date} to #{end_date}"
                    ]
        mail = ReportsMailer.new_report_by_author(report, 'example@email.com', start_date, end_date)

        headlines.each do |headline|
          html = %Q|<th>#{headline}</th>|
          expect(mail).to have_body_text(html)
        end
      end

      it 'includes the report collection' do
        mail = ReportsMailer.new_report_by_author(report, 'example@email.com', start_date, end_date)

        report.each do |user|
          expect(mail).to have_body_text(%Q|<td>#{user.nickname}</td>|)
          expect(mail).to have_body_text(%Q|<td>#{user.email}</td>|)
          expect(mail).to have_body_text(%Q|<td>#{user.posts_size}</td>|)
          expect(mail).to have_body_text(%Q|<td>#{user.comments_size}</td>|)
        end
      end
    end
  end
end
