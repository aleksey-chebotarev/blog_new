module ApplicationHelper
  def build_report(start_date, end_date)
    User
      .joins("LEFT OUTER JOIN posts ON users.id = posts.author_id AND posts.published_at BETWEEN '#{start_date}' AND '#{end_date}'")
      .joins("LEFT OUTER JOIN comments ON users.id = comments.author_id AND comments.published_at BETWEEN '#{start_date}' AND '#{end_date}'")
      .select('users.id, users.email, users.nickname, COUNT(DISTINCT posts.id) AS posts_size, COUNT(DISTINCT comments.id) AS comments_size')
      .having('COUNT(posts.id) > 0 OR COUNT(comments.id) > 0')
      .group('users.id')
      .sort_by { |user| user.posts_size + user.comments_size / 10 }.reverse
  end
end
