class PartiesController < ApplicationController
  def create
    output = {'foo' => 'bar'}.to_json
    render :json => output, :status => :ok
  end
end
