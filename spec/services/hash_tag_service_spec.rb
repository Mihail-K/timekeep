# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HashTagService, type: :service do
  let(:author) { create(:user) }
  let(:input) { 'Bacon! #bacon' }
  let(:service) { HashTagService.new(author, input) }

  describe '.fragments' do
    subject { service.fragments }

    it 'breaks up the input and returns hash-tag fragments' do
      should eq(['bacon'])
    end

    it "doesn't include duplicate fragments" do
      allow(service).to receive(:input).and_return('#food #bacon #bacon')
      should eq(%w[food bacon])
    end

    it 'converts fragments to lower case' do
      allow(service).to receive(:input).and_return('#BACON #Food')
      should eq(%w[bacon food])
    end
  end

  describe '.hash_tag' do
    let(:fragment) { 'foo-bar' }

    subject { service.hash_tag(fragment) }

    it 'returns a hash-tag that matches the input fragment' do
      hash_tag = create(:hash_tag, name: fragment)
      should eq(hash_tag)
    end

    it 'creates a new hash-tag when none match the input fragment' do
      expect do
        expect(subject.author).to eq(author)
        expect(subject.name).to eq('foo-bar')
      end.to change { HashTag.count }.by(1)
    end
  end

  describe '.hash_tags' do
    subject { service.hash_tags }

    before(:each) do
      allow(service).to receive(:fragments).and_return(%w[bacon food])
    end

    it 'returns a list of tags that correspond to the fragments' do
      expect(subject.map(&:name)).to contain_exactly('bacon', 'food')
    end
  end
end
