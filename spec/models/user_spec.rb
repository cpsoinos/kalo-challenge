describe User do
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity.allow_nil }
  it { should validate_uniqueness_of(:external_id).ignoring_case_sensitivity.allow_nil }
  it { should validate_presence_of(:name) }

  describe 'scopes' do
    describe 'by_timezone' do
      let!(:est_users) { create_list(:user, 3, timezone: 'EST') }
      let!(:pst_users) { create_list(:user, 2, timezone: 'PST') }

      it 'scopes by timezone' do
        expect(User.by_timezone('EST')).to match_array(est_users)
      end
    end

    describe 'with_skill' do
      let!(:excited_users) { create_list(:user, 3, skills: ['Clapping', 'Dancing']) }
      let!(:angry_users) { create_list(:user, 4, skills: ['Stomping', 'Bashing']) }
      let!(:undecided_users) { create_list(:user, 2, skills: ['Clapping', 'Stomping']) }

      it 'finds users with a particular skill' do
        expect(User.with_skill('Dancing')).to match_array(excited_users)
        expect(User.with_skill('Clapping').count).to eq(5)
        expect(User.with_skill('Stomping').count).to eq(6)
        expect(User.with_skill('Bashing').count).to eq(4)
      end
    end

  end
end
