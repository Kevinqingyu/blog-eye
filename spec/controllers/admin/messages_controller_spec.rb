require 'rails_helper'

RSpec.describe Admin::MessagesController, :type => :controller do
  let(:message) {
    create(:valid_message,
        user: current_user,
        sender: build_stubbed(:valid_user),
        target: build_stubbed(:valid_reply)
  ) }

  describe ":index" do
    it "should show all messages" do
      sign_in
      get :index
      visit admin_messages_path
      expect(response.status).to be(200)
    end
  end

  describe ":show" do
    it "should show one message" do
      sign_in

      # get :show, { id: message.id }
      # visit admin_message_path(message)
      # expect(response.status).to be(200)
    end
  end

  describe ":destroy" do
    it "should destroy one message" do
      sign_in

      delete :destroy, id: message.id
      visit admin_message_path(message)
      expect(response.status).to be(302)
    end
  end
end
