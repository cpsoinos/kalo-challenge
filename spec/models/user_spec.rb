describe User do
  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity.allow_nil }
  it { should validate_uniqueness_of(:external_id).ignoring_case_sensitivity.allow_nil }
end
