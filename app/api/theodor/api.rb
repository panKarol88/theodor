# frozen_string_literal: true

module Theodor
  class API < Grape::API
    mount V1::API => '/v1'
    mount AiDevs::API => '/ai_devs'
  end
end
