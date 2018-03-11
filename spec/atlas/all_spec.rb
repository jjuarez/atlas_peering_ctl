# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Atlas do
  it 'has a version number' do
    expect(Atlas::VERSION).not_to be nil
  end
end
