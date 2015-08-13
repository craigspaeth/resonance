module ApplicationHelper
  def num_to_k(num)
    num < 1000 ? num : (num.to_f / 1000.to_f).round(1).to_s.gsub(/\.0$/, '') + 'k'
  end
end
