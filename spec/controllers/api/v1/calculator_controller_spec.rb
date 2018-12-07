require 'rails_helper'

RSpec.describe Api::V1::CalculatorController, :type => :controller do
  
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "Post perform_calculation#perform_calculation" do
    
    it "has a 200 status code" do
      post :perform_calculation, params: { :expression => '1+2' }
      expect(response.status).to eq(200)
    end

    it "exception case when required parameters are not passed" do
      expect{ post(:perform_calculation, {}) }.to raise_error ActionController::ParameterMissing
    end

    it "Return result of sum 1+2 = 3" do
      post :perform_calculation, params: { :expression => '1+2' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(3)
    end

    it "Return result of sum 5*3+1+6/85+9*100 = 916.07" do
      post :perform_calculation, params: { :expression => '5*3+1+6/85+9*100' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(916.07)
    end

    it "Return result of sum 5*3+1+6/2+9*100 = 919" do
      post :perform_calculation, params: { :expression => '5*3+1+6/2+9*100' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(919)
    end

    it "Return result of multiply 3*2*3 = 18" do
      post :perform_calculation, params: { :expression => '3*2*3' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(18)
    end

    it "Return result of Division 15/2 = 7.5" do
      post :perform_calculation, params: { :expression => '15/2' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(7.5)
    end

    it "Return result of Minus 15-2 = 13" do
      post :perform_calculation, params: { :expression => '15-2' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(13)
    end

    it "Return result of expression with decimals 14.4/2 = 7.2" do
      post :perform_calculation, params: { :expression => '14.4/2' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq(7.2)
    end
    
    it "Return result of Incorrect input expression 3*2*3+qw = 18" do
      post :perform_calculation, params: { :expression => '3*2*3*qw' }
      json_response = JSON.parse(response.body)
      expect(json_response['result']).to eq('Incorrect expression or Number')
    end
  end

end