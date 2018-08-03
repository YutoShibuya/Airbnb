# check this url
# https://stripe.com/docs/checkout#integration-custom
$(document).ready ->
  return unless StripeCheckout?

  # Keeps track of whether we're in the middle of processing
  # a payment or not. This way we can tell if the 'closed'

  # event was due to a successful token generation, or the user
  # closing it by hand.
  submitting = false

  payButton = $('.pay-button')
  form = payButton.closest('form')
  indicator = form.find('.indicator').height( form.outerHeight() )
  handler = null

  createHandler = ->
    handler = StripeCheckout.configure
      # Grab the correct publishable key. Depending on
      # the selection in the interface.
      key: window.publishable["platform"]

      # The email of the logged in user.
      email: window.currentUserEmail

      #class 'processing' is a icon which loading
      #【学習】allowRememberMeをtrueにすると決済情報の保存確認チェックボックスが表示される
      allowRememberMe: false
　　　#【メモ】おそらく、決済情報入力の画面表示タイミングでもclosedが呼び出される
      closed: ->
        form.removeClass('processing') unless submitting

     #【学習】token:はcheckoutのプロセスが完了した後に呼び出される
     # そのため、ここで送信完了(submitting=true)と、トクーンIDをフォームに設定している
      token: ( token ) ->
        submitting = true
        # 【学習】checkoutの処理で生成された　tokenidを隠しフォームにセットする
        # セキュリティのため、お客様の情報はcheckout内で「トクーン化」される
        form.find('input[name=token]').val( token.id )
        # フォームを送信
        form.get(0).submit()
  createHandler()

  payButton.click ( e ) ->
    # 【学習】preventDefault()はイベントのキャンセル処理
    # フォームのボタンクリックイベントをキャンセルすることで、データ送信処理をいったん中断している
    e.preventDefault()
    form.addClass( 'processing' )

    handler.open
      name: 'お支払い額'
      description: window.totalPrice + " 円"
      amount: ''
