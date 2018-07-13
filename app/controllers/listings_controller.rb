class ListingsController < ApplicationController
 #【学習】「before_action :authenticate_user!」の意味
 # [authenticate_user!]はdeviseを導入しいた際に定義されるヘルパーメソッド
 # ログイン済みのユーザーのみにアクセスを許可するメソッド
 # [before_action :authenticate_user!] の使い方をすることで、そのコントローラーのアクションが実行される前に
 # ログイン済みのユーザーか確認され、ログインしていない場合は、アクションは実行されない、且つ、ログイン画面に飛ばしてくれる
 # メッセージはフラッシュに格納されていて、トースターでハンドリングしているため、出ない。
  before_action :authenticate_user!
  before_action :set_listing, only: [:update, :basics, :description, :adress, :price, :photos, :calendar, :bankaccount, :publish]

  def index
  end

  def show
  end

  def new
    #　現在のユーザーのリスティングの作成
    # 【学習】[current_user]diviseのビューヘルパー。現在ログインしているユーザーをモデルオブジェクトとして取得する。
    #  userオブジェクトとlistingsオブジェクトはモデルに定義されたbelong_to,has_manyによって紐づいているため、この様な記述(.listings)で直接呼び出せる
    #  [build]は新規オブジェクトの作成。まだ保存されていない。saveで保存する。newとの違いはない(newのエイリアス)
    @listing = current_user.listings.build
  end

  def create
    @listing = current_user.listings.build(listing_params)

    if @listing.save
      redirect_to manage_listing_basics_path(@listing), notice: "リスティングを作成・保存しました"
    else
      redirect_to new_listing_path(@listing), notice: "リスティングを作成・保存出来ませんでした"
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      # redirect_to :back, notice: "更新できました"
      redirect_back fallback_location: root_path
    end
  end

  def basics
  end

  def description
  end

  def adress
  end

  def price
  end

  def photos
    @photo = Photo.new
  end

  def calendar
  end

  def bankaccount
  end

  def publish
  end

  private
  def listing_params
    params.require(:listing).permit(:home_type, :pet_type, :breeding_years, :pet_size, :price_pernight)
  end

  def set_listing
    @listing = Listing.find(params[:id])
  end
end