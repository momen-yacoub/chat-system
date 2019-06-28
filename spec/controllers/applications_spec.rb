RSpec.describe ApplicationsController do
  let(:application) {create(:application)}
  let(:application_params) {attributes_for(:application)}

  describe 'POST create' do
    subject {post :create, application: application_params}
    context 'when new application is inserted' do
      it { is_expected.to be_success }
      it 'no duplicates for applications tokens' do
        post :create, application: application_params
        first_token = JSON.parse(response.body)['token']
        post :create, application: application_params
        second_token = JSON.parse(response.body)['token']
        expect(first_token).not_to eq(second_token)
      end
    end
  end

  describe 'PUT update' do
    subject {put :update, id: application.token, application: application_params}
    context 'when exists application is updated' do
      it {is_expected.to be_success}
      it 'updates the desc of the application' do
        expected(application.desc).to eq(application_params['desc'])
      end
    end
  end

  descirbe 'GET show' do
    subject {get :show, id: application.token}
    context 'when application exists' do
      it{is_expected.to be_success}
      it 'get the correct application' do
        expect(JSON.parse(response.body)['token']).to eq(application.token)
      end
    end
  end
end