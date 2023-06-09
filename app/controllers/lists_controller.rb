class ListsController < ApplicationController
  
  def new
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @list = List.new  
  end
  
  def create
    @list = List.new(list_params) #データを受け取り新規登録
    if @list.save
      flash[:notice] = "投稿が成功しました" #フラッシュメッセージを定義
    redirect_to list_path(@list.id)  #詳細画面へリダイレクト
    else
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end
  
  def destroy
    list = List.find(params[:id]) #データを１件取得
    list.destroy #データを削除
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end  
  
  # ストロングパラメータ
  private
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
