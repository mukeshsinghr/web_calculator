RSpec.describe CalculatorController do
  describe "GET index" do
    it "assigns @teams" do
      
      get :index
expect(response).to render_template(:index)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end