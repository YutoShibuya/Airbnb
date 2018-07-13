module ApplicationHelper
  def controller?(controller)
    #「params[:controller]」で現在のコントローラーを取得し、引数で受け取ったコントローラーに含んでいるかチェック
    controller.include?(params[:controller])
  end

  def action?(action)
      #「params[:action]」で現在のアクションを取得し、引数で受け取ったアクションに含んでいるかチェック
    action.include?(params[:action])
  end
end
