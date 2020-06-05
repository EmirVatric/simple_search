# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Analitycs', type: :feature do
  before(:each) do
    @article = Article.create(title: 'New test article', content: 'New test article content')
    page.driver.browser.post('/search',
                             search: 'new',
                             activity: [32_423_423, 'new'])
    page.driver.browser.post('/search',
                             search: 'hello',
                             activity: [324_234_223, 'hello'])
  end

  scenario 'user can see number of seraches' do
    visit dashboard_path
    section = page.find('.total-searches')

    expect(section).to have_content('2')
  end

  scenario 'user can see number of articles' do
    visit dashboard_path
    section = page.find('.number-of-articles')

    expect(section).to have_content('1')
  end

  scenario 'user can see number of successfull seraches' do
    visit dashboard_path
    section = page.find('.successful-searches')

    expect(section).to have_content('1')
  end

  scenario 'user can see number of unsuccessfull seraches' do
    visit dashboard_path
    section = page.find('.unsuccesfull-searches')

    expect(section).to have_content('1')
  end

  scenario 'user can see successfull seraches' do
    visit dashboard_path
    expect(page).to have_content('new')
  end

  scenario 'user can see unsuccessfull seraches' do
    visit dashboard_path
    expect(page).to have_content('hello')
  end
end
