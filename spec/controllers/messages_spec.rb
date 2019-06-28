RSpec.describe MessagesController do
  let(:message) {create(:message)}
  let(:chat) {create(:chat_with_messages, messages: [message])}
  let(:application) {create(:application_with_chats, chats: [chat])}
  let(:message_params) {attributes_for(:message)}

  describe 'POST create' do
    subject {post :create, application_token: application.token, chat_number: chat.chat_number, message: message_params}
    context 'when new message is inserted' do
      it { is_expected.to be_success }
      it 'no duplicates for messages message_number' do
        post :create, message: message_params
        first_message_number = JSON.parse(response.body)['message_number']
        post :create, message: message_params
        second_message_number = JSON.parse(response.body)['message_number']
        expect(first_message_number).not_to eq(second_message_number)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, application_token: application.token, chat_number: chat.chat_number, number: message.message_number, message: message_params}
    context 'when exists message is updated' do
      it {is_expected.to be_success}
      it 'updates the message_number of the message' do
        expected(message.message_number).to eq(message_params['message_number'])
      end
    end
  end

  descirbe 'GET show' do
    subject {get :show, application_token: application.token, chat_number: chat.chat_number, number: message.message_number}
    context 'when message exists' do
      it{is_expected.to be_success}
      it 'get the correct message' do
        expect(JSON.parse(response.body)['message_number']).to eq(message.message_number)
      end
    end
  end
end