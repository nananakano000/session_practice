class SessionsController < ApplicationController
  def index
    # ログインされているかを判断して、ログインされていたらインスタンス変数noticeを定義しています。
    if session[:user_name]
      @notice = "#{session[:user_name]}でログインしています。"
    end
 
    # ログインボタンを押した後に、セッションに情報が保存されるかを判断
    if params.key?(:name) || params.key?(:password)
      # params[:name]で、ユーザーがポストした値を取り出し、
      # その後find_by_nameメソッドで、入力したnameとカラムに保存されたnameが一致した場合にユーザーに代入しています。
      user = User.find_by_name(params[:name])
      # userで、userの中身があるのかどうかを判断し、user.authenticateでは今回userに代入された
      # レコードのパスワードがユーザーがポストした値と一致しているのか判断しています。
      if user && user.authenticate(params[:password])
        # セッションにユーザー名を登録しています。
        # session[:名前] はRailsにあらかじめ組み込まれているメソッドで、名前をつけて、セッションに登録できます。
        session[:user_name] = params[:name]
      else
        # セッションを破棄
        session[:user_name] = nil
      end
    end
  end
end
