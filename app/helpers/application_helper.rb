module ApplicationHelper
 
  def japan_date(date)
    y = date.year
    m = date.month
    d = date.day
    return "#{y} 年 #{m} 月 #{d} 日"
  end

end
