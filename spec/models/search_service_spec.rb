# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchService do
  subject { described_class.new({ search: 'hello', session_identifier: 123_213_123 }, 1_231_231) }

  describe 'response' do
    context 'returns matched articles' do
      it 'returns maches from title' do
        article = Article.create(title: 'hello world', content: 'this doesnt include search word')
        expect(subject.search[:data].length).to eql(1)
      end

      it 'returns maches from content' do
        article = Article.create(title: 'world', content: 'this includes hello as searched word')
        expect(subject.search[:data].length).to eql(1)
      end
    end

    it 'returns error when no articles are found' do
      expect(subject.search[:error_message].length).to eql(1)
    end
  end

  describe 'db assertions' do
    it 'creates a new query' do
      subject.save_activity
      expect(Query.count).to eql(1)
    end

    it 'increments query counter' do
      subject.save_activity
      described_class.new({ search: 'hello', session_identifier: 123_213_123 }, 1_231_231).save_activity
      expect(Query.last.counter).to eql(2)
    end

    it 'decrements query counter' do
      subject.save_activity
      described_class.new({ search: 'hello', session_identifier: 123_213_123 }, 1_231_231).save_activity
      described_class.new({ search: 'hello world', session_identifier: 123_213_123 }, 1_231_231).save_activity
      expect(Query.first.counter).to eql(1)
    end

    it 'deletes old queries' do
      subject.save_activity
      described_class.new({ search: 'hello world', session_identifier: 123_213_123 }, 1_231_231).save_activity
      expect(Query.count).to eql(1)
    end
  end

  describe 'validations' do
    it 'removes special caracters' do
      described_class.new({ search: 'hello world()[]', session_identifier: 123_213_123 }, 1_231_231).save_activity
      expect(Query.last.query).to eql('hello world')
    end
  end
end
