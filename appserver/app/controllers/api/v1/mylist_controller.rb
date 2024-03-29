class Api::V1::MylistController < ApplicationController

  before_action :authenticate_request!

  def list
    email = @decoded_api_token[:email]
    user = User.find_by(email: email)
    mylists = Mylist.where(user_id: user.id)
    qrcodeIds = mylists.map(&:qrcode_id)
    qrcodes = Qrcode.page(params[:page] ||= 1).includes([:user]).qrcodes_in(qrcodeIds, :DESC).per(6)
    render json: {
      status: 'OK',
      results: qrcodes.as_json(include: { user: { only: [:username] } }),
      meta: {
        current_page: qrcodes.current_page,
        next_page: qrcodes.next_page,
        prev_page: qrcodes.prev_page,
        total_pages: qrcodes.total_pages,
        total_count: qrcodes.total_count
      }
    }
  end

  def status
    qrcodeUuid = params[:id]
    email = @decoded_api_token[:email]
    user = User.find_by(email: email)

    qrcode = Qrcode.find_by(qrcode_uuid: qrcodeUuid)
    if qrcode == nil
      render json: {
        status: 'NG',
        error: {
          message: 'qrcode not found.'
        }
      }
      return
    end

    mylist = Mylist.where(user_id: user.id, qrcode_id: qrcode.id);
    render json: {
      status: 'OK',
      is_registered: mylist.count > 0
    }
  end

  # mode: 0
  # - remove
  # mode: 1
  # - add
  def add_or_remove

    mode = params[:mode] 
    qrcodeUuid = params[:id]

    if mode == nil || qrcodeUuid == nil
      render json: {
        status: 'NG',
        error: {
          message: 'request param invalid.'
        }
      }
      return
    end

    if mode == "0" || mode == "1"
      email = @decoded_api_token[:email]
      user = User.find_by(email: email)

      qrcode = Qrcode.find_by(qrcode_uuid: qrcodeUuid)
      if qrcode == nil
        render json: {
          status: 'NG',
          error: {
            message: 'qrcode not found.'
          }
        }
        return
      end

      if mode == "1"
        addedItem = Mylist.new(user_id: user.id, qrcode_id: qrcode.id)
        if addedItem.save
          render json: {
            status: 'OK',
            is_registered: true 
          }
        else
          render json: {
            status: 'OK',
            is_registered: false 
          }
        end

      else
        removedItem = Mylist.find_by(user_id: user.id, qrcode_id: qrcode.id)
        if removedItem.destroy
          render json: {
            status: 'OK',
            is_registered: false 
          }
        else
          render json: {
            status: 'OK',
            is_registered: true 
          }
        end
      end
   else
      render json: {
        status: 'NG',
        error: {
          message: 'request param invalid.'
        }
      }
    end

  end


end
