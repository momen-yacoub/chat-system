RSpec.describe ChatsController do
  let(:chat) {create(:chat)}
  let(:application) {create(:application_with_chats, chats: [chat])}
  let(:chat_params) {attributes_for(:chat)}

  describe 'POST create' do
    subject {post :create, application_token: application.token, chat: chat_params}
    context 'when new chat is inserted' do
      it { is_expected.to be_success }
      it 'no duplicates for chat chat_number' do
        post :create, chat: chat_params
        first_chat_number = JSON.parse(response.body)['chat_number']
        post :create, chat: chat_params
        second_chat_number = JSON.parse(response.body)['chat_number']
        expect(first_chat_number).not_to eq(second_chat_number)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, application_token: application.token, number: chat.chat_number, chat: chat_params}
    context 'when exists chat is updated' do
      it {is_expected.to be_success}
      it 'updates the chat_number of the chat' do
        expected(chat.desc).to eq(chat_params['chat_number'])
      end
    end
  end

  descirbe 'GET show' do
    subject {get :show, application_token: application.token, number: chat.token}
    context 'when chat exists' do
      it{is_expected.to be_success}
      it 'get the correct chat' do
        expect(JSON.parse(response.body)['chat_number']).to eq(chat.chat_number)
      end
    end
  end
end